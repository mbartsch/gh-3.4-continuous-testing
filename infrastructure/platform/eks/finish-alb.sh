CLUSTER_NAME=continuous-testing
AWS_ACCOUNT_ID=$(aws sts --output json  get-caller-identity | jq -r ".Account")

eksctl create cluster -n $CLUSTER_NAME -f cluster.yaml
echo "Enable OIDC"
eksctl utils associate-iam-oidc-provider \
    --region eu-west-1 \
    --cluster $CLUSTER_NAME \
    --approve

echo "Creating JENKINS Service Account"
eksctl create iamidentitymapping \
  --arn $(eksctl get iamserviceaccount --namespace=jenkins \
  --name=jenkins-agent --cluster=$CLUSTER_NAME -o json | \
  jq -r '.iam.serviceAccounts[0].status.roleARN') --username jenkins \
  --group "system:masters" --cluster $CLUSTER_NAME

echo "configuring AWSLoadBalancerController"
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json

eksctl create iamserviceaccount \
--cluster=$CLUSTER_NAME \
--namespace=kube-system \
--name=aws-load-balancer-controller \
--attach-policy-arn=arn:aws:iam::$AWS_ACCOUNT_ID:policy/AWSLoadBalancerControllerIAMPolicy \
--approve


helm repo add eks https://aws.github.io/eks-charts

kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"

helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system --set clusterName=$CLUSTER_NAME --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller

echo "Setting up namespaces"
for ns in monitoring jenkins qa prod; do kubectl create ns $ns; done

#!/bin/bash

echo "Setting up ALB Ingress Controller RBAC"
kubectl apply -f alb-ingress-controller-rbac.yaml

echo "Installing ALB Ingress Controller via Helm"
helm upgrade ingress-controller incubator/aws-alb-ingress-controller --debug --install --wait --version 1.0.0 --namespace kube-system --values alb-ingress-controller.yaml

echo "Setting up namespaces"
for ns in monitoring jenkins qa prod; do kubectl create ns $ns; done 

echo "Setting up jenkins agent access"
eksctl create iamidentitymapping --arn $(eksctl get iamserviceaccount --namespace=jenkins --name=jenkins-agent --cluster=continuous-testing -o json | jq -r '.iam.serviceAccounts[0].status.roleARN') --username jenkins --group "system:masters" --cluster continuous-testing

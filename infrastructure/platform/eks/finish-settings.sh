#!/bin/bash

echo "Setting up ALB Ingress Controller RBAC"
kubectl apply -f alb-ingress-controller-rbac.yaml

echo "Installing ALB Ingress Controller via Helm"
helm3 upgrade ingress-controller incubator/aws-alb-ingress-controller --debug --install --wait --version 1.0.0 --namespace kube-system --values alb-ingress-controller.yaml

echo "Setting up namespaces"
for ns in monitoring jenkins qa prod; do kubectl create ns $ns; done 

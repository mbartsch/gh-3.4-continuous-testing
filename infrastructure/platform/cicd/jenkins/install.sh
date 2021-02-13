#!/bin/bash
helm repo add jenkins https://charts.jenkins.io
helm repo update
helm upgrade jenkins jenkins/jenkins --values values_bc.yaml --debug --wait --install --namespace jenkins

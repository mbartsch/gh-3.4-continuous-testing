#!/bin/bash

helm upgrade jenkins stable/jenkins --values custom_values.yaml --debug --wait --install --namespace jenkins

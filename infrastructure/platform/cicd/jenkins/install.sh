#!/bin/bash

helm3 upgrade jenkins stable/jenkins --values custom_values.yaml --debug --wait --install --namespace jenkins

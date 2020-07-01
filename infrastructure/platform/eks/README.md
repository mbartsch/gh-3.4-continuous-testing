# EKS Setup

Este setup hace uso de [eksctl](eksctl.io) para la creación de un cluster Kubernetes manejado por AWS via EKS, en este ejemplo tenemos una configuración
muy simple que crea un cluster de EKS en su propia VPC y haciendo uso de Managed Worker Nodes que escalan de 1 a 10 nodos.

Para crear el cluster ejecutar:

```bash
$ eksctl create cluster -f cluster.yaml
```

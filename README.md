# 3.4 Continuos Testing

Para desplegar el cluster de Kubernetes deben ejecutar los siguientes pasos:

* Editar el archivo [cluster.yaml](infrastructure/platform/eks/cluster.yaml)
* Cambiar donde dice 
  ```
  metadata:
    name: continuous-testing
  ````
  Y en name poner un nombre unico, por ejemplo su apellido
* una vez hecho esto seguir las instrucciones del [README.md](infrastructure/platform/eks/README.md)
* una vez que el cluster este creado , ejecutar lo siguiente:
````shell
cd infrastructure/platform/eks
bash finish-settings.sh
````
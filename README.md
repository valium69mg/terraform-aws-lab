# Proyecto para provisionar una instancia EC2 t2.medium

Este proyecto usa Terraform (IaC) para provisionar una instancia EC2 t2.medium,
con un volumen de 50GB, reglas de entrada/salida abstrayendo la configuración
en variables de entorno y en archivos de variables .tf.

## Generar SSH keys

Se necesita generar llaves SSH para la autenticación del acceso de
la instancia EC2.

```bash
ssh-keygen -t rsa -b 4096 -f C:/Users/carlo/Downloads/terraform-aws-lab/terraform/.ssh/id_rsa
```

## Se necesita un archivo .env dentro de terraform/

Se debe generar un archivo .env a partir del .env.example,
dentro de terraform/ ejecutar el siguiente comando:

```bash
cp .env.example .env
```

Después se debe rellenar el AWS_ACCESS_KEY_ID y AWS_SECRET_ACCESS_KEY
generado en la consola de AWS dentro de la sección de IAM para el usuario
que ejecuta el terraform.

## Se debe cargar las variables de entorno

Dentro de la carpeta terraform se debe settear las variables de entorno
generadas en el paso anterior con el siguiente comando.

```bash
.\load_env.ps1
```

(Si no se tienen permisos solo copiar y pegar el contenido)

## Inicializar Terraform

Se debe inicializar terraform para descargar los providers y peparar
el proyecto.

```bash
terraform init
```

## Verificar qué se creará

Se debe verificar antes el plan para ver lo que se creará y estar
seguro que la configuración es correcta.

```bash
terraform plan
```

## Aplicar el plan

El paso para aplicar el plan que levanta la instancia EC2 con las
configuraciones anteriores.

```bash
terraform apply
```

## Conectarse por SSH

Para comprobar que la instancia está en línea se hace ssh con:

```bash
ssh -i "C:\Users\carlo\Downloads\terraform-aws-lab\terraform\.ssh\id_rsa" ubuntu@54.227.20.244
```

## Generar inventario de ansible

Para generar el inventario necesario para instalar los paquetes necesarios
en nuestra nueva instancia se ejecuta lo siguiente:

```bash
cd ..\ansible
.\generate_inventory.ps1
```

## Ejecutar playbook de ansible para instalar los paquetes necesarios

```bash
ansible-playbook playbooks/docker-setup.yml
```

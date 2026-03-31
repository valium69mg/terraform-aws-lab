# ==========================================
# Genera el inventory de Ansible leyendo terraform.tfstate
# ==========================================

# Ruta al archivo terraform.tfstate
$tfstate_path = "..\terraform\terraform.tfstate"

# Leer y parsear el JSON
$tfstate_json = Get-Content -Raw $tfstate_path | ConvertFrom-Json

# Extraer la IP pública del output
$ip = $tfstate_json.outputs.public_ip.value

if ([string]::IsNullOrEmpty($ip)) {
    Write-Error "No se pudo obtener la IP pública desde terraform.tfstate. Revisa que Terraform haya aplicado la infraestructura."
    exit 1
}

Write-Host "Public IP obtenida del tfstate: $ip"

# Ruta a la llave SSH
$key = "..\terraform\.ssh\id_rsa"

# Generar contenido del inventory
$inventory_content = @"
all:
  hosts:
    my-ec2:
      ansible_host: $ip
      ansible_user: ec2-user
      ansible_ssh_private_key_file: $key
"@

# Guardar en inventories/hosts.yml
$inventory_path = "inventories/hosts.yml"
$inventory_content | Out-File -Encoding utf8 $inventory_path

Write-Host "Ansible inventory actualizado en: $inventory_path"
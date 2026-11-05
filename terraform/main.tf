terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {
  # Nessuna opzione necessaria, usa il Docker Desktop del tuo PC
}

# 1. Definiamo l'immagine da usare
resource "docker_image" "my_image" {
  name         = "cloud-lab:latest"
  keep_locally = true
}

# 2. Definiamo il container da creare
resource "docker_container" "my_container" {
  name  = "cloud-lab-terraform"
  image = docker_image.my_image.image_id
  ports {
    internal = 80
    external = 8080
  }
}
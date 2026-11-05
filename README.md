# ☁️ Cloud Lab - Portfolio Project

Un progetto pratico end-to-end costruito per esplorare, testare e consolidare i concetti fondamentali del Cloud Computing, della containerizzazione, dell'orchestrazione e dell'Infrastructure as Code (IaC). 
Il progetto parte da un elemento volutamente semplice (una pagina HTML statica) per concentrare l'attenzione sull'infrastruttura sottostante, simulando flussi di lavoro moderni tipici della metodologia DevOps.

## 🗺️ Mappa del Progetto

Il lavoro è stato suddiviso in tre macro-fasi logiche:

```text
📍 FASE LOCALE (Containerizzazione)
 ├── 📄 1. index.html        (Il contenuto della pagina web)
 ├── 🗄️ 2. Git               (Sistema di versionamento)
 ├── 🐳 3. Dockerfile        (La ricetta costruttiva per il server Nginx)
 └── 🐙 4. Docker Compose    (Definizione dei servizi per l'avvio rapido)

☁️ FASE REMOTA (CI/CD & Hosting)
 ├── 🗄️ 2. GitHub            (Repository remoto pubblico)
 ├── 🤖 5. GitHub Actions    (Pipeline di Continuous Integration)
 └── 🌍 6. GitHub Pages      (Pubblicazione ed esposizione pubblica del sito)

🚀 FASE AVANZATA (Orchestrazione e IaC)
 ├── ☸️ 7. Kubernetes        (Self-healing, Deployment e Service con Minikube)
 └── 🏗️ 8. Terraform         (Automazione dell'infrastruttura locale)


 🛠️ Tecnologie Utilizzate
Frontend: HTML5

Containerization: Docker, Docker Compose

Web Server: Nginx (immagine alpine per minimizzare il peso)

Version Control & CI/CD: Git, GitHub, GitHub Actions

Hosting: GitHub Pages

Container Orchestration: Kubernetes (Minikube locale)

Infrastructure as Code (IaC): HashiCorp Terraform

🏗️ Fasi del Progetto e Spiegazione
Fase 1: Containerizzazione (Locale)
L'applicazione è stata isolata all'interno di un container usando un web server Nginx.
Scrivendo un Dockerfile, ho creato l'immagine base. Successivamente, ho implementato un docker-compose.yml per mappare la porta locale 8080 alla porta 80 del container, garantendo un avvio standardizzato con un singolo comando su qualsiasi macchina.

Fase 2: Continuous Integration e Hosting (Cloud)
Il ciclo di vita del codice è stato automatizzato per prevenire il caricamento di container rotti.
Configurando una pipeline CI con GitHub Actions (.github/workflows/ci.yml), ogni nuovo push sul ramo main innesca automaticamente un test di build dell'immagine Docker su una macchina virtuale Ubuntu. Parallelamente, il codice sorgente è ospitato e reso visibile gratuitamente tramite GitHub Pages.

Fase 3: Orchestrazione e Self-Healing (Kubernetes)
Per simulare un ambiente ad alta affidabilità (HA), ho usato Minikube.
Ho creato un manifest di Deployment per garantire che ci fossero sempre esattamente 2 repliche (Pod) della pagina web in esecuzione. Ho testato con successo il meccanismo di self-healing (auto-guarigione) eliminando forzatamente un pod e osservando Kubernetes ricrearne uno nuovo istantaneamente. L'accesso ai pod è stato gestito tramite un manifest di tipo Service.

Fase 4: Infrastructure as Code (Terraform)
Per il tocco finale, ho automatizzato il provisioning dell'infrastruttura locale descrivendola in codice tramite HashiCorp Terraform e il provider Docker. Questo permette di creare o distruggere l'intero ambiente di test in modo predicibile e versionabile, senza interazione manuale con l'interfaccia grafica.

🚀 Istruzioni per riprodurre il progetto
Se vuoi clonare questo repository e testare i vari ambienti sul tuo computer, segui i comandi sottostanti.Prerequisiti installati: git, docker (Docker Desktop), minikube, kubectl, terraform.

1. Clonare il repository e preparare l'ambiente
Bash
git clone [https://github.com/eariszeta1997/cloud-lab.git](https://github.com/eariszeta1997/cloud-lab.git)
cd cloud-lab
2. Metodo A: Avvio semplice (Docker Compose)
Ottimo per un test rapido e leggero in locale.

Bash
# Accende l'infrastruttura in background
docker compose up -d

# Il sito è ora visibile su http://localhost:8080

# Spegne e rimuove i container
docker compose down
3. Metodo B: Avvio avanzato (Kubernetes / Minikube)
Ottimo per testare la resilienza e i concetti di orchestratore.

Bash
# Avvia il cluster locale forzando il driver Docker
minikube start --driver=docker

# Costruisce l'immagine Docker
docker build -t cloud-lab:latest .

# Inietta l'immagine appena creata dentro il cluster Minikube
minikube image load cloud-lab:latest

# Applica i file di configurazione (Deployment e Service)
kubectl apply -f k8s/

# Verifica lo stato dei pod (devono essere 2 in stato 'Running')
kubectl get pods

# Espone il servizio e apre automaticamente il browser
minikube service cloud-lab-service

# Per testare il self-healing: elimina un pod e lancia subito 'kubectl get pods'
# kubectl delete pod <nome-del-pod>

# Pulizia finale dell'ambiente Kubernetes
kubectl delete -f k8s/
minikube stop
4. Metodo C: Infrastructure as Code (Terraform)
Assicurati che la porta 8080 del tuo PC sia libera prima di procedere.

Bash
cd terraform

# Inizializza Terraform e scarica i provider
terraform init

# Mostra il piano di esecuzione (simulazione)
terraform plan

# Applica l'infrastruttura (verrà richiesta conferma digitando 'yes')
terraform apply

# Il sito è ora visibile su http://localhost:8080

# Per distruggere l'infrastruttura in modo pulito (confermare con 'yes')
terraform destroy


Progetto realizzato da Vincenzo Sansone.


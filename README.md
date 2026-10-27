# Mini Linux OS (projet de construction)

Ce ZIP contient un projet pour construire un mini système Linux x86_64 avec Buildroot. Il ne contient **pas** un noyau Linux ou une ISO déjà compilée. La compilation télécharge les sources officielles de Buildroot et des paquets.

## Prérequis
Machine Linux x86_64 (Ubuntu/Debian recommandé), connexion Internet, environ 15 Go libres, 2 Go de RAM minimum. Installer :

```bash
sudo apt update
sudo apt install -y build-essential git wget curl cpio unzip rsync file bc python3 libncurses-dev
```

## Construire

```bash
chmod +x scripts/*.sh
./scripts/build.sh
```

La sortie se trouve dans `buildroot/output/images/` (image noyau/rootfs selon la configuration). Pour démarrer dans QEMU :

```bash
sudo apt install -y qemu-system-x86
./scripts/run-qemu.sh
```

Le système utilise BusyBox, une console série et un shell root sans mot de passe : **usage local/test uniquement**, pas de déploiement exposé au réseau.

## Personnalisation
`config/minios_defconfig` définit les options Buildroot. `rootfs/etc/motd` affiche le message de bienvenue. Après modification, relancer `scripts/build.sh`.

## Compilation avec Docker

Prérequis : Docker Engine avec le plugin Docker Compose, connexion Internet et environ 15 Go d'espace disque.

```bash
unzip mini-linux-os-docker.zip
cd mini-linux-os
chmod +x scripts/*.sh
./scripts/build-docker.sh
```

Ou manuellement :

```bash
docker compose build
docker compose run --rm build-minios
```

Les fichiers générés sont dans `buildroot/output/images/` sur l'hôte.
Le conteneur est un **environnement de compilation**, pas un système Linux démarré dans Docker.
La compilation est susceptible de prendre du temps. Le volume Docker est monté avec les permissions root : sur Linux, les fichiers générés peuvent appartenir à root.

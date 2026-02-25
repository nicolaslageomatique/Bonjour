#!/bin/bash

# Vérifie qu'un message est fourni
if [ -z "$1" ]; then
  echo "Tu dois fournir un message de commit."
  echo "Usage : ./deploy.sh \"Mon message\""
  exit 1
fi
# Déploiement MkDocs
mkdocs gh-deploy


# Ajout des fichiers
git add *

# Commit avec le message passé en argument
git commit -m "$1"


# Push
git push

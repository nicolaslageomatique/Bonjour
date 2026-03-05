# Administrer son serveur de base de données

L'avantage d'une base de données par rapport à une arborescence de fichier c'est la possibilité du travail simultané.

## Concept d'administration : différence entre SG et BD

Une base de données est un ensemble de données organisées. Le système qui gère un ensemble de bases de données est appelé système de gestion de base de données. La base de données contient les enregistrements, les champs et les cellules de données. Le SGBD est l'outil utilisé pour manipuler les données à l'intérieur de la base de données. Cependant, le terme base de données est de plus en plus utilisé comme raccourci pour Système de gestion de base de données. Pour simplifier la distinction, prenez en compte le système d’exploitation et les fichiers individuels stockés dans le système. Tout comme vous avez besoin d'un système d'exploitation pour accéder aux fichiers et les modifier, vous avez besoin d'un SGBD pour manipuler les bases de données stockées dans le système de base de données.

### Composants d'un SGBD

Composants BD => Base de Données
- modèles de données (MCD, MLD, MPD),
- les schémas,
- les données,
- applications connectées (clients),
- utilisateurs de la base de données (rôles),
- requêtes,
- indexes
- ...

Composants SG => Système de Gestion
- architecture,
- réseau,
- CPU,
- RAM,
- Stockage,
- OS
- ...

### Une base de dév et une base de prod

La base de dev est le premier environnement où les développeurs travaillent. C’est ici que les idées prennent forme. Ce serveur permet aux équipes de coder, tester et itérer rapidement sans affecter la version active de la base. Grâce à cet environnement isolé, les risques de briser la version en ligne du site sont nuls.

*(On peut distinguer également une instance de préproduction. Ce serveur est une réplique quasi exacte du serveur de production. Il permet de simuler l’environnement réel avant de lancer les modifications en ligne. Cela offre une vue réaliste des performances du site. C'est important pour la validation des mises à jour. On vérifie si les nouveaux développements interagissent bien avec les anciennes fonctionnalités).*

La base de production est le serveur où le site est accessible au public. C’est ici que les visiteurs interagissent avec votre site. Tout ce qui se trouve sur ce serveur doit fonctionner parfaitement, car il s'agit de l’expérience utilisateur réelle.

## Étapes de la création d'une système de base de données

### 1. Établir les caractéristiques de la base

Ici nous cherchons à déterminer quels vont être les finalités de la base de données. Dans le cas du géomaticien, la principale sera spatiale.

### 2. Évaluation du matériel du serveur

Cela dépend de plusieurs facteurs :
- Quantité de données qui vont être stockées = prévision de charge
- Nombre d'utilisateur se connectant en même temps (un utilisateur connecté = un certain montant de ressources consommées)
- Quelles données vont être traitées = images satellites vs couche de vecteurs ponctuel

### 3. Installation du logiciel PostgreSQL (serveur et clients)

Suivant le choix de l'OS :
- Utiliser un exécutable existant ou repartir des sources (du code source, dans le cas d'un logiciel opensource)
- Se familiariser avec l'arborescence (windows vs linux)
- Quels clients vont se connecter à la base (psql, pgadmin, dbeaver (JDBC), QGis, Webmap)

### 4. Créer et ouvrir la base de données

- Création d'un groupe de base de données, appelé CLUSTER => il s'agit en premier lieu d'initialiser un emplacement de stockage pour la base de données.
- Suivant l'installeur choisi (par exemple sur windows), l'initdb est effectué automatiquement. Ceci est modifiable...
- On va ensuite définir les TABLESPACE à l'intérieur de ce répertoire, comme moyen d'organiser (séparer au minimum les bases dans des sous répertoires) ou à l'extérieur afin d'optimiser si on place le tablespace sur un stockage différent (disque plus rapide pour les calculs et lent pour la stockage lourd).

### 5. Stratégie de sauvegarde de la base de données

On distingue deux types de sauvegardes :
- la sauvegarde manuelle avec l'utilisation de pg_dump
- la sauvegarde automatisée avec l'utilisation de script

L'enregistrement des transactions est stocké dans les journaux de transactions appelés WAL (Write Ahead Log), qui ont une taille prédéfinie de 32 Mo sous linux.

Il s'agit ni plus ni moins de l'historique de tout ce qui se passe sur la base.

Les transactions assurent la fiabilité de la base et sa cohérence en gérant les accès concurrents ou que le système tombe en panne pendant un traitement.

Il faut être vigilant là aussi à la configuration par exemple sur de grosses mises à jour qui peuvent rapidement saturer l'espace disque et planter le serveur.

### 6. Créer et gérer les utilisateurs et leur droits d'accés (stratégie de sécurité dédiée)

La stratégie des droits d'utilisateurs, du nombre d'utilisateurs se connectant en même temps à la base fait partie de la phase conceptuelle de la base de données.

Au niveau du déploiement d'une base de données, on passe à la phase de création et d'octrois des droits aux utilisateurs.

On définie dans la configuration du serveur la limite max du nombre d'utilisateurs dans le fichier 'postgresql.conf'.

### 7. Implémenter la base

Phase usuelle de l'administration de la BD

Modifier la structure de la base : même si non conseillé, cela peut arriver !
Par exemple, modifier un identifiant parce que le client l'exige.

Il faudra mesurer les impacts sur le modèle conceptuel de données mais aussi sur toutes les applications tierces qui utilisent cet ID (on le fait dabord en instance de dev puis en prod).

Ajout de données en masse : opérations susceptibles de fragiliser la structure.

Imaginer une phase de maintenance / test avant la (re)mise en production.

Suppression de données : mesurer les impacts avant la suppression.

### 8. Sauvegarder la base de données fonctionnelle

La stratégie de sauvegarde peut difficilement se concevoir de manière manuelle.

Une base en production se doit de disposer d'un système de sauvegarde automatique.

Une recherche rapide propose différents solutions, en voici deux :
- https://github.com/DiouxX/script_backup_postgresql
- http://nils.hamerlinck.fr/blog/2015/05/04/backup-automatique-base-postgresql/

### 9. Optimiser les performances de la base

Paramétrer le serveur PostgreSQL pour le spatial : http://www.postgis.fr/chrome/site/docs/workshop-foss4g/doc/tuning.html

PGTune : https://pgtune.leopard.in.ua/

Utiliser l'utilitaire htop dans un environnement Linux.

Combinaison des touches "Ctrl + Maj + Echap" pour ouvrir le gestionnaire des tâches et dans l'onglet "Performances" on obtient toutes les caractéristiques d'une machine windows.

## Arborescence du système de fichier d'un serveur PostgreSQL

### Emplacement des fichiers (datas) de la base de données

| Éléments | Description |
|----------|-------------|
| PG_VERSION | Un fichier contenant le numéro de version majeur de PostgreSQL™ |
| base | Sous-répertoire contenant les sous-répertoires par base de données |
| global | Sous-répertoire contenant les tables communes au groupe, telles que pg_database |
| pg_commit_ts | Sous-répertoire contenant des données d'horodatage des validations de transactions |
| pg_clog | Sous-répertoire contenant les données d'état de validation des transactions |
| pg_dynshmmem | Sous-répertoire contenant les fichiers utilisés par le système de gestion de la mémoire partagée dynamique |
| pg_logical | Sous-répertoire contenant les données de statut pour le décodage logique |
| pg_multixact | Sous-répertoire contenant des données sur l'état des multi-transactions (utilisé pour les verrous de lignes partagées) |
| pg_notify | Sous-répertoire contenant les données de statut de LISTEN/NOTIFY |
| pg_replslot | Sous-répertoire contenant les données des slots de réplication |
| pg_serial | Sous-répertoire contenant les informations sur les transactions sérialisables validées |
| pg_snapshots | Sous-répertoire contenant les snapshots (images) exportés |
| pg_stat | Sous-répertoire contenant les fichiers permanents pour le sous-système de statistiques |
| pg_stat_tmp | Sous-répertoire contenant les fichiers temporaires pour le sous-système de statistiques |
| pg_subtrans | Sous-répertoire contenant les données d'états des sous-transactions |
| pg_tblspc | Sous-répertoire contenant les liens symboliques vers les espaces logiques |
| pg_twophase | Sous-répertoire contenant les fichiers d'état pour les transactions préparées |
| pg_xlog | Sous-répertoire contenant les fichiers WAL (Write Ahead Log) |
| postgresql.auto.conf | Fichier utilisé pour les paramètres configurés avec la commande ALTER SYSTEM |
| postmaster.opts | Un fichier enregistrant les options en ligne de commande avec lesquelles le serveur a été lancé la dernière fois |
| postmaster.pid | Un fichier verrou contenant l'identifiant du processus postmaster en cours d'exécution (PID), le chemin du répertoire de données, la date et l'heure du lancement de postmaster, le numéro de port, le chemin du fichier du socket de domaine Unix (vide sous Windows), la première adresse valide dans listen_address (adresse IP ou *, ou vide s'il n'y a pas d'écoute TCP) et l'identifiant du segment de mémoire partagée (ce fichier est supprimé à l'arrêt du serveur) |


pg_hba.conf : fichier qui permet de controler quelle machine accedent a quelle database et quels sopnt les utilisateurs qui peuvent accéder à la BDD

METHOD = methode d'identification :
- "trust" : attention tout les droits, pas besoin de mot de passe
- "scram_sha_256" : le plus utilisé car utilisation d'un mot de passe

##Les principaux binaires de PostgreSQL

### pg_ctl (réalisé par les installateurs comme systemD ou celui de windows)
- gestion de l'instance / cluster
- start / stop / kill
- init : création autre espace de datas
- promote : promotion de standby

### psql
- le premier client de connexion en mode CLI
- on se connecte avec un utilisateur à une base de donnée
- on peux exécuter du SQL et des méta-commandes, ou des script sql (fichiers)

### pg_createcluster
- Création d'une instance PG
- Création des répertoires (/etc et /var/lib)

Accompagné de pg_dropcluster (suppression de cluster), pg_lscluster (lister), pg_ctlcluster (contrôleur du cluster)

### Les binaires pour la sauvegarde

**pg_dump** :
- sauvegarde d'une instance
- différents formats : plain text (DDL schéma et SQL), binaire (lisible seulement par PG), compressé
- différents niveaux d'objets (cluster, db, table, schéma)

**pg_dumpall** : sauvegarde intégrale en format binaire

**pg_restore** : restauration à partir d'une sauvegarde pg_dumpall

### Wrappers (des raccourcis)
- createdb
- dropdb
- createuser
- dropuser

### Maintenance
Dans l'administration d'une base de données il y a des taches de maintennace obligatoire.
Notion d'index spatial à développer (GIST ?)
- reindexdb : réindexation
- vaccumdb : tâche de maintenance (ménage, permet de récupérer l'espace disque)

### Spécifiques système avancées
- pg_controldata : vérifie l'état du serveur et des infos critiques
- pg_resetwal : en cas de crash avec des pb de WAL (risques de pertes de données)
- pg_receive_wal : récupération des WAL d'une autre DB (réplication)
- pg_basebackup : récupération de datas par une autre connexion à une autre DB (réplication)


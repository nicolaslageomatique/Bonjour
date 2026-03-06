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

## Les principaux binaires de PostgreSQL

### pg_ctl (réalisé par les installateurs comme systemD ou celui de windows)
*Outil de gestion du cycle de vie d'une instance PostgreSQL. Il permet de démarrer, arrêter ou forcer l'arrêt du serveur (start / stop / kill), d'initialiser un nouveau répertoire de données (init), et de promouvoir un serveur standby en serveur principal (promote) — opération clé lors d'un basculement en haute disponibilité.*

- gestion de l'instance / cluster
- start / stop / kill
- init : création autre espace de datas
- promote : promotion de standby

### psql
*Le client en ligne de commande (CLI) natif de PostgreSQL. On s'y connecte en spécifiant un utilisateur et une base de données cible. Il permet d'exécuter des requêtes SQL, des méta-commandes (commandes spéciales préfixées par \ , comme \dt pour lister les tables), ou de lancer des scripts SQL depuis un fichier (via \i monfichier.sql).*

- le premier client de connexion en mode CLI
- on se connecte avec un utilisateur à une base de donnée
- on peux exécuter du SQL et des méta-commandes, ou des script sql (fichiers)

### pg_createcluster
*(spécifique aux distributions Debian/Ubuntu)
Crée une nouvelle instance PostgreSQL sur le système. Il génère automatiquement les répertoires de configuration (/etc/postgresql/) et les répertoires de données (/var/lib/postgresql/). Il s'accompagne de plusieurs outils complémentaires :
pg_dropcluster : supprime complètement un cluster existant
pg_lscluster : liste tous les clusters présents sur la machine et leur état
pg_ctlcluster : contrôle le démarrage/arrêt d'un cluster (surcouche à pg_ctl adaptée à Debian)*

- Création d'une instance PG
- Création des répertoires (/etc et /var/lib)

Accompagné de pg_dropcluster (suppression de cluster), pg_lscluster (lister), pg_ctlcluster (contrôleur du cluster)

### Les binaires pour la sauvegarde

**pg_dump** :
Sauvegarde sélective d'une base ou d'objets spécifiques. Plusieurs formats sont disponibles :
- plain text : génère du SQL lisible (DDL + INSERT), rejouable avec psql
- binaire : format propriétaire PostgreSQL, plus compact, non lisible directement

La granularité est configurable : on peut sauvegarder un cluster entier, une base, un schéma, ou une table précise.

**pg_dumpall** : Sauvegarde intégrale du cluster PostgreSQL en une seule commande. Inclut les bases de données, mais aussi les rôles et tablespaces qui sont globaux au cluster (contrairement à pg_dump qui reste limité à une base). Produit un script SQL en texte plain.

**pg_restore** : Restaure une sauvegarde produite par pg_dump dans un format non-texte (binaire ou compressé). Permet une restauration flexible : choix des objets à restaurer, parallélisation, gestion des dépendances entre objets.

### Wrappers (des raccourcis)
Ces commandes sont des enveloppes simplifiées autour de requêtes SQL courantes, utilisables directement depuis le terminal sans passer par psql :
- createdb / dropdb : créer ou supprimer une base de données
- createuser / dropuser : créer ou supprimer un rôle utilisateur

Pratiques pour les scripts d'automatisation ou les déploiements rapides.

### Maintenance
La maintenance régulière est indispensable pour garantir les performances et la stabilité d'une instance PostgreSQL.
- reindexdb : Reconstruit les index d'une base ou d'une table. Utile quand les index sont fragmentés ou corrompus, ce qui peut ralentir les requêtes. À lancer après des opérations massives d'insertion/suppression.
- vacuumdb : Lance l'opération de VACUUM sur une base. PostgreSQL utilise un mécanisme de versionnage des lignes (MVCC) : les anciennes versions de lignes supprimées ou mises à jour ne sont pas effacées immédiatement. VACUUM récupère l'espace disque occupé par ces lignes mortes et met à jour les statistiques du planificateur de requêtes.

**Notion à approfondir** : les index GiST (Generalized Search Tree) sont des index spatiaux utilisés notamment avec l'extension PostGIS pour indexer des données géographiques (points, polygones…). Ils permettent des recherches par proximité, intersection ou contenance.


### Spécifiques système avancées
Ces outils sont réservés à des usages experts (à manipuler avec précaution).
- pg_controldata : Affiche des métadonnées critiques sur l'état du cluster : version du format de données, état du serveur (en ligne, en cours d'arrêt, en recovery…), position dans les WAL, paramètres de checkpoint. Indispensable pour diagnostiquer l'état d'une instance après un incident.
- pg_resetwal : Réinitialise les journaux de transactions (WAL) en cas de corruption ou de crash sévère. C'est un outil de dernier recours : son usage peut entraîner des pertes de données et laisser la base dans un état incohérent. À n'utiliser que si aucune autre solution n'est possible.
- pg_receivewal : Récupère en flux continu les WAL produits par un serveur PostgreSQL distant, sans être un serveur standby à part entière. Utilisé pour archiver les journaux en temps réel à des fins de sauvegarde continue ou de réplication différée.
- pg_basebackup : Effectue une copie physique complète d'un cluster PostgreSQL depuis une connexion réseau à un serveur en production. C'est la méthode standard pour initialiser un serveur standby dans une architecture de réplication. Peut inclure les WAL nécessaires pour rendre la copie cohérente.

### PGTune :

https://pgtune.leopard.in.ua/

PGTune calculate configuration for PostgreSQL based on the maximum performance for a given hardware configuration. It isn't a silver bullet for the optimization settings of PostgreSQL. Many settings depend not only on the hardware configuration, but also on the size of the database, the number of clients and the complexity of queries. An optimal configuration of the database can only be made given all these parameters are taken into account.

*PGTune calcule la configuration de PostgreSQL en fonction des performances maximales pour une configuration matérielle donnée. Il ne s'agit pas d'une solution miracle pour l'optimisation des paramètres de PostgreSQL. De nombreux paramètres dépendent non seulement de la configuration matérielle, mais aussi de la taille de la base de données, du nombre de clients et de la complexité des requêtes. Une configuration optimale de la base de données ne peut être réalisée qu'en tenant compte de tous ces paramètres.*

## Les Tablespaces

Un tablespace est un lien entre PostgreSQL et un emplacement physique sur le disque. Il doit être créé avant la base de données qui l'utilisera, car une base est rattachée à un tablespace à sa création.
On lui attribue un nom logique et un chemin absolu vers un répertoire existant sur la machine :

```
CREATE TABLESPACE nom_du_tbsp OWNER user_name LOCATION '/emplacement/choisi/';
```

> Le répertoire doit exister au préalable et appartenir à l'utilisateur système `postgres`.

Pour **lister les tablespaces** existants :
```
\db     -- liste simple
\db+    -- liste avec la taille occupée sur disque
```

> Attention à la configuration par défaut
Sans tablespace explicite, PostgreSQL stocke toutes les bases dans le même répertoire : PGDATA/base/. Ce répertoire correspond au volume monté lors de l'installation — souvent le disque système.

Cela pose deux problèmes majeurs :
- Saturation du disque système, qui peut provoquer des crashs du serveur ou de l'OS
- Risque de tout perdre en même temps : toutes les bases sont colocalisées, une défaillance du support impacte l'ensemble du cluster

Il est donc essentiel de dimensionner et planifier l'espace disque de PGDATA dès le départ, ou mieux — d'utiliser des tablespaces dédiés.

### Bonnes pratiques de gestion des Tablespaces

- Un répertoire (et tablespace) par base : Isoler chaque base dans son propre espace disque permet de limiter l'impact d'une saturation. Si une base consomme tout l'espace disponible, les autres ne sont pas affectées.
- Plusieurs tablespaces par base si nécessaire : Quand une base grossit au point d'atteindre la capacité maximale d'un disque, il est possible d'ajouter un second tablespace pointant vers un autre volume. PostgreSQL distribuera les objets entre les deux emplacements.
- Séparer tables et index sur des tablespaces différents : L'indexation est une opération intensive en lecture/écriture aléatoire : lors d'une requête, PostgreSQL parcourt souvent l'index avant d'accéder aux données. Il est donc judicieux de :
	- Placer les index sur un disque rapide (SSD) pour minimiser la latence de recherche
	- Placer les tables sur un disque mécanique (HDD) moins coûteux, adapté aux lectures séquentielles de gros volumes

Cette séparation peut significativement améliorer les performances sans changer une seule ligne de SQL.

## Maintenance - Vacuum et autre dashboard

Récupère l'espace inutilisé et, optionnellement, analyse une base.

Lors des opérations normales de PostgreSQL, les lignes supprimées ou rendues obsolètes par une mise à jour ne sont pas physiquement supprimées de leur table.

Vacuum permet de récupérer l'espace occupé par les lignes supprimées.

Le **VACCUM** standard (sans FULL) récupère simplement l'espace et le rend disponible pour une réutilisation. Cette forme de la commande peut opérer en parallèle avec les opérations normales de lecture et d'écriture de la table, car elle n'utilise pas de verrou exclusif.

**VACCUM FULL** fait un traitement plus complet et, en particulier, déplace des lignes dans d'autres blocs pour compacter la table au maximum sur le disque. Cette forme est beaucoup plus lente et pose un verrou exclusif sur la table pour faire son traitement.

**Des VACUUM standard et d'une fréquence modérée sont une meilleure approche que des VACUUM FULL, même non fréquents, pour maintenir des tables mises à jour fréquemment.**

Après avoir ajouté ou supprimé un grand nombre de lignes, il peut être utile de faire un **VACUUM ANALYZE** sur la table affectée. Cela met les catalogues système à jour de tous les changements récents et permet à l'optimiseur de requêtes de PostgreSQL™ de faire de meilleurs choix lors de l'optimisation des requêtes.

Pour exécuter un VACUUM sur une table, vous devez habituellement être le propriétaire de la table ou un super utilisateur. Les propriétaires de la base de données sont autorisés à exécuter VACUUM sur toutes les tables de leurs bases de données, sauf sur les catalogues partagés. Cette restriction signifie qu'un vrai VACUUM sur une base complète ne peut se faire que par un super utilisateur.

Il est recommandé que les bases de données actives de production soient traitées par VACUUM fréquemment (au moins toutes les nuits), pour supprimer les lignes mortes.

### Auto-vacuum

Automatiser l'exécution des commandes VACUUM et ANALYZE

Une fois activé, autovacuum s'exécute périodiquement et vérifie les tables ayant un grand nombre de lignes insérées, mises à jour ou supprimées. Ces vérifications utilisent la fonctionnalité de récupération de statistiques au niveau ligne.

Dans la configuration par défaut, l'autovacuum est activé et les paramètres liés sont correctement configurés.

## Sauvegarder et restaurer les données de postgreSQL en ligne de commande

### Sauver

Objectif : produire un fichier texte de commandes SQL (« fichier dump »), qui, si on le renvoie au serveur, recrée une base de données identique à celle sauvegardée.

```
pg_dump base_de_donnees > fichier_sauvegarde
```

Les extractions peuvent être réalisées sous la forme de scripts ou de fichiers d'archive.
- Les scripts sont au format texte et contiennent les commandes SQL nécessaires à la reconstruction de la base de données dans l'état où elle était au moment de la sauvegarde. La restauration s'effectue en chargeant ces scripts avec psql.
- La reconstruction de la base de données à partir d'autres formats de fichiers archive est obtenue avec pg_restore. Les formats de fichier en sortie les plus flexibles sont le format « custom » (-Fc) et le format « directory » (-Fd). Ils permettent la sélection et le ré-ordonnancement de tous les éléments archivés, le support de la restauration en parallèle. De plus, ils sont compressés par défaut. Le format « directory » est aussi le seul format à permettre les sauvegardes parallélisées.

**Remarque**
- pg_dump permet de restaurer des bases dans des versions du serveur plus récentes.
- pg_dump est aussi la seule méthode qui fonctionnera lors du transfert d'une base de données vers une machine d'une architecture différente (comme par exemple d'un serveur 32 bits à un serveur 64 bits).

### Restaurer

Les fichiers texte créés par pg_dump peuvent être lus par le programme psql.

```
psql base_de_donnees < fichier_sauvegarde
```

**Remarque :** 
Tous les utilisateurs possédant des objets ou ayant certains droits sur les objets de la base sauvegardée doivent exister préalablement à la restauration de la sauvegarde. S'ils n'existent pas, la restauration échoue pour la création des objets dont ils sont propriétaires ou sur lesquels ils ont des droits.

### Sauvegarder une base directement d'un serveur sur un autre

```
pg_dump -h serveur1 base_de_donnees | psql -h serveur2 base_de_donnees
```

**Conseil :**
Après la restauration d'une sauvegarde, il est conseillé d'exécuter ANALYZE sur chaque base de données pour que l'optimiseur de requêtes dispose de statistiques utiles.

### Utilisation de pg_dumpall

Permet une sauvegarde de tout un cluster (bases de données, rôles et tablespaces).

```
pg_dumpall > fichier_sauvegarde
```

Le fichier de sauvegarde résultant peut être restauré avec psql :

```
psql -h localhost -p 5432 -U postgres -c "CREATE DATABASE nombase;"
psql -h localhost -p 5432 -U postgres -d nombase -c "CREATE EXTENSION postgis;"
psql -h localhost -p 5432 -U utilisateur -d nombase -f chemin\complet\du\fichier.sql
```

**Remarque :**

Il est préférable d'avoir les droits de superutilisateur de la base de données pour obtenir une sauvegarde complète.

Il faut obligatoirement avoir le profil superutilisateur pour restaurer une sauvegarde faite avec pg_dumpall, afin de pouvoir restaurer les informations sur les rôles et les tablespaces. Si les tablespaces sont utilisés, il faut s'assurer que leurs chemins sauvegardés sont appropriés à la nouvelle installation.

### Mettre en place une sauvegarde automatique

Encore une fois, suivant la taille de la structure des sauvegardes peuvent intervenir à plusieurs niveau.
- Bien souvent, il existe une sauvegarde du serveur qui héberge le serveur PostgreSQL.
- On peut mettre une sauvegarde au niveau d'une base de données en choisissant le rythme adéquat (mise à jour des données régulière, vs modèles peu évolutif)

**Script + crontab**

Etablir une commande pg_dump dans un script bash vers une sortie « .dump »

Ce fichier pour s'appeler

On positionnera ce script dans le dossier /usr/bin/

```
1. DB_USER="postgres"		# utilisateur de la base de données PostgreSQL
2. DB_NAME="ma_base"		# nom de la base de données à sauvegarder
3. DB_SCHEMA="pourquoi_pas"	# pour ne sauver que le schéma
4. current_date=$(date +%Y-%m-%d)
5. backup_file="/home/xxx/sauv_bdd/sauv_${DB_NAME}${DB_SCHEMA}${current_date}.dump"
```

```
1. if ! pg_dump -U "$DB_USER" -F c "$DB_NAME" -n "$DB_SCHEMA" > "$backup_file"; then
2. echo "Echec: La sauvegarde de la bdd a échouée"
3. return 1
4. fi
5. printf "Sauvegarde de la base ok"
```

Paramétrer une tâche « Crontab »
```
crontab -e
```

**Comment régler le crontab ?**

https://www.linuxtricks.fr/wiki/cron-et-crontab-le-planificateur-de-taches

```
# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  *  user command to be executed
```

## Les droits d'accès aux données (rôles et privilèges)


### Les contrôles d'accès

#### Droits d'accès utilisateur

PostgreSQL™ gère les droits d'accès aux bases de données en utilisant le concept de rôles. Un rôle peut être vu soit comme un utilisateur de la base de données, soit comme un groupe d'utilisateurs de la base de données, suivant la façon dont le rôle est configuré. Les rôles peuvent posséder des objets de la base de données (par exemple des tables et des fonctions) et peuvent affecter des droits sur ces objets à d'autres rôles pour contrôler qui a accès à ces objets.

La création d'un utilisateur se fait par la commande CREATE ROLE ou avec l'interface de pgAdmin

	CREATE ROLE nom_utilisateur LOGIN;

Les rôles sont communs à toutes les bases de données du serveur, autrement dit, les rôles sont définis au niveau du serveur et pas d'une base de données.

La seule différence entre un rôle groupe et un rôle utilisateur c'est la capacité de connexion.

#### Les rôles de groupe

Un rôle peut être défini comme rôle de groupe.

Après l'avoir créé, on peut lui ajouter des membres avec la commande :

GRANT role_groupe TO role1,... ;

- Les rôles membres qui ont l'attribut INHERIT peuvent utiliser automatiquement les droits des rôles dont ils sont membres, ceci incluant les droits hérités par ces rôles.
- L'attribut NOINHERIT enlève l'héritage.

Par défaut, PostgreSQL™ donne à tous les rôles l'attribut INHERIT pour des raisons de compatibilité avec les versions précédant la 8.1 dans lesquelles les utilisateurs avaient toujours les droits des groupes dont ils étaient membres.

Un rôle de groupe n'a pas besoin d'avoir un droit de connexion à la base (LOGIN), ce sont les utilisateurs de ce groupe qui se connectent.

	CREATE ROLE role_groupe;
	GRANT role_groupe TO nom_utilisateur;

**Remarque**

Pour déterminer l'ensemble des rôles existants, examinez le catalogue système pg_roles existant :

	SELECT rolname FROM pg_roles;

Afin d'amorcer le système de base de données, un serveur postgresql récemment installé contient toujours un rôle prédéfini. Ce rôle est un super-utilisateur et il est nommé postgres par habitude

#### Attributs des rôles

Quelques définitions :

- **droit de connexion :**
Seuls les rôles disposant de l'attribut LOGIN peuvent se connecter à une base de données.

- **statut de super-utilisateur :**
Les super-utilisateurs ne sont pas pris en compte dans les vérifications des droits, sauf le droit de connexion ou d'initier la réplication.

- **création de bases de données :**
Les droits de création de bases doivent être explicitement données à un rôle (à l'exception des super-utilisateurs qui passent au travers de toute vérification de droits).

- **création de rôle :**
Un rôle doit se voir explicitement donné le droit de créer plus de rôles (sauf pour les super-utilisateurs vu qu'ils ne sont pas pris en compte lors des vérifications de droits).

- **initier une réplication :**
Un rôle doit se voir explicitement donné le droit d'initier une réplication en flux (sauf pour les super-utilisateurs, puisqu'ils ne sont pas soumis aux vérifications de permissions). Un rôle utilisé pour la réplication en flux doit avoir le droit LOGIN.

- **mot de passe :**
Le client doit fournir un mot de passe quand il se connecte à la base.

**Modification d'un rôle :**
Les attributs d'un rôle peuvent être modifiés après sa création avec ALTER ROLE.

### Les privilèges (GRANT)

Un privilège est un droit sur un objet de la base attribué à un rôle.

Les SGBD permettent généralement de spécifier assez finement les privilèges d'un utilisateur en fonction des objets manipulés :
- base de données
- schéma
- table (relation)
- colonne (attribut)

Ainsi, un utilisateur peut se voir attribuer un privilège pour toute une base de données, le contenu d'un schéma, ou seulement pour quelques tables, ou encore sur uniquement quelques colonnes de certaines tables.

#### Règles d'attribution des privilèges

**Règle n°0** : un mot de passe pour chacun.

Tous les utilisateurs (clients, applications) doivent avoir un mot de passe.

**Règle n°1** : attribution du moindre privilège.

Les utilisateurs ne doivent avoir que le minimum de droits, ceux strictement nécessaires à l'accomplissement de leurs tâches. Les privilèges peuvent évoluer au cours du temps car les besoins et les tâches affectées ne sont pas immuables, mais à un moment donné, seuls les droits indispensables doivent être fournis à un utilisateur.

Il faut éviter de créer plusieurs comptes avec des droits d'administrateur.

**Règle n°2** : contrôle de la population.

Le personnel d'une entreprise bouge, il y a des départs, des arrivées, des promotions... Les privilèges doivent êtres synchrones avec la réalité de la population : il faut supprimer les comptes des utilisateurs quittant l'entreprise et de ceux n'étant plus affectés à telle ou telle tâche.

**Règle n°3** : supervision de la délégation des tâches d'administration.

Un administrateur peut être amené à déléguer auprès d'une autre personne les tâches d'attribution des privilèges de tout ou partie de la population des utilisateurs (cf WITH GRANT OPTION). Un contrôle a posteriori doit être réalisé afin de vérifier que le résultat de cette délégation est conforme à la politique adoptée.

**Règle n°4** : contrôle physique des connexions.

La connexion d'un utilisateur à une base de données peut être réalisée depuis n'importe où dans le monde grâce à Internet. Il est nécessaire de restreindre les connexions à des hôtes spécifiques connus (hba_conf).

#### Les principaux privilèges :

Les droits possibles sont :

**SELECT**

Autorise une sélection sur toutes les colonnes, ou sur les colonnes listées spécifiquement, de la table, vue ou séquence indiquée. Autorise aussi l'utilisation de COPY TO. De plus, ce droit est nécessaire pour référencer des valeurs de colonnes existantes avec UPDATE ou DELETE.

**INSERT**

Autorise une insertion d'une nouvelle ligne dans la table indiquée. Si des colonnes spécifiques sont listées, seules ces colonnes peuvent être affectées dans une commande INSERT, (les autres colonnes recevront par conséquent des valeurs par défaut). Autorise aussi COPY FROM.

**UPDATE**

Autorise une mise à jour sur toute colonne de la table spécifiée, ou sur les colonnes spécifiquement listées. (En fait, toute commande UPDATE nécessite aussi le droit SELECT car elle doit référencer les colonnes pour déterminer les lignes à mettre à jour et/ou calculer les nouvelles valeurs des colonnes.)

**DELETE**

Autorise la suppression d'une ligne sur la table indiquée. (En fait, toute commande DELETE nécessite aussi le droit SELECT car elle doit référencer les colonnes pour déterminer les lignes à supprimer.)

**TRUNCATE**

Autorise la suppression de tous les enregistrements de la table.

**REFERENCES**

Ce droit est requis sur les colonnes de référence et les colonnes qui référencent pour créer une contrainte de clé étrangère. Le droit peut être accordé pour toutes les colonnes, ou seulement des colonnes spécifiques.

**TRIGGER**

Autorise la création d'un déclencheur sur la table indiquée.

**CREATE**

Pour les bases de données, autorise la création de nouveaux schémas dans la base de données.

Pour les schémas, autorise la création de nouveaux objets dans le schéma. Pour renommer un objet existant, il est nécessaire d'en être le propriétaire et de posséder ce droit sur le schéma qui le contient.

Pour les tablespaces, autorise la création de tables, d'index et de fichiers temporaires dans le tablespace et autorise la création de bases de données utilisant ce tablespace par défaut. (Révoquer ce privilège ne modifie pas l'emplacement des objets existants.)

**CONNECT**

Autorise l'utilisateur à se connecter à la base indiquée. Ce droit est vérifié à la connexion (en plus de la vérification des restrictions imposées par pg_hba.conf).

**TEMPORARY, TEMP**

Autorise la création de tables temporaires lors de l'utilisation de la base de données spécifiée.

**EXECUTE**

Autorise l'utilisation de la fonction indiquée et l'utilisation de tout opérateur défini sur cette fonction. C'est le seul type de droit applicable aux fonctions. (Cette syntaxe fonctionne aussi pour les fonctions d'agrégat)

**ALL PRIVILEGES**

Octroie tous les droits disponibles en une seule opération. Le mot clé PRIVILEGES est optionnel sous PostgreSQL™ mais est requis dans le standard SQL.

### Connexions distantes : Foreign Data Wrappers

Le FDW (Foreign Data Wrapper) natif de PostgreSQL postgres_fdw permet d'accéder aux tables à partir de serveurs PostgreSQL distants de manière très transparente.

Le FDW standard PostgreSQL permet également à la géométrie PostGIS de passer des hôtes distants aux hôtes locaux, ce qui est très pratique.

Données externes présentées comme des tables.

En lecture/écriture (si supporté par le driver et à partir de PostgreSQL 9.3) :
- PostgreSQL, Oracle, MySQL (lecture/écriture)
- fichier CSV, fichier fixe (en lecture)
- ODBC, JDBC, Multicorn
- CouchDB, Redis (NoSQL)

#### Exemple

Un FDW sur un WFS

Jouons avec les données de l'INPN => http://ws.carmencarto.fr/WFS/119/fxx_inpn

**Extension**

En pré-requis, il faut que l'extension soit ajoutée (ça tombe bien nous l'avions prévue dans notre template).
```
CREATE EXTENSION IF NOT EXISTS ogr_fdw;
```

**Création du serveur**

```
DROP SERVER IF EXISTS fdw_ogr_inpn_metropole;
CREATE SERVER fdw_ogr_inpn_metropole
FOREIGN DATA WRAPPER ogr_fdw OPTIONS (
datasource 'WFS:http://ws.carmencarto.fr/WFS/119/fxx_inpn?',
format 'WFS'
);
```

**Création d'un schéma dédié**

```
CREATE SCHEMA IF NOT EXISTS inpn_metropole;
```

**Récupération de l'ensemble des couches WFS comme des tables dans le schéma inpn_metropole**

```
IMPORT FOREIGN SCHEMA ogr_all
FROM SERVER fdw_ogr_inpn_metropole INTO inpn_metropole OPTIONS (
-- mettre le nom des tables en minuscule et sans caractères bizarres launder_table_names 'true',
-- mettre le nom des champs en minuscule launder_column_names 'true');
```

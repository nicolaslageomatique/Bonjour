# Les métadonnées

[...]

## Pour qui écrire des métadonnées ?
Différents publics donc différents besoins

- Soi-même
	- Prises de notes, garder des traces
- Collègues
	- Savoir qu'elle existe (ne pas refaire le boulot 2 fois)
	- Auteur ? De quoi est faite le donnée ?

- Partenaires (organismes, entreprises)
	- Droits d’utilisation ?
	- Qui contacter ?
	- Comment obtenir la donnée ?

- Etat, Union Européenne
	- Contraintes de catalogage
	- Besoin d'interopérabilité transfrontalière (INSPIRE)
	
## Les standards de métadonnées

Trois standards principaux pour les métadonnées :
- ISO 19115 : normalise le contenu des métadonnées
- ISO 19139 : normalise la syntaxe xml des métadonnées
- Catalogue Service for Web (CS-W) : permet d'interroger et lire un géo-catalogue en ligne

### Historique

La norme ISO 19115 a été publiée en 2003.

Début 2005, cette norme a été adoptée comme norme européenne sous l'appellation EN ISO 19115. Elle a fait l'objet d'un profil français, dé##### fini par un groupe de travail CNIG-DGME. Ce profil a été validé en commission des référentiels du CNIG en mi 2006.

Dans une démarche similaire à celle qui avait présidé au développement de REPORTS, la DGME a jugé important de faire développer un outil libre de catalogage, Géosource, afin de faciliter l'appropriation de la norme ISO 19115 et son usage par le plus grand nombre d'acteur.

Enfin, la directive européenne INSPIRE, publiée en 2007, institue la première obligation formelle de disposer de métadonnées ISO 19115 harmonisées, libres d'accès, afin de faciliter l'usage des données géographiques liées à l'environnement. Elle en fait un des pivots de son infrastructure géographique.

### ISO 19115

ISO 19115 : le plus utilisé en Europe

Le standard ISO 19115 a été sélectionné par INSPIRE comme base pour la création de métadonnées (voir guide technique INSPIRE sur la règle de mise en œuvre des métadonnées).

- Comporte plus de 300 entrées de métadonnées
	- 22 de ces entrées constituent le profil ISO Core, le noyau du standard
		- Profil Core ISO (22 éléments = 7 obligatoires et 15 optionnels)

Les critères obligatoires permettent de répondre aux questions : Qui ? Quoi ? Quand ? Où ? relatives à la données. Les critères optionnels servent à garantir l'interopérabilité de la données.

### Le dernier de la série : le format DCAT

L'ambition de DCAT est de faciliter l'interopérabilité entre les catalogues et les données publiés sur le web via l'utilisation de la syntaxe RDF (Resource Description Framework, c'est le langage de base du Web Sémantique).

Discuté depuis 2016, publié en 2019 et une version 3 en 2024.

DCAT-AP : Data Catalog Vocabulary - Application Profile

- La documentation officielle de description de la norme DCAT : https://www.w3.org/TR/vocab-dcat-3/
- La documentation de data.gouv.fr :  https://doc.data.gouv.fr/moissonnage/dcat/
- Les résultats des travaux des groupes de travail est consultable sur le dépôt Github. Exemple ici du mappage des items Inspire vers le DCAT : https://github.com/cnigfr/metadonnee/tree/main/MappingINSPIRE-DCAT

## Quelle forme pour les métadonnées?

Dans le cadre de la norme ENV ISO 19115, les métadonnées portent plus particulièrement sur le contenu :

- des informations d'identification de la ressource : intitulé, description, dates de référence, version, résumé, intervenants;
- des informations plus techniques : la description de l'étendue géographique de la ressource, des aperçus, des informations sur les emplois possibles, systèmes de projection...
- des informations sur la qualité, organisées en :
	- mesures de qualité relatives aux critères habituels : précision géométrique, temporelle et sémantique, exhaustivité, cohérence logique ;
	- informations de généalogie : description des sources et des processus appliqués aux sources;
- des informations sur les modalités de diffusion : coût de diffusion, modes d'accès, supports, formats, contraintes légales...
- des informations sur les métadonnées elles mêmes : date de rédaction, auteur, langue...

Voyons les règles de mise en œuvre des métadonnées et les éléments de métadonnées

---
#### 1. IDENTIFICATION

##### 1.1. Intitulé de la ressource

Nom caractéristique et souvent unique sous lequel la ressource est connue.

##### 1.2. Résumé de la ressource

Bref résumé narratif du contenu de la ressource.

##### 1.3. Type de ressource

Type de ressource décrit par les métadonnées.

##### 1.4. Localisateur de la ressource

Le localisateur de la ressource définit le ou les liens avec la ressource et/ou le lien avec les informations supplémentaires concernant la ressource.

Le domaine de valeur de cet élément de métadonnées est une chaîne de caractères couramment exprimée sous forme de localisateur de ressource uniforme (Uniform Resource Locator, URL).

##### 1.5. Identificateur de ressource unique

Une valeur identifiant la ressource de manière unique.

Le domaine de valeur de cet élément de métadonnées est un code obligatoire sous forme de chaîne de caractères, généralement attribué par le propriétaire des données, et un espace de noms sous forme de chaîne de caractères qui identifie de manière unique le contexte du code d'identification (par exemple le propriétaire des données).

##### 1.6. Ressource couplée

Si la ressource est un service de données géographiques, cet élément de métadonnées identifie, le cas échéant, la série ou les séries de données géographiques cibles du service grâce à leurs identificateurs de ressource uniques (Unique Resource Identifiers, URI).

##### 1.7. Langue de la ressource

La langue ou les langues utilisées dans le cadre de la ressource

#### 2. CLASSIFICATION DES DONNÉES ET SERVICES GÉOGRAPHIQUES

##### 2.1. Catégorie thématique

Ce champ permet de classer la ressource dans une ou plusieurs catégories d'une liste fermée et internationale, facilitant ainsi la recherche de cette donnée. Il est important d'associer la ressource à la (ou les) thématique la plus pertinente.

##### 2.2. Type de service de données géographiques

Cas habituels :
- un service CSW est un « service de recherche »,
- un service WMS est un « service de consultation »
- et un service WFS est un « service de téléchargement ».
- un service WPS faisant du géotraitement (par exemple : chaînage de d'éléments hydrographiques ou croisement de couche) sera de type « autre ».

#### 3. MOT CLÉ

Liste de mots-clés (s'inspirer du site https://www.eionet.europa.eu/gemet/en/inspire-themes/)

#### 4. SITUATION GÉOGRAPHIQUE

##### 4.1. Rectangle de délimitation géographique

Étendue de la ressource dans l'espace géographique, exprimée sous la forme d'un rectangle de délimitation.

Ce rectangle de délimitation est défini par les longitudes est et ouest et les latitudes sud et nord en degrés décimaux, avec une précision d'au moins deux chiffres après la virgule.

#### 5. RÉFÉRENCE TEMPORELLE

Au moins un des éléments de métadonnées indiqués aux points 5.1 à 5.4 devra être fourni.

##### 5.1. Étendue temporelle

L'étendue temporelle définit la période de temps couverte par le contenu de la ressource. Cette période peut être exprimée de l'une des manières suivantes :
- une date déterminée,
- un intervalle de dates exprimé par la date de début et la date de fin de l'intervalle,
- un mélange de dates et d'intervalles.

##### 5.2. Date de publication

Date de publication de la ressource lorsqu'elle est disponible ou date d'entrée en vigueur. Il peut y avoir plus d'une date de publication.

##### 5.3. Date de dernière révision

Date de la dernière révision de la ressource, si la ressource a été révisée. Il ne doit pas y avoir plus d'une date de dernière révision.

##### 5.4. Date de création

Date de création de la ressource. Il ne doit pas y avoir plus d'une date de création.

#### 6. QUALITÉ ET VALIDITÉ

##### 6.1. Généalogie

La généalogie fait état de l'historique du traitement et/ou de la qualité générale de la série de données géographiques.

Le cas échéant, elle peut inclure une information indiquant si la série de données a été validée ou soumise à un contrôle de qualité, s'il s'agit de la version officielle (dans le cas où il existe plusieurs versions) et si elle a une valeur légale.

##### 6.2. Résolution spatiale

La résolution spatiale se rapporte au niveau de détail de la série de données. Elle est exprimée comme un ensemble de valeurs de distance de résolution allant de zéro à plusieurs valeurs (normalement utilisé pour des données maillées et des produits dérivés d'imagerie) ou exprimée en échelles équivalentes (habituellement utilisées pour les cartes ou les produits dérivés de cartes).

#### 7. CONFORMITÉ

Les exigences en ce qui concerne la conformité et le degré de conformité avec les règles de mise en œuvre adoptées par INSPIRE :

##### 7.1. Spécification

Indication de la référence des règles de mise en œuvre de la directive ou des autres spécifications auxquelles une ressource particulière est conforme.

Une ressource peut être conforme à plusieurs règles de mise en œuvre adoptées par la directive ou à d'autres spécifications.

Cette indication inclut au moins le titre et une date de référence (date de publication, date de dernière révision ou de création) des règles de mise en oeuvre adoptées par la directive ou des autres spécifications auxquelles la ressource est conforme.

##### 7.2. Degré

Degré de conformité de la ressource par rapport aux règles de mise en œuvre adoptées par la directive ou à d'autres spécifications.

#### 8. CONTRAINTES EN MATIÈRE D'ACCÈS ET D'UTILISATION

Une contrainte en matière d'accès et d'utilisation peut être l'un des deux éléments suivants ou les deux :

##### 8.1. Conditions applicables à l'accès et à l'utilisation

Cet élément de métadonnées définit les conditions applicables à l'accès et à l'utilisation des séries et des services de données géographiques, et, le cas échéant, les frais correspondants.

Cet élément doit avoir des valeurs. Si aucune condition ne s'applique à l'accès à la ressource et à son utilisation, on utilisera la mention «aucune condition ne s'applique». Si les conditions sont inconnues, on utilisera la mention «conditions inconnues».

Cet élément fournira aussi des informations sur tout frais éventuel à acquitter pour avoir accès à la ressource et l'utiliser, le cas échéant, ou fera référence à un localisateur de ressource uniforme (Uniform Resource Locator, URL) où il sera possible de trouver des informations sur les frais.

##### 8.2. Restrictions concernant l'accès public

Lorsque les producteurs restreignent l'accès public aux séries et aux services de données géographiques, cet élément de métadonnées fournit des informations sur les restrictions et les raisons de celles-ci.

S'il n'y a pas de restrictions concernant l'accès public, cet élément de métadonnées l'indiquera.

#### 9. ORGANISATIONS RESPONSABLES DE L'ÉTABLISSEMENT, DE LA GESTION, DE LA MAINTENANCE ET DE LA DIFFUSION DES SÉRIES ET DES SERVICES DE DONNÉES GÉOGRAPHIQUES

##### 9.1. Partie responsable

Description de l'organisation responsable de l'établissement, de la gestion, de la maintenance et de la diffusion de la ressource.

Cette description inclut:
- description sous forme de texte libre,
- une adresse e-mail de contact sous la forme d'une chaîne de caractères.

##### 9.2. Rôle de la partie responsable

Fonction de l'organisation responsable.

La norme EN ISO 19115 identifie les responsabilités élémentaires suivantes : le fournisseur, le gestionnaire, le propriétaire, l'utilisateur, le distributeur, le commanditaire, le point de contact, le maître d’œuvre principal (ou d'ensemble), l'exécutant secondaire, l'éditeur et l'auteur.

Ces responsabilités élémentaires recouvrent d'autres notions très utilisées en France, notamment :
- Le maître d'ouvrage correspond généralement au commanditaire de la ressource et peut accessoirement en être le propriétaire ;
- Le producteur en tant que fabricant correspond au maître d’œuvre principal ;
- L'intégrateur de la ressource peut correspondre au gestionnaire et/ou maître d’œuvre principal de la ressource.

#### 10. MÉTADONNÉES CONCERNANT LES MÉTADONNÉES

##### 10.1. Point de contact des métadonnées

Description de l'organisation responsable de la création et de la maintenance des métadonnées. Cette description inclut:
- le nom de l'organisation sous forme de texte libre,
- une adresse e-mail de contact sous la forme d'une chaîne de caractères.

##### 10.2. Date des métadonnées

Date à laquelle l'enregistrement de métadonnées a été créé ou actualisé.

##### 10.3. Langue des métadonnées

C'est la langue dans laquelle les éléments de métadonnées sont exprimés.

---

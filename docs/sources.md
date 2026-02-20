# Les sources géomatiques en urbanisme

## [Les Geoservices de l'IGN](https://geoservices.ign.fr/catalogue)

Les géoservices de l'[IGN (Institut national de l'information géographique et forestière)](https://www.ign.fr/) sont un ensemble de services numériques qui permettent d'accéder, d'utiliser et d'intégrer les données géographiques officielles françaises dans des applications ou des projets.

### Ce qu'ils proposent concrètement :

Ils donnent accès à des flux de cartes et d'images (fonds de carte, photographies aériennes, cartes topographiques, vues satellites) via des protocoles standards comme WMS, WMTS ou TMS, que l'on peut intégrer dans un SIG ou une application web.
Ils offrent aussi des APIs thématiques, notamment pour le géocodage (transformer une adresse en coordonnées et inversement), le calcul d'itinéraires, le calcul de profils altitudinaux, ou encore la recherche de lieux et de parcelles cadastrales.
Il y a également un accès aux données vectorielles de référence comme la BD TOPO, la BD ORTHO, le Référentiel Grande Échelle (RGE), le Plan IGN, etc.

### À qui s'adressent-ils ?

Aussi bien aux développeurs qui veulent intégrer une carte dans une application web ou mobile, qu'aux collectivités, entreprises, chercheurs ou particuliers qui ont besoin de données géographiques fiables et officielles sur la France.

### Comment y accéder ?

Depuis 2021, l'IGN a engagé une ouverture importante de ses données : beaucoup de services sont désormais accessibles gratuitement via le portail geoservices.ign.fr, parfois avec une simple clé API. Certaines données plus spécifiques restent soumises à des conditions particulières.
En résumé, c'est la porte d'entrée vers la cartographie officielle de la France, conçue pour être réutilisable par tous.

## [Le Géoportail de l'urbanisme](https://www.geoportail-urbanisme.gouv.fr/)

Le Géoportail de l'urbanisme (GPU) donne accès aux règlementations d’urbanisme des territoires.

Il permet à chaque citoyen de :
- Localiser son terrain ;
- Faire apparaître et interroger le zonage et les prescriptions d’urbanisme qui s’y appliquent ;
- Consulter directement en ligne tout ou partie des documents d’urbanisme (données géographiques et règlements de la commune ou de l’intercommunalité) ;
- Connaître les servitudes d’utilité publique affectant l’utilisation de son terrain ;
- Télécharger les données géographiques (zonages) et littérales (règlement au format .pdf) ;
- Afficher en superposition des couches d’information (sélection des prescriptions du règlement d’urbanisme, fond cadastral, photo aérienne, etc.) ;
- Créer et diffuser sa propre carte grâce aux outils de dessin (prescriptions à représenter, outils de dessin).


Il permet également aux professionnels de réaliser diverses études à partir des données qui y sont présentes.

## [Le Cadastre](https://cadastre.data.gouv.fr/)

### Qu’est-ce que le cadastre ?

Pour plus d'informations sur le cadastre, vous pouvez consulter la [page dédiée](./cadastre.md).

### Quelles sont les données ouvertes ?

Les données ouvertes à ce jour sont celles du plan cadastral : parcelles, sections, bâti et éléments d’habillage. Les fichiers des propriétés et des propriétaires ne sont pas concernés.

## [L'INSEE](https://statistiques-locales.insee.fr/#c=home)

L'INSEE (Institut national de la statistique et des études économiques) n'est pas à proprement parler un fournisseur de géoservices, mais c'est une source de données statistiques indispensable en géomatique, car toutes ses données sont ancrées dans un maillage géographique très précis. Voici comment s'articule son rôle en tant que base de données géospatiale.

### Le COG : la colonne vertébrale géographique

Tout part du Code Officiel Géographique (COG), le référentiel de codes officiels attribués à chaque entité administrative française (communes, départements, régions, EPCI…). C'est la clé de jointure universelle du géomaticien français : quand on veut rattacher n'importe quelle donnée statistique à une géographie, on passe par le code INSEE de la commune. Il est plus fiable que le code postal (qui peut correspondre à plusieurs communes, et vice versa) et stable dans le temps. Partout où c'est possible, utiliser le code INSEE du COG plutôt qu'un code postal ou un nom est recommandé, car il est le plus fiable dans le temps. Data

### Les maillages géographiques produits par l'INSEE

L'INSEE découpe le territoire en plusieurs niveaux emboîtés, chacun utile selon l'échelle d'analyse :

- La commune : le niveau de base, identifiée par son code COG.
- Les IRIS (Îlots Regroupés pour l'Information Statistique) : un code IRIS désigne un quartier d'environ 2000 habitants, il s'agit d'un découpage qui se veut homogène afin que les données statistiques rattachées à l'IRIS aient une bonne cohérence. 76310 Ce découpage est produit en collaboration avec l'IGN, qui en fournit les contours géométriques. Il existe environ 16 100 IRIS en France, ce qui en fait le maillage infracommunal de référence.
- Le carroyage : une grille régulière de carreaux (200m ou 1km de côté), indépendante de tout découpage administratif. Le carroyage est une technique de quadrillage consistant à découper le territoire en carreaux pour y diffuser de l'information statistique à un niveau faiblement agrégé. Les carreaux permettent de s'affranchir des limites administratives habituelles et peuvent être assemblés pour construire ou approcher n'importe quel zonage à façon. data.gouv.fr Les données carroyées portent notamment sur les revenus fiscaux, la structure des ménages, les logements. Elles sont disponibles aux formats shapefile, geopackage ou CSV. data.gouv.fr


### Les données statistiques géolocalisées

Au-delà des maillages eux-mêmes, l'INSEE produit des masses de données statistiques rattachées à ces découpages : recensement de la population, données sur l'emploi, sur le logement, sur les revenus (Filosofi), sur les entreprises (base Sirene avec coordonnées géographiques des établissements)… Toutes ces données sont exploitables en géomatique dès lors qu'on les joint à leurs contours géographiques via le code INSEE.
L'API Données Locales permet d'interroger ces statistiques directement par niveau géographique (commune, IRIS, département…) sans télécharger des fichiers volumineux.

### Les limites à connaître

L'INSEE n'est pas un fournisseur de géométries au sens strict : il fournit les codes et les statistiques, mais les contours géographiques (communes, IRIS) sont techniquement produits et diffusés par l'IGN (via Admin Express et le produit IRIS GE). Il faut donc systématiquement croiser les deux sources : les statistiques de l'INSEE et les géométries de l'IGN, en utilisant le code INSEE comme clé de jointure.

## [Picto Occitanie](https://www.picto-occitanie.fr/accueil)

PICTO-Occitanie est un portail régional de diffusion de données géographiques publiques, piloté par la DREAL Occitanie (Direction Régionale de l'Environnement, de l'Aménagement et du Logement). C'est en quelque sorte l'équivalent régional de ce que l'IGN fait à l'échelle nationale, mais centré sur les données produites par les services de l'État en Occitanie.

### Ce que c'est concrètement

Le portail Picto-Occitanie est un site de diffusion des données des services de l'État, notamment la DREAL, la DRAAF, l'ARS et les DDT(M). Il agrège donc en un seul endroit des données produites par des administrations différentes, sur le périmètre de la région Occitanie, avec ses 13 départements (de l'Ariège aux Pyrénées-Orientales).

### Les quatre grandes fonctions du portail

- Le portail donne accès à des données interministérielles de référence, produites selon les périmètres de compétence de chaque service, homogènes sur l'ensemble de la région, respectant les standards nationaux lorsqu'ils existent, et toujours assorties d'une fiche de métadonnées compatible INSPIRE.
- Il propose également des espaces thématiques structurés autour de grands domaines : connaissance du territoire, gestion de l'espace, risques, énergie, eau, transports, nature et paysages, santé... Chaque espace regroupe les données pertinentes avec leur contexte, de la documentation et des outils dédiés.
- Un catalogue de données (basé sur GeoNetwork, le standard open source de catalogage) recense et documente l'ensemble des jeux de données disponibles. C'est l'entrée principale pour les géomaticiens qui cherchent une donnée précise.
- Enfin, des outils de visualisation sont proposés pour rendre les données utilisables par tous, y compris par des utilisateurs ne maîtrisant pas de logiciels géomatiques professionnels. On y trouve notamment un visualiseur cartographique dynamique et PICTO-Stat, qui est un observatoire géostatistique construit sur Géoclip.

### Les données et les services techniques

Pour les professionnels, PICTO-Occitanie propose des flux WMS et WFS directement intégrables dans un SIG ou une application web. Il renvoie aussi vers des services connexes comme les géoservices de l'IGN, le Géoportail de l'Urbanisme, ou OpenIG (la plateforme open data de la région Occitanie).

### Le positionnement dans l'écosystème

L'accès au portail est gratuit et les données sont libres et ouvertes, conformément aux recommandations en matière d'Open Data. Les objectifs affichés sont de simplifier le partage de données entre services de l'État, promouvoir leur diffusion en open data, et les rendre accessibles au grand public.
En résumé, PICTO-Occitanie est le nœud régional de l'information géographique publique pour l'Occitanie : là où l'IGN opère à l'échelle nationale sur des données de référence, PICTO-Occitanie rassemble et redistribue les données sectorielles (environnement, urbanisme, risques, santé, agriculture…) produites par les services de l'État sur le territoire régional, en assurant leur documentation et leur accessibilité.

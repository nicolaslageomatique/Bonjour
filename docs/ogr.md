# OGR-GDAL

## Définition

GDAL (Geospatial Data Abstraction Library) est une bibliothèque libre permettant de lire et de traiter un très grand nombre de format d'images géographiques (notamment GeoTIFF et ECW) depuis des langages de programmation tels que C, C++, C sharp / .Net, Java, Ruby, VB6, Perl, Python, ou encore le langage statistique R.

Un sous-ensemble de cette bibliothèque est la bibliothèque OGR permettant d'accéder à la plupart des formats courants de données vectorielles (à l'exception notable d'AutoCAD).

La version binaire inclut de nombreux utilitaires de conversion et de transformation et de reprojection pour traiter directement les photos ou les vecteurs.

GDAL/OGR fait partie des projets de la Fondation Open Source Geospatial.

Cette bibliothèque est un des piliers des systèmes d'informations géographique libres, car elle permet d'assurer la compatibilité avec de nombreux systèmes commerciaux reposant sur des formats propriétaires tout autant que sur les normes de l'Open Geospatial Consortium.


## Une bibliothèque pour les vecteurs

La bibliothèque OGR Simple Feature est une bibliothèque et outils en ligne de commande, faisant partie de la bibliothèque Utilitaires GDAL.

Les formats sont aussi nombreux https://gdal.gloobe.org/ogr/formats/index.html#gdal-ogr-formats-index dont les formats ouverts (gpkg) et propriétaires (ArcSDE).

Il est possible d'utiliser du SQL dans certaines commandes des outils.

Les outils principaux
- ogrinfo : à l'instar de gdalinfo, il apporte une série d'information sur le fichier analysé.
- ogrindex : créer un index de tuile, pour améliorer le chargement ou traitement de la couche indexée (MapServer).
- ogr2ogr : outils pour convertir des formats vecteurs. Il a la capacité de réaliser différentes opérations supplémentaires comme de la reprojection , des sélections attributaires ou spatiales.

On retrouve aussi ogr dans QGIS.

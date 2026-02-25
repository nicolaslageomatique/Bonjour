# La directive INSPIRE

## Historique

La directive INSPIRE (*Infrastructure for Spatial Information in the European Community*) trouve ses origines dans les années 1990, période à laquelle l'Union européenne prend conscience du morcellement des données géographiques entre les États membres. Chaque pays, chaque région, voire chaque administration, produisait et conservait ses propres données spatiales dans des formats incompatibles, rendant toute vision transeuropéenne extrêmement difficile.

Les premières réflexions formelles émergent au sein de la Commission européenne dès 1998-2000, notamment portées par la Direction générale de l'environnement, qui souhaitait disposer d'une base d'information géographique cohérente pour piloter les politiques environnementales communautaires. Ces travaux aboutissent à la publication de la **directive 2007/2/CE du Parlement européen et du Conseil**, adoptée le **14 mars 2007** et entrée en vigueur le 15 mai 2007.

Sa mise en œuvre s'est ensuite échelonnée sur plusieurs années, avec des règlements d'exécution adoptés progressivement entre 2008 et 2013, couvrant les métadonnées, l'interopérabilité des données, et les services de réseau. La directive a été renforcée et articulée avec d'autres réglementations européennes, notamment le règlement sur les données ouvertes (2019) et le règlement européen sur la gouvernance des données.

---

## Principes de base

INSPIRE repose sur un ensemble de principes fondateurs qui guident l'ensemble du dispositif :

**La collecte unique** : les données géographiques ne doivent être saisies qu'une seule fois et maintenues là où cela peut être fait le plus efficacement. Il n'est donc pas question de dupliquer la production de données, mais de rendre accessible ce qui existe déjà.

**L'interopérabilité** : les données doivent pouvoir être combinées de manière transparente depuis différentes sources, à travers les frontières administratives et nationales. Cela implique l'adoption de standards communs de format, de projection, de nomenclature et de modèles de données.

**La disponibilité à tous les niveaux** : les données géographiques doivent être accessibles aux autorités publiques de tous les échelons — européen, national, régional et local — ainsi qu'aux citoyens et aux entreprises.

**La transparence** : les conditions d'accès, les licences et les métadonnées associées aux données doivent être clairement documentées, afin que les utilisateurs sachent exactement ce qu'ils utilisent, d'où cela vient et dans quelles conditions.

**L'environnement comme champ prioritaire** : même si INSPIRE a une portée plus large, la politique environnementale reste le moteur principal de la directive. Les thèmes retenus reflètent directement les besoins de suivi et de reporting en matière d'environnement, d'aménagement du territoire et de développement durable.

---

## Construction de la directive

La directive s'articule autour de plusieurs piliers techniques et organisationnels :

### Les thèmes de données

INSPIRE définit **34 thèmes** répartis en trois annexes, correspondant à des catégories de données géographiques que les États membres doivent rendre accessibles :

- **Annexe I** (11 thèmes) : données de référence fondamentales, comme les systèmes de coordonnées, les réseaux de transport, l'hydrographie, les unités administratives ou les adresses.
- **Annexe II** (4 thèmes) : données également de référence mais nécessitant des spécifications plus complexes, comme l'altitude, la géologie ou l'occupation des terres.
- **Annexe III** (19 thèmes) : données thématiques, souvent environnementales, comme les zones protégées, les sols, les risques naturels, la santé et la sécurité des personnes, ou encore les installations de suivi de l'environnement.

### Les métadonnées

Chaque jeu de données couvert par INSPIRE doit être accompagné de **métadonnées** conformes à des profils précis, dérivés de la norme ISO 19115. Ces métadonnées décrivent le contenu, la qualité, la provenance, les conditions d'accès et d'utilisation des données. Elles sont publiées dans des **catalogues nationaux** interrogeables depuis le géoportail européen.

### Les services de réseau

La directive impose la mise en place de **cinq types de services** accessibles via internet :

- Les **services de découverte** (catalogue, recherche de données)
- Les **services de consultation** (visualisation, de type WMS)
- Les **services de téléchargement** (accès aux données brutes, de type WFS ou ATOM)
- Les **services de transformation** (conversion de formats ou de projections)
- Les **services d'invocation** (déclenchement de traitements)

Ces services doivent être conformes aux standards de l'OGC (*Open Geospatial Consortium*) et accessibles gratuitement pour la consultation.

### Les spécifications de données

Des **règlements d'interopérabilité** définissent pour chaque thème le modèle de données exact, les listes de valeurs (code lists), les conventions de nommage et les règles de qualité. Ces spécifications sont décrites en UML et encodées en GML (*Geography Markup Language*).

---

## Valeur légale

INSPIRE est une **directive européenne**, ce qui lui confère une valeur juridique contraignante pour l'ensemble des États membres. Contrairement à un règlement européen qui s'applique directement, une directive fixe des objectifs à atteindre tout en laissant aux États la liberté de choisir les moyens de transposition dans leur droit national.

Les organismes du **secteur public** qui produisent ou détiennent des données géographiques relevant des 34 thèmes sont juridiquement tenus de respecter les obligations de la directive, notamment :

- Publier des métadonnées dans les délais prescrits
- Mettre en place les services de réseau réglementaires
- Assurer la conformité de leurs données aux spécifications d'interopérabilité

Des **dérogations** sont néanmoins prévues, notamment pour des raisons de sécurité nationale, de confidentialité commerciale ou lorsque le coût de mise en conformité serait disproportionné par rapport aux bénéfices attendus.

La Commission européenne assure le suivi de la mise en œuvre via un mécanisme de **reporting biennal** : chaque État membre doit transmettre un rapport d'avancement évaluant le taux de conformité de ses données et services. En cas de non-respect, la Commission peut engager des **procédures d'infraction** à l'encontre d'un État membre, pouvant mener à des sanctions financières devant la Cour de justice de l'Union européenne.

---

## Retranscription française

La France a transposé la directive INSPIRE par l'**ordonnance n° 2010-1232 du 21 octobre 2010**, complétée par le **décret n° 2011-1780 du 5 décembre 2011** relatif à l'accès aux informations géographiques publiques et à leur partage. Ces textes sont codifiés dans le **Code de l'environnement** (articles L. 127-1 à L. 127-10 et R. 127-1 et suivants).

L'organisme chargé de la coordination nationale est le **CNIG** (*Conseil National de l'Information Géolocalisée*), qui réunit les producteurs publics de données, les ministères et les représentants des collectivités territoriales. Il assure le pilotage des groupes de travail thématiques et valide les profils de métadonnées adaptés au contexte français.

La mise en œuvre opérationnelle repose sur plusieurs acteurs clés :

**L'IGN** (*Institut national de l'information géographique et forestière*) joue un rôle central en tant que producteur des données de référence (BD TOPO, BD ORTHO, RGE…) et opérateur du **Géoportail**, qui fait office de point d'accès national aux données et services INSPIRE français.

**Le géocatalogue national** (aujourd'hui intégré aux plateformes **geo.data.gouv.fr** et **data.gouv.fr**) centralise les métadonnées des jeux de données conformes, permettant leur découverte depuis le portail européen INSPIRE.

Les **collectivités territoriales** et les établissements publics sont également des acteurs majeurs, particulièrement pour les thèmes relatifs à l'urbanisme (PLU, zonages réglementaires), aux réseaux et aux risques. Le **Géoportail de l'urbanisme** constitue à ce titre une plateforme phare de mise en conformité INSPIRE pour les documents d'urbanisme.

Malgré ces avancées, la France — comme la plupart des États membres — accuse encore des retards dans la mise en conformité complète des données, en particulier pour les thèmes de l'Annexe III, souvent portés par des administrations moins outillées techniquement. Les rapports de la Commission soulignent régulièrement des lacunes dans la qualité des métadonnées et l'accessibilité réelle des services de téléchargement.

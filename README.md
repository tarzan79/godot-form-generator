#Générateur de formulaire

plugin pour générer des formulaires, soit à partir d'un dictionnaire, d'un objet resource, ou à partir d'un schema json

Attention: ce plugin est encore en developpement, il ne doit donc pas etre utilisé pour une mise en production (et meme pour une phase de dev, ca reste compliqué)


il est aussi prevu de rajouter un mode edition pour
- editer un schema json, donc rajouter, supprimer des champs
- ajouter/supprimer des clé/valeur d'un dictionnaire (génération à partir de données)


pour la génération de formulaire à partir de données, les types de donnée supporté sont:
- string
- int
- float
- color
- vector2
- vector3
- dictionnary
- array


pour la génération de formulaire à partir de schéma, les types de donnée supporté sont:
- string
- number
- integer
- boolean$
- array
- dictionary


pour la génération a partir de ressource, les types supporté sont:
- bool
- int
- float
- string (enum, file, dir, multiline)
- vector2
- vector3
- color
- dictionnary (non fonctionnel, le recursif pose probleme)
- array (non fonctionnel, le recursif pose probleme)
- les differents poolArray viendront bientot
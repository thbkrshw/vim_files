# Installation

    git clone git://github.com/thbkrshw/vim_files.git .vim
    cd .vim
    ./afterclone

Le script python afterclone s'occupe de créer le répertoire de backup,
d'initialiser les plugins (sous modules git), et de faire le lien symbolique du
vimrc au bon endroit.


# Utilisation

Récapitulatif des raccourcis les plus utilisés : 

  * flèche droite : liste des tags du programme (nécessite exhuberant-ctags)
  * flèche gauche : arborescence des fichiers
  * flèches haut et bas : change de tab
 
  * space : effectue une recherche dans le fichier
  * ,c<space> : commente/décommente la ligne courrante
  * Shift<space> : lance Ack (nécessite Ack, grep plus que largement amélioré)
 
  * C-o : aller en avant dans l'historique de la position du point d'insertion (à
    travers les fichiers aussi)
  * C-i : aller en arrière

  * gf : ouvre le fichier sous le pointeur
  * gd : aller à la définition du symbole
  * K : aller à la manpage du symbole sous le curseur

  * ggVG= : indenter tout le fichier

  * ,s : split vertical du fichier courant

  * C-h, C-j, C-k, C-l : navigue entre les fenêtres de vim


 

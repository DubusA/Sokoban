# Sokoban
Développement d'un jeu de Sokoban que j'ai réalisé pendant mon stage de découverte de l'entreprise de G1 (première année) à l'École Centrale de Lille.  
Ce stage a été effectué au centre de recherche Inria Lille Nord - Europe du 17 janvier au 11 février 2022.  
Le but du jeu de Sokoban est de déplacer des boîtes pour qu'elles soient toutes sur les emplacements à atteindre en un nombre de déplacements minimal.  
On peut ajouter sur un plateau de jeu de taille donnée un joueur, des murs, des boîtes à déplacer et des emplacements à atteindre.  
On peut également afficher le plateau de jeu avec tous ces éléments selon le code suivant :  
P : le joueur  
W : un mur  
O : une boîte à déplacer  
X : un emplacement à atteindre  
_ : une case vide  
Un exemple est disponible dans le test <em>testSokobanLevel1IsOver</em>.  
Après avoir créé le plateau de jeu, on vérifie son affichage puis on déplace le joueur dans différentes directions pour déplacer les boîtes.  
On peut ensuite afficher le plateau pour voir que toutes les boîtes sont sur les emplacements à atteindre et on peut compter les mouvements.  

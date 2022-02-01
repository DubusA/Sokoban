Class {
	#name : #WallTile,
	#superclass : #Tile,
	#category : #Sokoban
}

{ #category : #printing }
WallTile >> printOn: aStream [
	"position printOn: aStream." "si on veut afficher les coordonées du point"
	"1ere version : seulement  aStream << 'W'  "
	"2e version : condition pour remplacer l'affichage si on a un joueur ou une boite sur la case"
	(players isEmpty & boxes isEmpty & goals isEmpty) ifTrue: [ aStream << 'W' ]
	ifFalse: [ players do: [ :aPlayer | aPlayer printOn: aStream ] .
				  boxes do: [ :aBox | aBox printOn: aStream ] .
				  goals do: [ :aGoal | aGoal printOn: aStream ] ].
]

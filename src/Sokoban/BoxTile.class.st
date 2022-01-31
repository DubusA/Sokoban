Class {
	#name : #BoxTile,
	#superclass : #Tile,
	#category : #Sokoban
}

{ #category : #printing }
BoxTile >> printOn: aStream [
	"position printOn: aStream." "si on veut afficher les coordonées du point"
	"1ere version : seulement  aStream << 'O'  "
	"2e version : condition pour remplacer l'affichage si on a un joueur ou une boite sur la case"
	(players isEmpty & boxes isEmpty) ifTrue: [ aStream << 'O' ]
	ifFalse: [ players do: [ :aPlayer | aPlayer printOn: aStream ] .
				  boxes do: [ :aBox | aBox printOn: aStream ] ].
]

Class {
	#name : #PlayerTile,
	#superclass : #Tile,
	#category : #Sokoban
}

{ #category : #printing }
PlayerTile >> printOn: aStream [
	"position printOn: aStream." "si on veut afficher les coordonées du point"
	aStream << 'P'
]

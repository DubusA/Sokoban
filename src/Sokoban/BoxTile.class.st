Class {
	#name : #BoxTile,
	#superclass : #Tile,
	#category : #Sokoban
}

{ #category : #printing }
BoxTile >> printOn: aStream [
	"position printOn: aStream." "si on veut afficher les coordonées du point"
	aStream << 'O'
]

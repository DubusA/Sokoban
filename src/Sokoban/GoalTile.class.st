Class {
	#name : #GoalTile,
	#superclass : #Tile,
	#category : #Sokoban
}

{ #category : #printing }
GoalTile >> printOn: aStream [
	"position printOn: aStream." "si on veut afficher les coordonées du point"
	aStream << 'X'
]

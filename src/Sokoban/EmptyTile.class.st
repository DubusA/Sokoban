Class {
	#name : #EmptyTile,
	#superclass : #Tile,
	#category : #Sokoban
}

{ #category : #printing }
EmptyTile >> printOn: aStream [
	"position printOn: aStream." "si on veut afficher les coordonées du point"
	"1ere version : seulement  aStream << 'O'  "
	"2e version : condition pour remplacer l'affichage si on a un joueur ou une boite sur la case"
	(players isEmpty & boxes isEmpty & goals isEmpty) ifTrue: [ aStream << '_' ]
	ifFalse: [ players isNotEmpty ifTrue: [ players do: [ :aPlayer | aPlayer printOn: aStream ] ]
		ifFalse: [ boxes isNotEmpty ifTrue: [ boxes do: [ :aBox | aBox printOn: aStream ] ]
			ifFalse: [ goals isNotEmpty ifTrue: [ goals do: [ :aGoal | aGoal printOn: aStream ] ] 
				ifFalse: [ walls do: [ :aWall | aWall printOn: aStream ] ] ] ] ]
]

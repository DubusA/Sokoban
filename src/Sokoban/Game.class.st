Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'tiles',
		'player',
		'box',
		'movements'
	],
	#category : #Sokoban
}

{ #category : #initialization }
Game >> initialize [ 
	player := Point new. "position x et y du joueur"
	box := OrderedCollection new. "collection de boites qui contiendra des points (position x et y)"
	movements := 0.
]

{ #category : #accessing }
Game >> movements: aNumber [
"nombre de mouvement effectués dans la partie"
	movements := aNumber 
]

{ #category : #printing }
Game >> printOn: aStream [

	"tiles do: [ :aTile | aTile printOn: aStream ]"  "pour une liste"
	tiles do: [ :aCollection | aCollection do: [ :aTile | aTile printOn: aStream ].
										aStream cr. ] "pour une liste de liste"
	"il faut rajouter le passage à la ligne et l'espace après chaque ligne"
]

{ #category : #'as yet unclassified' }
Game >> size [ 
	^ ((tiles at: 1) size)@(tiles size)
]

{ #category : #'as yet unclassified' }
Game >> sizeX: aNumberX sizeY: aNumberY [

	tiles := Array new: aNumberY .
	1 to: aNumberY do: [ :i | tiles at: i put: (Array new: aNumberX) ] .
	1 to: aNumberY do: [ :i | 1 to: aNumberX do: [ :j | (tiles at: i) at: j put: (WallTile new position: i@j ) ] ] .
	"on met une case (tile) sur chaque position des collections de la collection"
]

{ #category : #'as yet unclassified' }
Game >> tileNumber: aNumber [ 
"a modifier" "remplacé par sizeX:sizeY: "
"	tiles := Array new: aNumber .
	1 to: aNumber do: [ :i | tiles at: i put: (SLTile new position: i) ] . "
	
]

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

{ #category : #adding }
Game >> addBox: aBox [
	((tiles at: 2) at: 3) addBox: aBox .
	"il y a des murs autour du plateau de jeu donc on ne met rien en 1@1"	
	aBox position: 2@3. "pour pouvoir avoir la position de la boite (pour ensuite pouvoir la déplacer)"
]

{ #category : #adding }
Game >> addPlayer: aPlayer [
	((tiles at: 2) at: 2) addPlayer: aPlayer .
	"il y a des murs autour du plateau de jeu donc on ne met rien en 1@1"
	aPlayer position: 2@2. "pour pouvoir avoir la position du joueur (pour ensuite pouvoir le déplacer)"
]

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
Game >> tileAtX: aNumberX atY: aNumberY [
	^ (tiles at: aNumberY) at: aNumberX 
]

{ #category : #'as yet unclassified' }
Game >> tileForPlayerTowardDown: aPlayer [

	^ self tileAtX: aPlayer position x + 1 atY: aPlayer position y
]

{ #category : #'as yet unclassified' }
Game >> tileForPlayerTowardLeft: aPlayer [

	^ self tileAtX: aPlayer position x atY: aPlayer position y - 1
]

{ #category : #'as yet unclassified' }
Game >> tileForPlayerTowardRight: aPlayer [

	^ self tileAtX: aPlayer position x atY: aPlayer position y + 1
]

{ #category : #'as yet unclassified' }
Game >> tileForPlayerTowardUp: aPlayer [

	^ self tileAtX: aPlayer position x - 1 atY: aPlayer position y
]

{ #category : #'as yet unclassified' }
Game >> tileNumber: aNumber [ 
"a modifier" "remplacé par sizeX:sizeY: "
"	tiles := Array new: aNumber .
	1 to: aNumber do: [ :i | tiles at: i put: (SLTile new position: i) ] . "
	
]

{ #category : #accessing }
Game >> tiles [
	^ tiles
]

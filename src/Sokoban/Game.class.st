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
	aBox position: 3@2. "pour pouvoir avoir la position de la boite (pour ensuite pouvoir la déplacer)"
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

{ #category : #'as yet unclassified' }
Game >> moveBoxTowardDown: aBox [

	| targetTile |
	targetTile := self tileForPlayerOrBoxTowardDown: aBox.
	(self tileOfPlayerOrBox: aBox) removeBox: aBox.
	targetTile addBox: aBox.
	aBox position: targetTile position.
]

{ #category : #'as yet unclassified' }
Game >> moveBoxTowardLeft: aBox [

	| targetTile |
	targetTile := self tileForPlayerOrBoxTowardLeft: aBox.
	(self tileOfPlayerOrBox: aBox) removeBox: aBox.
	targetTile addBox: aBox.
	aBox position: targetTile position.
]

{ #category : #'as yet unclassified' }
Game >> moveBoxTowardRight: aBox [

	| targetTile |
	targetTile := self tileForPlayerOrBoxTowardRight: aBox.
	(self tileOfPlayerOrBox: aBox) removeBox: aBox.
	targetTile addBox: aBox.
	aBox position: targetTile position.
]

{ #category : #'as yet unclassified' }
Game >> moveBoxTowardUp: aBox [

	| targetTile |
	targetTile := self tileForPlayerOrBoxTowardUp: aBox.
	(self tileOfPlayerOrBox: aBox) removeBox: aBox.
	targetTile addBox: aBox.
	aBox position: targetTile position.
]

{ #category : #'as yet unclassified' }
Game >> movePlayerTowardDown: aPlayer [

	| targetTile |
	movements := movements + 1 .
	targetTile := self tileForPlayerOrBoxTowardDown: aPlayer.
	(self tileOfPlayerOrBox: aPlayer) removePlayer: aPlayer.
	targetTile addPlayer: aPlayer.
	aPlayer position: targetTile position.
]

{ #category : #'as yet unclassified' }
Game >> movePlayerTowardLeft: aPlayer [

	| targetTile |
	movements := movements + 1 .
	targetTile := self tileForPlayerOrBoxTowardLeft: aPlayer.
	(self tileOfPlayerOrBox: aPlayer) removePlayer: aPlayer.
	targetTile addPlayer: aPlayer.
	aPlayer position: targetTile position.
]

{ #category : #'as yet unclassified' }
Game >> movePlayerTowardRight: aPlayer [

	| targetTile |
	movements := movements + 1 .
	targetTile := self tileForPlayerOrBoxTowardRight: aPlayer.
	(self tileOfPlayerOrBox: aPlayer) removePlayer: aPlayer.
	targetTile addPlayer: aPlayer.
	aPlayer position: targetTile position.
]

{ #category : #'as yet unclassified' }
Game >> movePlayerTowardUp: aPlayer [

	| targetTile |
	movements := movements + 1 .
	targetTile := self tileForPlayerOrBoxTowardUp: aPlayer.
	(self tileOfPlayerOrBox: aPlayer) removePlayer: aPlayer.
	targetTile addPlayer: aPlayer.
	aPlayer position: targetTile position.
]

{ #category : #accessing }
Game >> movements [

	^ movements 
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
	1 to: aNumberY do: [ :i | 1 to: aNumberX do: [ :j | (tiles at: i) at: j put: (WallTile new position: j@i ) ] ] .
	"on met une case (tile) sur chaque position des collections de la collection"
]

{ #category : #'as yet unclassified' }
Game >> tileAtX: aNumberX atY: aNumberY [
	^ (tiles at: aNumberY) at: aNumberX 
]

{ #category : #'as yet unclassified' }
Game >> tileForPlayerOrBoxTowardDown: aPlayerOrBox [
"donne la case où arrivera le joueur ou la boite après le déplacement"
	^ self tileAtX: aPlayerOrBox position x atY: aPlayerOrBox position y + 1
]

{ #category : #'as yet unclassified' }
Game >> tileForPlayerOrBoxTowardLeft: aPlayerOrBox [
"donne la case où arrivera le joueur ou la boite après le déplacement"
	^ self tileAtX: aPlayerOrBox position x - 1 atY: aPlayerOrBox position y
]

{ #category : #'as yet unclassified' }
Game >> tileForPlayerOrBoxTowardRight: aPlayerOrBox [
"donne la case où arrivera le joueur ou la boite après le déplacement"
	^ self tileAtX: aPlayerOrBox position x + 1 atY: aPlayerOrBox position y
]

{ #category : #'as yet unclassified' }
Game >> tileForPlayerOrBoxTowardUp: aPlayerOrBox [
"donne la case où arrivera le joueur ou la boite après le déplacement"
	^ self tileAtX: aPlayerOrBox position x atY: aPlayerOrBox position y - 1
]

{ #category : #'as yet unclassified' }
Game >> tileNumber: aNumber [ 
"a modifier" "remplacé par sizeX:sizeY: "
"	tiles := Array new: aNumber .
	1 to: aNumber do: [ :i | tiles at: i put: (SLTile new position: i) ] . "
	
]

{ #category : #'as yet unclassified' }
Game >> tileOfPlayerOrBox: aPlayerOrBox [ 
"donne la case où se situe le joueur ou la boite (nécessaire pour implémenter le déplacement"
	^ (tiles at: aPlayerOrBox position y) at: aPlayerOrBox position x
]

{ #category : #accessing }
Game >> tiles [
	^ tiles
]

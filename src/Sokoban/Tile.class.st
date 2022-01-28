Class {
	#name : #Tile,
	#superclass : #Object,
	#instVars : [
		'players',
		'boxes',
		'position'
	],
	#category : #Sokoban
}

{ #category : #initialization }
Tile >> initialize [ 
	players := OrderedCollection new. "liste des joueur (point) présent sur les cases (0 ou 1 joueur)"
	boxes := OrderedCollection new. "liste des boites présentes sur la case (0 ou 1 boite)"
]

{ #category : #'as yet unclassified' }
Tile >> position: aPoint [
	position := aPoint
]

{ #category : #'as yet unclassified' }
Tile >> positionX: aNumberX positionY: aNumberY [
"ne sert pas, finalement j'utilise position: aPoint"
	position := aNumberX@aNumberY 
]

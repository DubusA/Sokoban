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
	movements := aNumber 
]

{ #category : #'as yet unclassified' }
Game >> size [ 
	^ (tiles size)@((tiles at: 1 ) size)
]

{ #category : #'as yet unclassified' }
Game >> sizeX: aNumberX sizeY: aNumberY [

	tiles := Array new: aNumberX .
	1 to: aNumberX do: [ :i | tiles at: i put: (Array new: aNumberY) ] .
	1 to: aNumberX do: [ :i | 1 to: aNumberY do: [ :j | (tiles at: i) at: j put: (Tile new position: i@j ) ] ] .
	"on met une case (tile) sur chaque position des collections de la collection"
]

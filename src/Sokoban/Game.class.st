Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'tiles',
		'player',
		'box'
	],
	#category : #Sokoban
}

{ #category : #initialization }
Game >> initialize [ 
	player := Point new. "position x et y du joueur"
	box := OrderedCollection new. "collection de boites qui contiendra des points (position x et y)"
	
]

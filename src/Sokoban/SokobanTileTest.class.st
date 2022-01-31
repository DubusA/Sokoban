Class {
	#name : #SokobanTileTest,
	#superclass : #TestCase,
	#category : #'Sokoban-Tests'
}

{ #category : #tests }
SokobanTileTest >> testPrinting [

	| tile |
	tile := WallTile new position: 1@3.
	self assert: tile printString equals: 'W'
]

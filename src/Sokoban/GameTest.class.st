Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #Sokoban
}

{ #category : #tests }
GameTest >> testCheckingSimpleGame [

	| game |
	game := Game new sizeX: 3 sizeY: 5.
	self assert: game size equals: 3@5
]

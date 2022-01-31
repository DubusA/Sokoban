Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'Sokoban-Tests'
}

{ #category : #tests }
GameTest >> testCheckingSimpleGame [

	| game |
	game := Game new sizeX: 3 sizeY: 5.
	self assert: game size equals: 3@5
]

{ #category : #tests }
GameTest >> testPrintingSimpleGame [

	| game |
	game := Game new sizeX: 5 sizeY: 3.
	self 
		assert: game printString 
		equals: 
'WWWWW
WWWWW
WWWWW' "on initialise avec uniquement des murs" "mettre un espace au début de chaque ligne pour aligner"
]

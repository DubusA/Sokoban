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
GameTest >> testPlayerAndBoxAtStart [

	| game jack box1|
	game := Game new sizeX: 5 sizeY: 3.
	jack := Player new name: 'Jack'.
	box1 := Box new name: 'Box1'.
	game addPlayer: jack.
	game addBox: box1.
	self assert: ((game tileAtX: 2 atY: 2) players includes: jack).
	self assert: ((game tileAtX: 3 atY: 2) boxes includes: box1).
]

{ #category : #tests }
GameTest >> testPlayerAtStart [

	| game jack |
	game := Game new sizeX: 5 sizeY: 3.
	jack := Player new name: 'Jack'.
	game addPlayer: jack.
	self assert: ((game tileAtX: 2 atY: 2) players includes: jack).
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
WWWWW
' "on initialise avec uniquement des murs" "mettre un espace au début de chaque ligne pour aligner"
]

{ #category : #tests }
GameTest >> testPrintingSimpleGameV2 [
	| game |
	game := Game new sizeX: 6 sizeY: 4.
	(game tiles at: 2) at: 2 put: (PlayerTile new position: 2@2).
	(game tiles at: 2) at: 3 put: (BoxTile new position: 2@3).
	(game tiles at: 2) at: 4 put: (Tile new position: 2@4).
	(game tiles at: 2) at: 5 put: (GoalTile new position: 2@5).
	2 to: 5 do: [ :i | (game tiles at: 3) at: i put: (Tile new position: 3@i) ].
	self assert: game printString equals: 
'WWWWWW
WPO_XW
W____W
WWWWWW
' "on initialise avec uniquement des murs" "mettre un espace au début de chaque ligne pour aligner"
]

{ #category : #tests }
GameTest >> testPrintingSimpleGameWithPlayer [

	| game jack |
	game := Game new sizeX: 5 sizeY: 3.
	jack := Player new name: 'Jack'.
	game addPlayer: jack.
	self assert: game printString equals: 
'WWWWW
WPWWW
WWWWW
' "on initialise avec uniquement des murs" "mettre un espace au début de chaque ligne pour aligner"
]

{ #category : #tests }
GameTest >> testPrintingSimpleGameWithPlayerAndBox [

	| game jack box1 |
	game := Game new sizeX: 5 sizeY: 3.
	jack := Player new name: 'Jack'.
	box1 := Box new name: 'Box1'.
	game addPlayer: jack.
	game addBox: box1.
	self assert: game printString equals: 
'WWWWW
WPOWW
WWWWW
' "on initialise avec uniquement des murs" "mettre un espace au début de chaque ligne pour aligner"
]

{ #category : #tests }
GameTest >> testTileAt [

	| game |
	game := Game new sizeX: 5 sizeY: 3.
	self assert: (game tileAtX: 3 atY: 1) printString equals: 'W'
]

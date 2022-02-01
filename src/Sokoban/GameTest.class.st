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
GameTest >> testIsNotOver [

	| game jack box1 goal1 |
	game := Game new sizeX: 6 sizeY: 4.
	jack := Player new name: 'Jack'.
	box1 := Box new name: 'Box1'.
	goal1 := Goal new name: 'Goal1'.
	game addPlayer: jack atPoint: 3@2 .
	game addBox: box1 atPoint: 4@2 .
	game addGoal: goal1 atPoint: 5@2 .
"aucun déplacement"
	self assert: jack position equals: 3@2 .
	self assert: box1 position equals: 4@2 .
	self assert: goal1 position equals: 5@2 .
	self assert: game isOver not .
]

{ #category : #tests }
GameTest >> testIsOver [

	| game jack box1 goal1 |
	game := Game new sizeX: 6 sizeY: 4.
	jack := Player new name: 'Jack'.
	box1 := Box new name: 'Box1'.
	goal1 := Goal new name: 'Goal1'.
	game addPlayer: jack atPoint: 3@2 .
	game addBox: box1 atPoint: 4@2 .
	game addGoal: goal1 atPoint: 5@2 .
	game movePlayerTowardRight: jack .
	game moveBoxTowardRight: box1 .
	self assert: jack position equals: 4@2 .
	self assert: box1 position equals: 5@2 .
	self assert: goal1 position equals: 5@2 .
	self assert: box1 position equals: goal1 position .
	self assert: game isOver .
]

{ #category : #tests }
GameTest >> testIsOverWithTwoBoxes [
"pour vérifier que ça marche même quand il y a deux boites et que box1 est sur goal2 et box2 est sur goal1 (pour vérifier que l'ordre n'a pas d'importance) "
	| game jack box1 box2 goal1 goal2 |
	game := Game new sizeX: 6 sizeY: 4.
	jack := Player new name: 'Jack'.
	box1 := Box new name: 'Box1'.
	box2 := Box new name: 'Box2'.
	goal1 := Goal new name: 'Goal1'.
	goal2 := Goal new name: 'Goal2'.
	game addPlayer: jack atPoint: 3@2 .
	game addBox: box1 atPoint: 4@3 .
	game addBox: box2 atPoint: 4@2 .
	game addGoal: goal1 atPoint: 5@2 .
	game addGoal: goal2 atPoint: 5@3 .
	game moveBoxTowardRight: box1 .
	game moveBoxTowardRight: box2 .
	self assert: jack position equals: 3@2 .
	self assert: box1 position equals: 5@3 .
	self assert: box2 position equals: 5@2 .
	self assert: box1 position equals: goal2 position .
	self assert: box2 position equals: goal1 position .
	self assert: game isOver .
]

{ #category : #tests }
GameTest >> testMovePlayerADirectionRight [

	| game jack |
	game := Game new sizeX: 5 sizeY: 3.
	jack := Player new name: 'Jack'.
	game addPlayer: jack.
	game movePlayerTowardRight: jack.
	self assert: jack position equals: 3@2.
	self assert: (game tileAtX: 2 atY: 2 ) players isEmpty .
	self assert: ((game tileAtX: 3 atY: 2 ) players includes: jack) .
]

{ #category : #tests }
GameTest >> testMovePlayerAndBoxADirectionDownAndPrinting [

	| game jack box1 |
	game := Game new sizeX: 6 sizeY: 4.
	jack := Player new name: 'Jack'.
	box1 := Box new name: 'Box1'.
	game addPlayer: jack.
	game addBox: box1.
	game movePlayerTowardDown: jack.
	game moveBoxTowardDown: box1.
	self assert: jack position equals: 2@3.
	self assert: (game tileAtX: 2 atY: 2 ) players isEmpty .
	self assert: ((game tileAtX: 2 atY: 3 ) players includes: jack) .
	self assert: box1 position equals: 3@3.
	self assert: (game tileAtX: 3 atY: 2 ) boxes isEmpty .
	self assert: ((game tileAtX: 3 atY: 3 ) boxes includes: box1) .
	self assert: game printString equals: 
'WWWWWW
WWWWWW
WPOWWW
WWWWWW
'
	
]

{ #category : #tests }
GameTest >> testMovePlayerAndBoxADirectionRight [

	| game jack box1 |
	game := Game new sizeX: 6 sizeY: 4.
	jack := Player new name: 'Jack'.
	box1 := Box new name: 'Box1'.
	game addPlayer: jack.
	game addBox: box1.
	game movePlayerTowardRight: jack.
	game moveBoxTowardRight: box1.
	self assert: jack position equals: 3@2.
	self assert: (game tileAtX: 2 atY: 2 ) players isEmpty .
	self assert: ((game tileAtX: 3 atY: 2 ) players includes: jack) .
	self assert: box1 position equals: 4@2.
	self assert: (game tileAtX: 3 atY: 2 ) boxes isEmpty .
	self assert: ((game tileAtX: 4 atY: 2 ) boxes includes: box1) .
	
]

{ #category : #tests }
GameTest >> testMovePlayerAndBoxADirectionRightAndPrinting [

	| game jack box1 |
	game := Game new sizeX: 6 sizeY: 4.
	jack := Player new name: 'Jack'.
	box1 := Box new name: 'Box1'.
	game addPlayer: jack.
	game addBox: box1.
	game movePlayerTowardRight: jack.
	game moveBoxTowardRight: box1.
	self assert: jack position equals: 3@2.
	self assert: (game tileAtX: 2 atY: 2 ) players isEmpty .
	self assert: ((game tileAtX: 3 atY: 2 ) players includes: jack) .
	self assert: box1 position equals: 4@2.
	self assert: (game tileAtX: 3 atY: 2 ) boxes isEmpty .
	self assert: ((game tileAtX: 4 atY: 2 ) boxes includes: box1) .
	self assert: game printString equals: 
'WWWWWW
WWPOWW
WWWWWW
WWWWWW
'
	
]

{ #category : #tests }
GameTest >> testMovePlayerAndBoxADirectionRightAndPrintingAndMovementsCount [

	| game jack box1 |
	game := Game new sizeX: 6 sizeY: 4.
	jack := Player new name: 'Jack'.
	box1 := Box new name: 'Box1'.
	game addPlayer: jack.
	game addBox: box1.
	self assert: game movements equals: 0 .
	game movePlayerTowardRight: jack.
	game moveBoxTowardRight: box1.
	self assert: game movements equals: 1 .
	self assert: jack position equals: 3@2.
	self assert: (game tileAtX: 2 atY: 2 ) players isEmpty .
	self assert: ((game tileAtX: 3 atY: 2 ) players includes: jack) .
	self assert: box1 position equals: 4@2.
	self assert: (game tileAtX: 3 atY: 2 ) boxes isEmpty .
	self assert: ((game tileAtX: 4 atY: 2 ) boxes includes: box1) .
	self assert: game printString equals: 
'WWWWWW
WWPOWW
WWWWWW
WWWWWW
'
	
]

{ #category : #tests }
GameTest >> testPlayerAndBoxAtStart [

	| game jack box1 |
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
GameTest >> testPlayerAtStartIsAtPosition1at1 [

	| game jack |
	game := Game new sizeX: 5 sizeY: 3.
	jack := Player new name: 'Jack'.
	game addPlayer: jack.
	self assert: jack position equals: 2@2 .
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
GameTest >> testPrintingSimpleGameWithBoxAndGoalAtSamePosition [
"les deux symboles sur la même case créent un décalage, il faudrait trouver une solution pour y remédier"
	| game jack box1 goal1 |
	game := Game new sizeX: 6 sizeY: 4.
	jack := Player new name: 'Jack'.
	box1 := Box new name: 'Box1'.
	goal1 := Goal new name: 'Goal1'.
	game addPlayer: jack atPoint: 3@2 .
	game addBox: box1 atPoint: 4@2 .
	game addGoal: goal1 atPoint: 5@2 .
	game movePlayerTowardRight: jack.
	game moveBoxTowardRight: box1.
	self assert: game printString equals: 
'WWWWWW
WWWPOXW
WWWWWW
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
GameTest >> testPrintingSimpleGameWithPlayerAndBoxAndGoalAtGivenPosition [

	| game jack box1 goal1 |
	game := Game new sizeX: 6 sizeY: 4.
	jack := Player new name: 'Jack'.
	box1 := Box new name: 'Box1'.
	goal1 := Goal new name: 'Goal1'.
	game addPlayer: jack atPoint: 3@2 .
	game addBox: box1 atPoint: 4@2 .
	game addGoal: goal1 atPoint: 5@2 .
	self assert: game printString equals: 
'WWWWWW
WWPOXW
WWWWWW
WWWWWW
' "on initialise avec uniquement des murs" "mettre un espace au début de chaque ligne pour aligner"
]

{ #category : #tests }
GameTest >> testPrintingSimpleGameWithPlayerAndBoxAtGivenPosition [

	| game jack box1 |
	game := Game new sizeX: 6 sizeY: 4.
	jack := Player new name: 'Jack'.
	box1 := Box new name: 'Box1'.
	game addPlayer: jack atPoint: 3@2 .
	game addBox: box1 atPoint: 4@2 .
	self assert: game printString equals: 
'WWWWWW
WWPOWW
WWWWWW
WWWWWW
' "on initialise avec uniquement des murs" "mettre un espace au début de chaque ligne pour aligner"
]

{ #category : #tests }
GameTest >> testTileAt [

	| game |
	game := Game new sizeX: 5 sizeY: 3.
	self assert: (game tileAtX: 3 atY: 1) printString equals: 'W'
]

{ #category : #tests }
GameTest >> testTileForPlayerOrBoxTowardDown [

	| game jack |
	game := Game new sizeX: 5 sizeY: 3.
	jack := Player new name: 'Jack'.
	game addPlayer: jack.
	self assert: (game tileForPlayerOrBoxTowardDown: jack) position equals: 2@3.
]

{ #category : #tests }
GameTest >> testTileForPlayerOrBoxTowardLeft [

	| game jack |
	game := Game new sizeX: 5 sizeY: 3.
	jack := Player new name: 'Jack'.
	game addPlayer: jack.
	self assert: (game tileForPlayerOrBoxTowardLeft: jack) position equals: 1@2.
]

{ #category : #tests }
GameTest >> testTileForPlayerOrBoxTowardRight [

	| game jack |
	game := Game new sizeX: 5 sizeY: 3.
	jack := Player new name: 'Jack'.
	game addPlayer: jack.
	self assert: (game tileForPlayerOrBoxTowardRight: jack) position equals: 3@2.
]

{ #category : #tests }
GameTest >> testTileForPlayerOrBoxTowardUp [

	| game jack |
	game := Game new sizeX: 5 sizeY: 3.
	jack := Player new name: 'Jack'.
	game addPlayer: jack.
	self assert: (game tileForPlayerOrBoxTowardUp: jack) position equals: 2@1.
]

{ #category : #tests }
GameTest >> testTileOfPlayerOrBox [

	| game jack box1 |
	game := Game new sizeX: 5 sizeY: 3.
	jack := Player new name: 'Jack'.
	box1 := Box new name: 'Box1'.
	game addPlayer: jack.
	game addBox: box1.
	self assert: (game tileOfPlayerOrBox: jack) position equals: 2@2.
	self assert: (game tileOfPlayerOrBox: box1) position equals: 3@2.
]

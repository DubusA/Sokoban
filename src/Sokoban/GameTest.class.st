Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'Sokoban-Tests'
}

{ #category : #tests }
GameTest >> testCanMoveTowardRight [

	| game jack box1 goal1 |
	game := Game new sizeX: 6 sizeY: 4.
	jack := Player new name: 'Jack'.
	box1 := Box new name: 'Box1'.
	goal1 := Goal new name: 'Goal1'.
	game addPlayer: jack atPoint: 3@2 .
	game addBox: box1 atPoint: 4@2 .
	game addGoal: goal1 atPoint: 5@2 .
	game addWall: Wall new atPoint: 6@2 .
	self assert: game printString equals: 
'______
__POXW
______
______
' .
	self assert: (game playerOrBoxCanMoveTowardRight: jack).
	game movePlayerTowardRight: jack .
	self assert: game printString equals: 
'______
___POW
______
______
' .
	self deny: (game playerOrBoxCanMoveTowardRight: jack).
]

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
	self assert: game printString equals: 
'______
__POX_
______
______
' .
	game movePlayerTowardRight: jack .
	"game moveBoxTowardRight: box1 ." "plus besoin de déplacer les boites, c'est le joueur qui les pousse en se déplacant"
	self assert: jack position equals: 4@2 .
	self assert: box1 position equals: 5@2 .
	self assert: goal1 position equals: 5@2 .
	self assert: box1 position equals: goal1 position .
	self assert: game isOver .
	self assert: game printString equals: 
'______
___PO_
______
______
'
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
	self assert: box1 position equals: 5@3.
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
'______
______
_PO___
______
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
	"game moveBoxTowardRight: box1." "plus besoin de déplacer les boites, c'est le joueur qui les pousse en se déplacant"
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
	"game moveBoxTowardRight: box1." "plus besoin de déplacer les boites, c'est le joueur qui les pousse en se déplacant"
	self assert: jack position equals: 3@2.
	self assert: (game tileAtX: 2 atY: 2 ) players isEmpty .
	self assert: ((game tileAtX: 3 atY: 2 ) players includes: jack) .
	self assert: box1 position equals: 4@2.
	self assert: (game tileAtX: 3 atY: 2 ) boxes isEmpty .
	self assert: ((game tileAtX: 4 atY: 2 ) boxes includes: box1) .
	self assert: game printString equals: 
'______
__PO__
______
______
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
	"game moveBoxTowardRight: box1." "plus besoin de déplacer les boites, c'est le joueur qui les pousse en se déplacant"
	self assert: game movements equals: 1 .
	self assert: jack position equals: 3@2.
	self assert: (game tileAtX: 2 atY: 2 ) players isEmpty .
	self assert: ((game tileAtX: 3 atY: 2 ) players includes: jack) .
	self assert: box1 position equals: 4@2.
	self assert: (game tileAtX: 3 atY: 2 ) boxes isEmpty .
	self assert: ((game tileAtX: 4 atY: 2 ) boxes includes: box1) .
	self assert: game printString equals: 
'______
__PO__
______
______
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
GameTest >> testPlayerDontMoveInAWall [

	| game jack box1 goal1 |
	game := Game new sizeX: 6 sizeY: 4.
	jack := Player new name: 'Jack'.
	box1 := Box new name: 'Box1'.
	goal1 := Goal new name: 'Goal1'.
	game addPlayer: jack atPoint: 3@2 .
	game addBox: box1 atPoint: 4@2 .
	game addGoal: goal1 atPoint: 5@2 .
	game addWall: Wall new atPoint: 6@2 .
	self assert: game printString equals: 
'______
__POXW
______
______
' .
	self assert: (game playerOrBoxCanMoveTowardRight: jack).
	game movePlayerTowardRight: jack .
	self assert: game printString equals: 
'______
___POW
______
______
' .
	self deny: (game playerOrBoxCanMoveTowardRight: jack).
	game movePlayerTowardRight: jack.
	self assert: game printString equals: 
'______
___POW
______
______
' .
	game movePlayerTowardRight: jack. "on peut essayer de bouger autant de fois que l'on veut le joueur, il ne bougera pas s'il y a un mur"
	game movePlayerTowardRight: jack.
	game movePlayerTowardRight: jack.
	self assert: game printString equals: 
'______
___POW
______
______
' .
]

{ #category : #tests }
GameTest >> testPrintingSimpleGame [

	| game |
	game := Game new sizeX: 5 sizeY: 3.
	self 
		assert: game printString 
		equals: 
'_____
_____
_____
' "on initialise avec uniquement des murs" "mettre un espace au début de chaque ligne pour aligner"
]

{ #category : #tests }
GameTest >> testPrintingSimpleGameV2 [
	| game |
	game := Game new sizeX: 6 sizeY: 4.
	(game tiles at: 2) at: 2 put: (PlayerTile new position: 2@2).
	(game tiles at: 2) at: 3 put: (BoxTile new position: 2@3).
	(game tiles at: 2) at: 4 put: (Tile new position: 2@4)."Tile et EmptyTile revient au même"
	(game tiles at: 2) at: 5 put: (GoalTile new position: 2@5).
	2 to: 5 do: [ :i | (game tiles at: 3) at: i put: (Tile new position: 3@i) ].
	self assert: game printString equals: 
'______
_PO_X_
______
______
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
	self assert: game printString equals: 
'______
__POX_
______
______
' .
	game movePlayerTowardRight: jack.
	"game moveBoxTowardRight: box1." "plus besoin de déplacer les boites, c'est le joueur qui les pousse en se déplacant"
	self assert: game printString equals: 
'______
___PO_
______
______
' "on initialise avec uniquement des murs" "mettre un espace au début de chaque ligne pour aligner"
]

{ #category : #tests }
GameTest >> testPrintingSimpleGameWithPlayer [

	| game jack |
	game := Game new sizeX: 5 sizeY: 3.
	jack := Player new name: 'Jack'.
	game addPlayer: jack.
	self assert: game printString equals: 
'_____
_P___
_____
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
'_____
_PO__
_____
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
'______
__POX_
______
______
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
'______
__PO__
______
______
' "on initialise avec uniquement des cases vides" "mettre un espace au début de chaque ligne pour aligner"
]

{ #category : #tests }
GameTest >> testSokobanLevel1IsOver [

	| game jack box1 box2 box3 box4 box5 box6 box7 goal1 goal2 goal3 goal4 goal5 goal6 goal7 |
	game := Game new sizeX: 8 sizeY: 9.
	jack := Player new name: 'Jack'.
	box1 := Box new name: 'Box1'.
	box2 := Box new name: 'Box2'.
	box3 := Box new name: 'Box3'.
	box4 := Box new name: 'Box4'.
	box5 := Box new name: 'Box5'.
	box6 := Box new name: 'Box6'.
	box7 := Box new name: 'Box7'.
	goal1 := Goal new name: 'Goal1'.
	goal2 := Goal new name: 'Goal2'.
	goal3 := Goal new name: 'Goal3'.
	goal4 := Goal new name: 'Goal4'.
	goal5 := Goal new name: 'Goal5'.
	goal6 := Goal new name: 'Goal6'.
	goal7 := Goal new name: 'Goal7'.
	game addPlayer: jack atPoint: 3@3 .
	game addBox: box1 atPoint: 4@3 .
	game addBox: box2 atPoint: 5@4 .
	game addBox: box3 atPoint: 5@5 .
	game addBox: box4 atPoint: 2@7 .
	game addBox: box5 atPoint: 4@7 .
	game addBox: box6 atPoint: 5@7 .
	game addBox: box7 atPoint: 6@7 .
	game addGoal: goal1 atPoint: 2@3 .
	game addGoal: goal2 atPoint: 6@4 .
	game addGoal: goal3 atPoint: 2@5 .
	game addGoal: goal4 atPoint: 5@6 .
	game addGoal: goal5 atPoint: 4@7 .
	game addGoal: goal6 atPoint: 7@7 .
	game addGoal: goal7 atPoint: 5@8 .
	1 to: 8 do: [ :i | game addWall: Wall new atPoint: i@1 .
							game addWall: Wall new atPoint: i@9 ] .
	2 to: 8 do: [ :i | game addWall: Wall new atPoint: 1@i .
							game addWall: Wall new atPoint: 8@i ] .
	2 to: 6 do: [ :i | game addWall: Wall new atPoint: 7@i ] .
	4 to: 6 do: [ :i | game addWall: Wall new atPoint: 3@i ] .
	2 to: 3 do: [ :i | game addWall: Wall new atPoint: i@2 ] .
	game addWall: Wall new atPoint: 2@4 .
	game addWall: Wall new atPoint: 4@5 .
	self assert: game printString equals: 
'WWWWWWWW
WWW___WW
WXPO__WW
WWW_OXWW
WXWWO_WW
W_W_X_WW
WO_OOOXW
W___X__W
WWWWWWWW
' .
	game movePlayerTowardRight: jack .
	game movePlayerTowardUp: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardUp: jack .
	game movePlayerTowardUp: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardUp: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardUp: jack .
	game movePlayerTowardUp: jack .
	game movePlayerTowardUp: jack .
	game movePlayerTowardUp: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardUp: jack .
	game movePlayerTowardRight: jack . 
	self assert: game isOver .
	self assert: game movements equals: 48 .
	self assert: game printString equals: 
'WWWWWWWW
WWW___WW
WO____WW
WWW__OWW
WOWW__WW
W_W_O_WW
W_PO__OW
W___O__W
WWWWWWWW
' . 
]

{ #category : #tests }
GameTest >> testSokobanLevel1IsOverWithoutNameDeclaration [

	| game jack |
	game := Game new sizeX: 8 sizeY: 9.
	jack := Player new name: 'Jack'.
	game addPlayer: jack atPoint: 3@3 .
	game addBox: Box new atPoint: 4@3 .
	game addBox: Box new atPoint: 5@4 .
	game addBox: Box new atPoint: 5@5 .
	game addBox: Box new atPoint: 2@7 .
	game addBox: Box new atPoint: 4@7 .
	game addBox: Box new atPoint: 5@7 .
	game addBox: Box new atPoint: 6@7 .
	game addGoal: Goal new atPoint: 2@3 .
	game addGoal: Goal new atPoint: 6@4 .
	game addGoal: Goal new atPoint: 2@5 .
	game addGoal: Goal new atPoint: 5@6 .
	game addGoal: Goal new atPoint: 4@7 .
	game addGoal: Goal new atPoint: 7@7 .
	game addGoal: Goal new atPoint: 5@8 .
	1 to: 8 do: [ :i | game addWall: Wall new atPoint: i@1 .
							game addWall: Wall new atPoint: i@9 ] .
	2 to: 8 do: [ :i | game addWall: Wall new atPoint: 1@i .
							game addWall: Wall new atPoint: 8@i ] .
	2 to: 6 do: [ :i | game addWall: Wall new atPoint: 7@i ] .
	4 to: 6 do: [ :i | game addWall: Wall new atPoint: 3@i ] .
	2 to: 3 do: [ :i | game addWall: Wall new atPoint: i@2 ] .
	game addWall: Wall new atPoint: 2@4 .
	game addWall: Wall new atPoint: 4@5 .
	self assert: game printString equals: 
'WWWWWWWW
WWW___WW
WXPO__WW
WWW_OXWW
WXWWO_WW
W_W_X_WW
WO_OOOXW
W___X__W
WWWWWWWW
' .
	game movePlayerTowardRight: jack .
	game movePlayerTowardUp: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardUp: jack .
	game movePlayerTowardUp: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardUp: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardUp: jack .
	game movePlayerTowardUp: jack .
	game movePlayerTowardUp: jack .
	game movePlayerTowardUp: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardRight: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardDown: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardLeft: jack .
	game movePlayerTowardUp: jack .
	game movePlayerTowardRight: jack . 
	self assert: game isOver .
	self assert: game movements equals: 48 .
	self assert: game printString equals: 
'WWWWWWWW
WWW___WW
WO____WW
WWW__OWW
WOWW__WW
W_W_O_WW
W_PO__OW
W___O__W
WWWWWWWW
' . 
]

{ #category : #tests }
GameTest >> testSokobanLevel1Printing [

	| game jack box1 box2 box3 box4 box5 box6 box7 goal1 goal2 goal3 goal4 goal5 goal6 goal7 |
	game := Game new sizeX: 8 sizeY: 9.
	jack := Player new name: 'Jack'.
	box1 := Box new name: 'Box1'.
	box2 := Box new name: 'Box2'.
	box3 := Box new name: 'Box3'.
	box4 := Box new name: 'Box4'.
	box5 := Box new name: 'Box5'.
	box6 := Box new name: 'Box6'.
	box7 := Box new name: 'Box7'.
	goal1 := Goal new name: 'Goal1'.
	goal2 := Goal new name: 'Goal2'.
	goal3 := Goal new name: 'Goal3'.
	goal4 := Goal new name: 'Goal4'.
	goal5 := Goal new name: 'Goal5'.
	goal6 := Goal new name: 'Goal6'.
	goal7 := Goal new name: 'Goal7'.
	game addPlayer: jack atPoint: 3@3 .
	game addBox: box1 atPoint: 4@3 .
	game addBox: box2 atPoint: 5@4 .
	game addBox: box3 atPoint: 5@5 .
	game addBox: box4 atPoint: 2@7 .
	game addBox: box5 atPoint: 4@7 .
	game addBox: box6 atPoint: 5@7 .
	game addBox: box7 atPoint: 6@7 .
	game addGoal: goal1 atPoint: 2@3 .
	game addGoal: goal2 atPoint: 6@4 .
	game addGoal: goal3 atPoint: 2@5 .
	game addGoal: goal4 atPoint: 5@6 .
	game addGoal: goal5 atPoint: 4@7 .
	game addGoal: goal6 atPoint: 7@7 .
	game addGoal: goal7 atPoint: 5@8 .
	1 to: 8 do: [ :i | game addWall: Wall new atPoint: i@1 .
							game addWall: Wall new atPoint: i@9 ] .
	2 to: 8 do: [ :i | game addWall: Wall new atPoint: 1@i .
							game addWall: Wall new atPoint: 8@i ] .
	2 to: 6 do: [ :i | game addWall: Wall new atPoint: 7@i ] .
	4 to: 6 do: [ :i | game addWall: Wall new atPoint: 3@i ] .
	2 to: 3 do: [ :i | game addWall: Wall new atPoint: i@2 ] .
	game addWall: Wall new atPoint: 2@4 .
	game addWall: Wall new atPoint: 4@5 .
	self assert: game printString equals: 
'WWWWWWWW
WWW___WW
WXPO__WW
WWW_OXWW
WXWWO_WW
W_W_X_WW
WO_OOOXW
W___X__W
WWWWWWWW
' .
]

{ #category : #tests }
GameTest >> testTileAt [

	| game |
	game := Game new sizeX: 5 sizeY: 3.
	self assert: (game tileAtX: 3 atY: 1) printString equals: '_'
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

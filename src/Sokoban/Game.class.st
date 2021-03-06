Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'tiles',
		'player',
		'boxes',
		'goals',
		'walls',
		'movements'
	],
	#category : #Sokoban
}

{ #category : #adding }
Game >> addBox: aBox [
	((tiles at: 2) at: 3) addBox: aBox .
	"il y a des murs autour du plateau de jeu donc on ne met rien en 1@1"	
	aBox position: 3@2 . "pour pouvoir avoir la position de la boite (pour ensuite pouvoir la déplacer)"
	boxes add: aBox "ajout à la liste des boites (servira uniquement à la fin pour comparer les positions des boites aux positions des buts pour savoir si le jeu est fini"
]

{ #category : #adding }
Game >> addBox: aBox atPoint: aPoint [
	((tiles at: aPoint y) at: aPoint x) addBox: aBox .
	aBox position: (aPoint x)@(aPoint y). "pour pouvoir avoir la position de la boite (pour ensuite pouvoir la déplacer)"
	boxes add: aBox "ajout à la liste des boites (servira uniquement à la fin pour comparer les positions des boites aux positions des buts pour savoir si le jeu est fini"
]

{ #category : #adding }
Game >> addGoal: aGoal atPoint: aPoint [
	((tiles at: aPoint y) at: aPoint x) addGoal: aGoal .
	aGoal position: (aPoint x)@(aPoint y). "pour pouvoir avoir la position du but"
	goals add: aGoal "ajout à la liste des buts (servira uniquement à la fin pour comparer les positions des boites aux positions des buts pour savoir si le jeu est fini"
]

{ #category : #adding }
Game >> addPlayer: aPlayer [
	((tiles at: 2) at: 2) addPlayer: aPlayer .
	"il y a des murs autour du plateau de jeu donc on ne met rien en 1@1"
	aPlayer position: 2@2. "pour pouvoir avoir la position du joueur (pour ensuite pouvoir le déplacer)"
]

{ #category : #adding }
Game >> addPlayer: aPlayer atPoint: aPoint [
	((tiles at: aPoint y) at: aPoint x) addPlayer: aPlayer .
	aPlayer position: (aPoint x)@(aPoint y). "pour pouvoir avoir la position du joueur (pour ensuite pouvoir le déplacer)"
]

{ #category : #adding }
Game >> addWall: aWall atPoint: aPoint [
	((tiles at: aPoint y) at: aPoint x) addWall: aWall .
	aWall position: (aPoint x)@(aPoint y). "pour pouvoir avoir la position du mur"
	walls add: aWall "ajout à la liste des murs"
]

{ #category : #initialization }
Game >> initialize [ 
	player := Point new. "position x et y du joueur"
	boxes := OrderedCollection new. "collection de boites qui contiendra des points (position x et y)"
	goals := OrderedCollection new. "collection de buts qui contiendra des points (position x et y)"
	walls := OrderedCollection new. "collection de murs qui contiendra des points (position x et y)"
	movements := 0.
]

{ #category : #testing }
Game >> isOver [ 
"il faut regarder si les positions des boites sont les mêmes que les positions des buts"
"on utilise les variables d'instance boxes (OrderedCollection) et goals (OrderedCollection) de la classe Game qui contiennent les listes de boites et de buts qui eux-mêmes ont une position"
	^ (boxes collect: [ :eachBox | eachBox position ]) asSet = (goals collect: [ :eachGoal | eachGoal position ]) asSet
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

{ #category : #accessing }
Game >> movePlayerTowardDown: aPlayer [

	| targetTile |
	(self playerOrBoxCanMoveTowardDown: aPlayer) ifFalse: [ ^ self ]. "ne fait rien si le joueur ne peut pas bouger"
	movements := movements + 1.
	targetTile := self tileForPlayerOrBoxTowardDown: aPlayer.
	targetTile boxes isNotEmpty ifTrue: [ 
		targetTile boxes do: [ :eachBox | self moveBoxTowardDown: eachBox ] ]. "pour déplacer la boite si le joueur la pousse"
	(self tileOfPlayerOrBox: aPlayer) removePlayer: aPlayer.
	targetTile addPlayer: aPlayer.
	aPlayer position: targetTile position
]

{ #category : #accessing }
Game >> movePlayerTowardLeft: aPlayer [

	| targetTile |
	(self playerOrBoxCanMoveTowardLeft: aPlayer) ifFalse: [ ^ self ]. "ne fait rien si le joueur ne peut pas bouger"
	movements := movements + 1.
	targetTile := self tileForPlayerOrBoxTowardLeft: aPlayer.
	targetTile boxes isNotEmpty ifTrue: [ 
		targetTile boxes do: [ :eachBox | self moveBoxTowardLeft: eachBox ] ]. "pour déplacer la boite si le joueur la pousse"
	(self tileOfPlayerOrBox: aPlayer) removePlayer: aPlayer.
	targetTile addPlayer: aPlayer.
	aPlayer position: targetTile position
]

{ #category : #accessing }
Game >> movePlayerTowardRight: aPlayer [

	| targetTile |
	(self playerOrBoxCanMoveTowardRight: aPlayer) ifFalse: [ ^ self ]. "ne fait rien si le joueur ne peut pas bouger"
	movements := movements + 1.
	targetTile := self tileForPlayerOrBoxTowardRight: aPlayer.
	targetTile boxes isNotEmpty ifTrue: [ 
		targetTile boxes do: [ :eachBox | self moveBoxTowardRight: eachBox ] ]. "pour déplacer la boite si le joueur la pousse"
	(self tileOfPlayerOrBox: aPlayer) removePlayer: aPlayer.
	targetTile addPlayer: aPlayer.
	aPlayer position: targetTile position
]

{ #category : #accessing }
Game >> movePlayerTowardUp: aPlayer [

	| targetTile |
	(self playerOrBoxCanMoveTowardUp: aPlayer) ifFalse: [ ^ self ]. "ne fait rien si le joueur ne peut pas bouger"
	movements := movements + 1.
	targetTile := self tileForPlayerOrBoxTowardUp: aPlayer.
	targetTile boxes isNotEmpty ifTrue: [ 
		targetTile boxes do: [ :eachBox | self moveBoxTowardUp: eachBox ] ]. "pour déplacer la boite si le joueur la pousse"
	(self tileOfPlayerOrBox: aPlayer) removePlayer: aPlayer.
	targetTile addPlayer: aPlayer.
	aPlayer position: targetTile position
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

{ #category : #'as yet unclassified' }
Game >> playerOrBoxCanMoveTowardDown: aPlayerOrBox [
"on vérifie qu'il n'y a pas de mur sur la case visée et que s'il y a une boite elle peut aussi bouger dans la direction donnée"
	| targetTile result |
	targetTile := self tileForPlayerOrBoxTowardDown: aPlayerOrBox.
	result := true .
	targetTile boxes isNotEmpty ifTrue: [ targetTile boxes do: [ :eachBox | result := result & (self playerOrBoxCanMoveTowardDown: eachBox) ] ] ."on vérifie que les boites peuvent bouger"
	^ targetTile walls isEmpty & result. "et qu'il n'y a pas de mur"
]

{ #category : #'as yet unclassified' }
Game >> playerOrBoxCanMoveTowardLeft: aPlayerOrBox [
"on vérifie qu'il n'y a pas de mur sur la case visée et que s'il y a une boite elle peut aussi bouger dans la direction donnée"
	| targetTile result |
	targetTile := self tileForPlayerOrBoxTowardLeft: aPlayerOrBox.
	result := true .
	targetTile boxes isNotEmpty ifTrue: [ targetTile boxes do: [ :eachBox | result := result & (self playerOrBoxCanMoveTowardLeft: eachBox) ] ] ."on vérifie que les boites peuvent bouger"
	^ targetTile walls isEmpty & result. "et qu'il n'y a pas de mur"
]

{ #category : #'as yet unclassified' }
Game >> playerOrBoxCanMoveTowardRight: aPlayerOrBox [
"on vérifie qu'il n'y a pas de mur sur la case visée et que s'il y a une boite elle peut aussi bouger dans la direction donnée"
	| targetTile result |
	targetTile := self tileForPlayerOrBoxTowardRight: aPlayerOrBox.
	result := true .
	targetTile boxes isNotEmpty ifTrue: [ targetTile boxes do: [ :eachBox | result := result & (self playerOrBoxCanMoveTowardRight: eachBox) ] ] ."on vérifie que les boites peuvent bouger"
	^ targetTile walls isEmpty & result. "et qu'il n'y a pas de mur"
]

{ #category : #'as yet unclassified' }
Game >> playerOrBoxCanMoveTowardUp: aPlayerOrBox [
"on vérifie qu'il n'y a pas de mur sur la case visée et que s'il y a une boite elle peut aussi bouger dans la direction donnée"
	| targetTile result |
	targetTile := self tileForPlayerOrBoxTowardUp: aPlayerOrBox.
	result := true .
	targetTile boxes isNotEmpty ifTrue: [ targetTile boxes do: [ :eachBox | result := result & (self playerOrBoxCanMoveTowardUp: eachBox) ] ] ."on vérifie que les boites peuvent bouger"
	^ targetTile walls isEmpty & result. "et qu'il n'y a pas de mur"
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
	1 to: aNumberY do: [ :i | 1 to: aNumberX do: [ :j | (tiles at: i) at: j put: (EmptyTile new position: j@i ) ] ] .
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

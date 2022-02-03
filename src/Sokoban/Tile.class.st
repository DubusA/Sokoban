Class {
	#name : #Tile,
	#superclass : #Object,
	#instVars : [
		'players',
		'boxes',
		'goals',
		'walls',
		'position'
	],
	#category : #Sokoban
}

{ #category : #adding }
Tile >> addBox: aBox [
	"il faut ajouter la boite à la liste de boites boxes qu'on a initialisée"
	boxes add: aBox
]

{ #category : #adding }
Tile >> addGoal: aGoal [
	"il faut ajouter le but à la liste de buts goals qu'on a initialisée"
	goals add: aGoal
]

{ #category : #adding }
Tile >> addPlayer: aPlayer [
	"il faut ajouter le joueur à la liste de joueurs players qu'on a initialisé"
	players add: aPlayer
]

{ #category : #adding }
Tile >> addWall: aWall [
	"il faut ajouter le mur à la liste des murs walls qu'on a initialisée"
	walls add: aWall 
]

{ #category : #accessing }
Tile >> boxes [ 
	^ boxes
]

{ #category : #accessing }
Tile >> goals [ 
	^ goals
]

{ #category : #initialization }
Tile >> initialize [ 
	players := OrderedCollection new. "liste des joueurs (point) présent sur la case (0 ou 1 joueur)"
	boxes := OrderedCollection new. "liste des boites (point) présentes sur la case (0 ou 1 boite)"
	goals := OrderedCollection new. "liste des buts (point) présents sur la case (0 ou 1 but qui ne bouge pas)"
	walls := OrderedCollection new. "liste des murs (point) présents sur la case (0 ou 1 mur qui ne bouge pas)"
]

{ #category : #accessing }
Tile >> players [ 
	^ players
]

{ #category : #'as yet unclassified' }
Tile >> position [
	^ position
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

{ #category : #printing }
Tile >> printOn: aStream [
	"position printOn: aStream." "si on veut afficher les coordonées du point"
	aStream << '_' .
	players do: [ :aPlayer | aPlayer printOn: aStream ].
]

{ #category : #removing }
Tile >> removeBox: aBox [
	"il faut retirer la boite de la liste de boites boxes qu'on a initialisée"
	"on avait utilisé  add:  pour ajouter une boite, la méthode  remove:  existe aussi"
	boxes remove: aBox
]

{ #category : #removing }
Tile >> removePlayer: aPlayer [
	"il faut retirer le joueur de la liste de joueurs players qu'on a initialisée"
	"on avait utilisé  add:  pour ajouter un joueur, la méthode  remove:  existe aussi"
	players remove: aPlayer
]

{ #category : #accessing }
Tile >> walls [ 
	^ walls
]

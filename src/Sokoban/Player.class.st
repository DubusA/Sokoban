Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'position'
	],
	#category : #Sokoban
}

{ #category : #accessing }
Player >> name [  
	^ name
]

{ #category : #accessing }
Player >> name: aName [ 
	name := aName 
]

{ #category : #accessing }
Player >> position [ 
	^ position
]

{ #category : #accessing }
Player >> position: aPoint [ 
	position := aPoint 
]

Class {
	#name : #Goal,
	#superclass : #Object,
	#instVars : [
		'name',
		'position'
	],
	#category : #Sokoban
}

{ #category : #accessing }
Goal >> name [  
	^ name
]

{ #category : #accessing }
Goal >> name: aName [ 
	name := aName 
]

{ #category : #accessing }
Goal >> position [ 
	^ position
]

{ #category : #accessing }
Goal >> position: aPoint [ 
	position := aPoint 
]

{ #category : #printing }
Goal >> printOn: aStream [
	
	aStream << 'X'
]

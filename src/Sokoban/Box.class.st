Class {
	#name : #Box,
	#superclass : #Object,
	#instVars : [
		'name',
		'position'
	],
	#category : #Sokoban
}

{ #category : #accessing }
Box >> name [  
	^ name
]

{ #category : #accessing }
Box >> name: aName [ 
	name := aName 
]

{ #category : #accessing }
Box >> position [ 
	^ position
]

{ #category : #accessing }
Box >> position: aPoint [ 
	position := aPoint 
]

{ #category : #printing }
Box >> printOn: aStream [
	
	aStream << 'O'
]

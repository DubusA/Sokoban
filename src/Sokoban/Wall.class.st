Class {
	#name : #Wall,
	#superclass : #Object,
	#instVars : [
		'name',
		'position'
	],
	#category : #Sokoban
}

{ #category : #accessing }
Wall >> name [  
	^ name
]

{ #category : #accessing }
Wall >> name: aName [ 
	name := aName 
]

{ #category : #accessing }
Wall >> position [ 
	^ position
]

{ #category : #accessing }
Wall >> position: aPoint [ 
	position := aPoint 
]

{ #category : #accessing }
Wall >> printOn: aStream [
	
	aStream << 'W'
]

Class {
	#name : #ERLoginController,
	#superclass : #ERController,
	#category : #'ESUGApp-Controller'
}

{ #category : #accessing }
ERLoginController class >> user: anUser [
	| controller |
	controller := self new.
	controller user: anUser .
	^ controller
]

{ #category : #rendering }
ERLoginController >> validateLoginFor: aString1 password: aString2 [
	^  conference users 
			detect: [:each | each email = aString1 and: [each password = aString2]] 
			ifNone: nil
	
]

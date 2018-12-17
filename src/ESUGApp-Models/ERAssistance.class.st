"
User is a class for represent a DAYSASSIT table of Database model.

It offers a way to create the object through of a result of database
"
Class {
	#name : #ERAssistance,
	#superclass : #SDActiveRecord,
	#instVars : [
		'daysToAssist'
	],
	#category : #'ESUGApp-Models'
}

{ #category : #accessing }
ERAssistance class >> availableDays [
	^ #(#monday #tuesday #wednesday #thursday #friday).
]

{ #category : #registration }
ERAssistance >> attent: aStringDay [
	daysToAssist at: aStringDay.
]

{ #category : #registration }
ERAssistance >> day: aStringDay attent: aBoolean [ 
	daysToAssist at: aStringDay put: aBoolean.
]

{ #category : #initialize }
ERAssistance >> initialize [
	super initialize.
	daysToAssist := Dictionary new.
]

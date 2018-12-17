Class {
	#name : #ERUserAccount,
	#superclass : #SDActiveRecord,
	#instVars : [
		'firstName',
		'lastName',
		'email',
		'password',
		'role'
	],
	#category : #'ESUGApp-Models'
}

{ #category : #accessing }
ERUserAccount class >> admin [
	| instance |
	instance := self new.
	instance role: 'admin'.
	^ instance
]

{ #category : #actions }
ERUserAccount class >> findUserByEmail: aString [ 
	|anAttendee|
 	anAttendee := (ERAttendee find: [ :each | each userAccount email = aString]).
	anAttendee ifNotNil: [ ^ anAttendee userAccount ].
	^ nil
]

{ #category : #accessing }
ERUserAccount class >> groupManager [
	| instance |
	instance := self new.
	instance role: 'groupManager'.
	^ instance
]

{ #category : #'as yet unclassified' }
ERUserAccount class >> hashPassword: aString [

 ^ aString 
  ifEmpty: [0 asString] 
  ifNotEmpty: [(GRPlatform current secureHashFor: aString) asString].

]

{ #category : #accessing }
ERUserAccount >> email [
	^ email
]

{ #category : #accessing }
ERUserAccount >> email: anObject [
	email := anObject
]

{ #category : #accessing }
ERUserAccount >> firstName [
	^ firstName
]

{ #category : #accessing }
ERUserAccount >> firstName: anObject [
	firstName := anObject
]

{ #category : #initialization }
ERUserAccount >> initialize [
	super initialize.
	role := 'attendee'
	
]

{ #category : #testing }
ERUserAccount >> isAdmin [
	^ self role = 'admin'
]

{ #category : #testing }
ERUserAccount >> isAttendee [
	^ self role = 'attendee'
]

{ #category : #testing }
ERUserAccount >> isGroupManager [
	^ self role = 'groupManager'
]

{ #category : #testing }
ERUserAccount >> isStudent [
	^ self role = 'student'
]

{ #category : #accessing }
ERUserAccount >> lastName [
	^ lastName
]

{ #category : #accessing }
ERUserAccount >> lastName: anObject [
	lastName := anObject
]

{ #category : #accessing }
ERUserAccount >> password [
	^ password
]

{ #category : #accessing }
ERUserAccount >> password: anObject [
	password := anObject
]

{ #category : #accessing }
ERUserAccount >> role [
	^ role
]

{ #category : #accessing }
ERUserAccount >> role: anObject [
	role := anObject
]

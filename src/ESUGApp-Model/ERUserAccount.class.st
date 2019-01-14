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
	#category : #'ESUGApp-Model'
}

{ #category : #accessing }
ERUserAccount class >> admin [
	| instance |
	instance := self new.
	instance role: 'admin'.
	^ instance
]

{ #category : #'as yet unclassified' }
ERUserAccount class >> adminRole [
	^ Heap new
		add: 'admin';
		yourself
]

{ #category : #'as yet unclassified' }
ERUserAccount class >> attendeeRole [
	^ Heap new
		add: 'attendee';
		yourself
]

{ #category : #actions }
ERUserAccount class >> findUserByEmail: aString [
	| userAccount |
	userAccount := ERUserAccount find: [ :each | each email = aString ].
	^ userAccount
]

{ #category : #accessing }
ERUserAccount class >> groupManager [
	| instance |
	instance := self new.
	instance role: 'groupManager'.
	^ instance
]

{ #category : #'as yet unclassified' }
ERUserAccount class >> groupManagerRole [
	^ Heap new
		add: 'groupManager';
		yourself
]

{ #category : #'as yet unclassified' }
ERUserAccount class >> hashPassword: aString [

 ^ aString 
  ifEmpty: [0 asString] 
  ifNotEmpty: [(GRPlatform current secureHashFor: aString) asString].

]

{ #category : #accessing }
ERUserAccount >> deleteRole: anObject [
	role removeAllSuchThat: [ :each | each = anObject  ]
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
	role := Heap new
		add: 'attendee';
		yourself
]

{ #category : #testing }
ERUserAccount >> isAdmin [
	self role
		do: [ :each | 
			each = 'admin'
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #testing }
ERUserAccount >> isAttendee [
	self role do: [ :each | each = 'attendee' ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #testing }
ERUserAccount >> isGroupManager [
	self role
		do: [ :each | 
			each = 'groupManager'
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #testing }
ERUserAccount >> isStudent [
	self role
		do: [ :each | 
			each = 'student'
				ifTrue: [ ^ true ] ].
	^ false
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

{ #category : #accessing }
ERUserAccount >> roleAdd: anObject [
	role add: anObject 
]

{ #category : #'as yet unclassified' }
ERUserAccount >> rolesAsString [
	| roles |
	roles := ''.
	role do: [ :each | roles := roles , ' ' , each ].
	^ roles
]

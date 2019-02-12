Class {
	#name : #ERUserAccount,
	#superclass : #SDActiveRecord,
	#instVars : [
		'firstName',
		'lastName',
		'email',
		'password',
		'confirmPassword',
		'role'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #'as yet unclassified' }
ERUserAccount class >> admin [
	| instance |
	instance := self new.
	instance role: self adminRole .
	^ instance
]

{ #category : #'as yet unclassified' }
ERUserAccount class >> adminRole [
	^ Heap new
		add: 'admin';
		yourself
]

{ #category : #converting }
ERUserAccount class >> asGroupManager [
	|instance|
	instance := self new.
	instance role: (Heap new
		add: 'groupManager';
		yourself).
	^ instance
]

{ #category : #'as yet unclassified' }
ERUserAccount class >> attendeeRole [
	^ Heap new
		add: 'attendee';
		yourself
]

{ #category : #'as yet unclassified' }
ERUserAccount class >> findUserByEmail: aString [
	| userAccount |
	userAccount := ERUserAccount find: [ :each | each email = aString ].
	^ userAccount
]

{ #category : #'as yet unclassified' }
ERUserAccount class >> groupManager [
	| instance |
	instance := self new.
	instance role: self groupManagerRole.
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

{ #category : #converting }
ERUserAccount >> asAttendee [
	self role: (Heap new
		add: 'attendee';
		yourself)
]

{ #category : #converting }
ERUserAccount >> asGroupManager [
	self role: (Heap new
		add: 'groupManager';
		yourself)
]

{ #category : #accessing }
ERUserAccount >> confirmPassword [
	^ confirmPassword
]

{ #category : #accessing }
ERUserAccount >> confirmPassword: anObject [
	confirmPassword := anObject
]

{ #category : #testing }
ERUserAccount >> deleteRole: anObject [
	role removeAllSuchThat: [ :each | each = anObject  ]
]

{ #category : #'as yet unclassified' }
ERUserAccount >> descriptionEmail [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #email; 
		priority: 30;
		beRequired;
		label: 'Email (Required)';
		addCondition: [ :value | value matchesRegex: '\S+@\S+\.\S+' ]
		labelled: 'Please enter a valid email';
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERUserAccount >> descriptionFirstName [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #firstName; 
		priority: 10;
		beRequired;
		label: 'First Name (Required)';
		withoutLabel: true;
		addCondition: [ :value | value matchesRegex: '[(a-zA-Z)+\s*]{3,}' ]
		labelled: 'This field only accept a text';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERUserAccount >> descriptionLastName [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #lastName; 
		priority: 20;
		beRequired;
		label: 'Last Name (Required)';
		withoutLabel: true;
		addCondition: [ :value | value matchesRegex: '[(a-zA-Z)+\s*]{3,}' ]
		labelled: 'This field only accept a text';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
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
	super initialize .
	role := Heap new
		add: 'attendee';
		yourself
]

{ #category : #testing }
ERUserAccount >> isAdmin [
		^ self role anySatisfy: [ :each | each = 'admin']

]

{ #category : #testing }
ERUserAccount >> isAttendee [
	^ self role anySatisfy: [ :each | each = 'attendee']
	
]

{ #category : #testing }
ERUserAccount >> isGroupManager [
	^ self role
		anySatisfy: [ :each | each = 'groupManager']
	
]

{ #category : #testing }
ERUserAccount >> isStudent [
	^ self role
		anySatisfy: [ :each | each = 'studentVolunter']
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

{ #category : #testing }
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

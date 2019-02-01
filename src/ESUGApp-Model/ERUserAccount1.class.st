Class {
	#name : #ERUserAccount1,
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

{ #category : #converting }
ERUserAccount1 class >> asGroupManager [
	|instance|
	instance := self new.
	instance role: (Heap new
		add: 'groupManager';
		yourself).
	^ instance
]

{ #category : #actions }
ERUserAccount1 class >> findUserByEmail: aString [
	| userAccount |
	userAccount := ERUserAccount1 find: [ :each | each email = aString ].
	^ userAccount
]

{ #category : #accessing }
ERUserAccount1 >> confirmPassword [
	^ confirmPassword
]

{ #category : #accessing }
ERUserAccount1 >> confirmPassword: anObject [
	confirmPassword := anObject
]

{ #category : #'as yet unclassified' }
ERUserAccount1 >> descriptionEmail [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #email; 
		priority: 30;
		beRequired;
		label: 'Email (Required)';
		addCondition: [ :value | value matchesRegex: '\S+@\S+\.\S+' ]
		labelled: 'Please enter a valid email';"
		addCondition: [ :value | ERController new emailIsAlreadyRegistered: value ]
		labelled: 'This email is already registered';" 
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERUserAccount1 >> descriptionFirstName [
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
ERUserAccount1 >> descriptionLastName [
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
ERUserAccount1 >> email [
	^ email
]

{ #category : #accessing }
ERUserAccount1 >> email: anObject [
	email := anObject
]

{ #category : #accessing }
ERUserAccount1 >> firstName [
	^ firstName
]

{ #category : #accessing }
ERUserAccount1 >> firstName: anObject [
	firstName := anObject
]

{ #category : #initialization }
ERUserAccount1 >> initialize [ 
	super initialize .
	role := Heap new
		add: 'attendee';
		yourself
]

{ #category : #testing }
ERUserAccount1 >> isAdmin [
	self role
		do: [ :each | 
			each = 'admin'
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #testing }
ERUserAccount1 >> isAttendee [
	self role do: [ :each | each = 'attendee' ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #testing }
ERUserAccount1 >> isGroupManager [
	self role
		do: [ :each | 
			each = 'groupManager'
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #testing }
ERUserAccount1 >> isStudent [
	self role
		do: [ :each | 
			each = 'studentVolunter'
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #accessing }
ERUserAccount1 >> lastName [
	^ lastName
]

{ #category : #accessing }
ERUserAccount1 >> lastName: anObject [
	lastName := anObject
]

{ #category : #accessing }
ERUserAccount1 >> password [
	^ password
]

{ #category : #accessing }
ERUserAccount1 >> password: anObject [
	password := anObject
]

{ #category : #accessing }
ERUserAccount1 >> role [
	^ role
]

{ #category : #accessing }
ERUserAccount1 >> role: anObject [
	role := anObject
]

{ #category : #'as yet unclassified' }
ERUserAccount1 >> rolesAsString [
	| roles |
	roles := ''.
	role do: [ :each | roles := roles , ' ' , each ].
	^ roles
]

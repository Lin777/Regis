Class {
	#name : #ERUserAccount1,
	#superclass : #Object,
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
		addCondition: [ :value | value matchesRegex: '\S+@\S+\.\S+' ]
		labelled: 'Please enter a valid email';
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
	role := 'attendee'
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

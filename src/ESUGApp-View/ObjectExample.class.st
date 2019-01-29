Class {
	#name : #ObjectExample,
	#superclass : #Object,
	#instVars : [
		'lastName',
		'birthday',
		'phoneNumber'
	],
	#category : #'ESUGApp-View-Uncategorized'
}

{ #category : #accessing }
ObjectExample >> birthday [
	^ birthday
]

{ #category : #accessing }
ObjectExample >> birthday: anObject [
	birthday := anObject
]

{ #category : #'as yet unclassified' }
ObjectExample >> descriptionBirthday [
	<magritteDescription>
	| tmp2 |
	tmp2 := MADateDescription new.
	tmp2
		accessor: #birthday; 
		priority: 50;
		beRequired;
		label: 'Birthday';
		withoutLabel: true;
		componentClass: MDLMADateInputComponent.
	^ tmp2 yourself
]

{ #category : #'as yet unclassified' }
ObjectExample >> descriptionLastName [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #lastName; 
		priority: 20;
		beRequired;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ObjectExample >> descriptionPhoneNumber [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #phoneNumber; 
		priority: 30;
		beRequired;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ObjectExample >> lastName [
	^ lastName
]

{ #category : #accessing }
ObjectExample >> lastName: anObject [
	lastName := anObject
]

{ #category : #accessing }
ObjectExample >> phoneNumber [
	^ phoneNumber
]

{ #category : #accessing }
ObjectExample >> phoneNumber: anObject [
	phoneNumber := anObject
]

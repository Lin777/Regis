Class {
	#name : #ERTalk1,
	#superclass : #SDActiveRecord,
	#instVars : [
		'name',
		'description',
		'submitter',
		'presentation',
		'authorsWithoutSubmitter',
		'submittionDate'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #accessing }
ERTalk1 class >> submitter: anAttendee [
	^ self new 
		submitter: anAttendee; 
		yourself 
]

{ #category : #accessing }
ERTalk1 >> authorsWithoutSubmitter [
	^ authorsWithoutSubmitter
]

{ #category : #accessing }
ERTalk1 >> authorsWithoutSubmitter: anObject [
	authorsWithoutSubmitter := anObject
]

{ #category : #accessing }
ERTalk1 >> description [
	^ description
]

{ #category : #accessing }
ERTalk1 >> description: anObject [
	description := anObject
]

{ #category : #'acessing-magritte' }
ERTalk1 >> descriptionDescription [
	<magritteDescription>
	| tmp |
	tmp := MAMemoDescription new.
	tmp 
		accessor: #description; 
		priority: 20;
		beRequired;
		lineCount: 5;
		label: 'Description (Required)';
		withoutLabel: true;
		componentClass: MDLMATextAreaComponent.
	^ tmp yourself
]

{ #category : #'acessing-magritte' }
ERTalk1 >> descriptionName [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #name; 
		priority: 10;
		beRequired;
		label: 'Name (Required)';
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'acessing-magritte' }
ERTalk1 >> descriptionOtherAuthors [
	<magritteDescription>
	| tmp |
	tmp := MAMemoDescription new.
	tmp 
		accessor: #authorsWithoutSubmitter; 
		priority: 40;
		required: false;
		lineCount: 5;
		withoutLabel: true;
		componentClass: MDLMATextAreaComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERTalk1 >> name [
	^ name
]

{ #category : #accessing }
ERTalk1 >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ERTalk1 >> presentation [
	^ presentation
]

{ #category : #accessing }
ERTalk1 >> presentation: anObject [
	presentation := anObject
]

{ #category : #accessing }
ERTalk1 >> submittedBy [
	^ submitter userAccount firstName
]

{ #category : #accessing }
ERTalk1 >> submitter [
	^ submitter
]

{ #category : #accessing }
ERTalk1 >> submitter: anObject [
	submitter := anObject
]

{ #category : #accessing }
ERTalk1 >> submittionDate [
	^ submittionDate
]

{ #category : #accessing }
ERTalk1 >> submittionDate: anObject [
	submittionDate := anObject
]

{ #category : #accessing }
ERTalk1 >> uploadFile [
	^ presentation
]

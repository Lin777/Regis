Class {
	#name : #ERTalk,
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
ERTalk class >> submitter: anAttendee [
	^ self new 
		submitter: anAttendee; 
		yourself 
]

{ #category : #accessing }
ERTalk >> authorsWithoutSubmitter [
	^ authorsWithoutSubmitter
]

{ #category : #accessing }
ERTalk >> authorsWithoutSubmitter: anObject [
	authorsWithoutSubmitter := anObject
]

{ #category : #accessing }
ERTalk >> description [
	^ description
]

{ #category : #accessing }
ERTalk >> description: anObject [
	description := anObject
]

{ #category : #'acessing-magritte' }
ERTalk >> descriptionDescription [
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
		id: 'description';
		componentClass: MDLMATextAreaComponent.
	^ tmp yourself
]

{ #category : #'acessing-magritte' }
ERTalk >> descriptionName [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #name; 
		priority: 10;
		beRequired;
		label: 'Name (Required)';
		withoutLabel: true;
		id: 'name';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'acessing-magritte' }
ERTalk >> descriptionOtherAuthors [
	<magritteDescription>
	^ ERAdditionalInformation new descriptionAdditionalText copy
         accessor: #authorsWithoutSubmitter; 
			priority: 40;
		   lineCount: 5;
			id: 'authorsWithoutSubmitter';
         yourself
]

{ #category : #accessing }
ERTalk >> name [
	^ name
]

{ #category : #accessing }
ERTalk >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ERTalk >> presentation [
	^ presentation
]

{ #category : #accessing }
ERTalk >> presentation: anObject [
	presentation := anObject
]

{ #category : #accessing }
ERTalk >> submittedBy [
	^ submitter userAccount firstName
]

{ #category : #accessing }
ERTalk >> submitter [
	^ submitter
]

{ #category : #accessing }
ERTalk >> submitter: anObject [
	submitter := anObject
]

{ #category : #accessing }
ERTalk >> submittionDate [
	^ submittionDate
]

{ #category : #accessing }
ERTalk >> submittionDate: anObject [
	submittionDate := anObject
]

{ #category : #accessing }
ERTalk >> uploadFile [
	^ presentation
]

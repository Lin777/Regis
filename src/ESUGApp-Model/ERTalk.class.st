"
Description
-----------

I am a model of Talk
"
Class {
	#name : #ERTalk,
	#superclass : #ESUGActiveRecord,
	#instVars : [
		'title',
		'description',
		'submitter',
		'presentation',
		'authorsWithoutSubmitter',
		'submittionDate',
		'bio'
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
ERTalk >> bio [
	^ bio
]

{ #category : #accessing }
ERTalk >> bio: anObject [
	bio := anObject
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
ERTalk >> descriptionBio [
	<magritteDescription>
	| tmp |
	tmp := MAMemoDescription new.
	tmp 
		accessor: #bio; 
		priority: 40;
		beRequired;
		lineCount: 5;
		label: 'Bio (Required)';
		withoutLabel: true;
		id: 'bio';
		componentClass: MDLMATextAreaComponent.
	^ tmp yourself
]

{ #category : #'acessing-magritte' }
ERTalk >> descriptionDescription [
	<magritteDescription>
	| tmp |
	tmp := MAMemoDescription new.
	tmp 
		accessor: #description; 
		priority: 30;
		beRequired;
		lineCount: 5;
		label: 'Abstract (Required)';
		withoutLabel: true;
		id: 'description';
		componentClass: MDLMATextAreaComponent.
	^ tmp yourself
]

{ #category : #'acessing-magritte' }
ERTalk >> descriptionOtherAuthors [
	<magritteDescription>
	^ ERAdditionalInformation new descriptionAdditionalText copy
         accessor: #authorsWithoutSubmitter; 
			priority: 20;
		   lineCount: 5;
			label: 'Authors without the submitter';
			id: 'authorsWithoutSubmitter';
         yourself
]

{ #category : #'acessing-magritte' }
ERTalk >> descriptionPresentation [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #presentation; 
		priority: 50;
		label: 'Presentation Download URL';
		addCondition: [ :value | value asUrl isAbsolute ]
		labelled: 'Please enter a valid URL';
		withoutLabel: true;
		id: 'presentation';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'acessing-magritte' }
ERTalk >> descriptionTitle [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #title; 
		priority: 10;
		beRequired;
		label: 'Title (Required)';
		withoutLabel: true;
		id: 'title';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
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
ERTalk >> title [
	^ title
]

{ #category : #accessing }
ERTalk >> title: anObject [
	title := anObject
]

{ #category : #accessing }
ERTalk >> uploadFile [
	^ presentation
]

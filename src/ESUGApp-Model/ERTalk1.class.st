Class {
	#name : #ERTalk1,
	#superclass : #Object,
	#instVars : [
		'name',
		'submittedBy',
		'uploadFile'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #'acessing-magritte' }
ERTalk1 >> descriptionName [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #name; 
		priority: 10;
		beRequired;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'acessing-magritte' }
ERTalk1 >> descriptionSubmitedBy [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #submittedBy; 
		priority: 20;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
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
ERTalk1 >> submittedBy [
	^ submittedBy
]

{ #category : #accessing }
ERTalk1 >> submittedBy: anObject [
	submittedBy := anObject
]

{ #category : #accessing }
ERTalk1 >> uploadFile [
	^ uploadFile
]

{ #category : #accessing }
ERTalk1 >> uploadFile: anObject [
	uploadFile := anObject
]

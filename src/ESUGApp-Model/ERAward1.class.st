Class {
	#name : #ERAward1,
	#superclass : #Object,
	#instVars : [
		'nameAward',
		'submitter',
		'otherDevelopers'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #'as yet unclassified' }
ERAward1 >> descriptionNameAward [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #nameAward; 
		priority: 10;
		beRequired;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERAward1 >> descriptionOtherDevelopers [
	<magritteDescription>
	| tmp |
	tmp := MAMemoDescription new.
	tmp 
		accessor: #otherDevelopers; 
		priority: 30;
		required: false;
		lineCount: 13;
		withoutLabel: true;
		componentClass: MDLMATextAreaComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERAward1 >> descriptionSubmitter [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #submitter; 
		priority: 20;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERAward1 >> nameAward [
	^ nameAward
]

{ #category : #accessing }
ERAward1 >> nameAward: anObject [
	nameAward := anObject
]

{ #category : #accessing }
ERAward1 >> otherDevelopers [
	^ otherDevelopers
]

{ #category : #accessing }
ERAward1 >> otherDevelopers: anObject [
	otherDevelopers := anObject
]

{ #category : #accessing }
ERAward1 >> submitter [
	^ submitter
]

{ #category : #accessing }
ERAward1 >> submitter: anObject [
	submitter := anObject
]

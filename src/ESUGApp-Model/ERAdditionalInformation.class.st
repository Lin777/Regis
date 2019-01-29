Class {
	#name : #ERAdditionalInformation,
	#superclass : #Object,
	#instVars : [
		'keywords',
		'additionalText'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #accessing }
ERAdditionalInformation >> additionalText [
	^ additionalText
]

{ #category : #accessing }
ERAdditionalInformation >> additionalText: anObject [
	additionalText := anObject
]

{ #category : #'as yet unclassified' }
ERAdditionalInformation >> descriptionAdditionalText [
	<magritteDescription>
	| tmp |
	tmp := MAMemoDescription new.
	tmp 
		accessor: #additionalText; 
		priority: 20;
		required: false;
		lineCount: 13;
		withoutLabel: true;
		componentClass: MDLMATextAreaComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERAdditionalInformation >> descriptionKeywords [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #keywords; 
		priority: 10;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERAdditionalInformation >> keywords [
	^ keywords
]

{ #category : #accessing }
ERAdditionalInformation >> keywords: anObject [
	keywords := anObject
]

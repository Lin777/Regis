"
Description
--------------------

I am a model of Additional information
"
Class {
	#name : #ERAdditionalInformation,
	#superclass : #Object,
	#instVars : [
		'keywords',
		'additionalText',
		'classId'
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

{ #category : #accessing }
ERAdditionalInformation >> classId: anId [

	classId := anId
]

{ #category : #'magritte descriptions' }
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
	classId
		ifNil: [ tmp id: 'additionalText' ]
		ifNotNil: [ tmp id: 'additionalText', classId printString ].
	^ tmp yourself
]

{ #category : #'magritte descriptions' }
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
	classId
		ifNil: [ tmp id: 'keywords' ]
		ifNotNil: [ tmp id: 'keywords', classId printString ].
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

{ #category : #accessing }
ERAdditionalInformation >> label [ 	
	^ 'Add'
]

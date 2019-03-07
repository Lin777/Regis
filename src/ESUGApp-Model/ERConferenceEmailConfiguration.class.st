Class {
	#name : #ERConferenceEmailConfiguration,
	#superclass : #Object,
	#instVars : [
		'senderEmailAddress',
		'apiKey',
		'welcomeText'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #accessing }
ERConferenceEmailConfiguration >> apiKey [
	^ apiKey
]

{ #category : #accessing }
ERConferenceEmailConfiguration >> apiKey: anObject [
	apiKey := anObject
]

{ #category : #'as yet unclassified' }
ERConferenceEmailConfiguration >> descriptionApiKey [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #apiKey; 
		priority: 30;
		required: true;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERConferenceEmailConfiguration >> descriptionSenderEmailAddress [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #senderEmailAddress; 
		priority: 10;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERConferenceEmailConfiguration >> descriptionWelcomeText [
	<magritteDescription>
	| tmp |
	tmp := MAMemoDescription new.
	tmp 
		accessor: #welcomeText; 
		priority: 40;
		required: false;
		lineCount: 5;
		withoutLabel: true;
		componentClass: MDLMATextAreaComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERConferenceEmailConfiguration >> senderEmailAddress [
	^ senderEmailAddress
]

{ #category : #accessing }
ERConferenceEmailConfiguration >> senderEmailAddress: anObject [
	senderEmailAddress := anObject
]

{ #category : #accessing }
ERConferenceEmailConfiguration >> welcomeText [
	^ welcomeText
]

{ #category : #accessing }
ERConferenceEmailConfiguration >> welcomeText: anObject [
	welcomeText := anObject
]

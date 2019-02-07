Class {
	#name : #ERConferenceEmailConfiguration,
	#superclass : #Object,
	#instVars : [
		'senderEmailAddress',
		'smptServerAddress',
		'smptClient',
		'welcomeText'
	],
	#category : #'ESUGApp-Model-Magritte'
}

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
ERConferenceEmailConfiguration >> descriptionSmptClient [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #smptClient; 
		priority: 30;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERConferenceEmailConfiguration >> descriptionSmptServerAddress [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #smptServerAddress; 
		priority: 20;
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
ERConferenceEmailConfiguration >> smptClient [
	^ smptClient
]

{ #category : #accessing }
ERConferenceEmailConfiguration >> smptClient: anObject [
	smptClient := anObject
]

{ #category : #accessing }
ERConferenceEmailConfiguration >> smptServerAddress [
	^ smptServerAddress
]

{ #category : #accessing }
ERConferenceEmailConfiguration >> smptServerAddress: anObject [
	smptServerAddress := anObject
]

{ #category : #accessing }
ERConferenceEmailConfiguration >> welcomeText [
	^ welcomeText
]

{ #category : #accessing }
ERConferenceEmailConfiguration >> welcomeText: anObject [
	welcomeText := anObject
]

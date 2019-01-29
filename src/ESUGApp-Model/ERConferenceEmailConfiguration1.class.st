Class {
	#name : #ERConferenceEmailConfiguration1,
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
ERConferenceEmailConfiguration1 >> descriptionSenderEmailAddress [
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
ERConferenceEmailConfiguration1 >> descriptionSmptClient [
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
ERConferenceEmailConfiguration1 >> descriptionSmptServerAddress [
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
ERConferenceEmailConfiguration1 >> descriptionWelcomeText [
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
ERConferenceEmailConfiguration1 >> senderEmailAddress [
	^ senderEmailAddress
]

{ #category : #accessing }
ERConferenceEmailConfiguration1 >> senderEmailAddress: anObject [
	senderEmailAddress := anObject
]

{ #category : #accessing }
ERConferenceEmailConfiguration1 >> smptClient [
	^ smptClient
]

{ #category : #accessing }
ERConferenceEmailConfiguration1 >> smptClient: anObject [
	smptClient := anObject
]

{ #category : #accessing }
ERConferenceEmailConfiguration1 >> smptServerAddress [
	^ smptServerAddress
]

{ #category : #accessing }
ERConferenceEmailConfiguration1 >> smptServerAddress: anObject [
	smptServerAddress := anObject
]

{ #category : #accessing }
ERConferenceEmailConfiguration1 >> welcomeText [
	^ welcomeText
]

{ #category : #accessing }
ERConferenceEmailConfiguration1 >> welcomeText: anObject [
	welcomeText := anObject
]

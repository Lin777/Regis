"
Description
--------------------

I am a model of Conference Email Configuration
"
Class {
	#name : #ERConferenceEmailConfiguration,
	#superclass : #Object,
	#instVars : [
		'senderEmailAddress',
		'apiKey',
		'welcomeText',
		'emailHelp'
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

{ #category : #'magrittes-descriptions' }
ERConferenceEmailConfiguration >> descriptionApiKey [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #apiKey; 
		priority: 30;
		required: true;
		withoutLabel: true;
		id: 'apiKey';
		label: 'Api key (Required)';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERConferenceEmailConfiguration >> descriptionEmailHelp [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #emailHelp; 
		priority: 50;
		withoutLabel: true;
		addCondition: [ :value | value matchesRegex: '\S+@\S+\.\S+' ];
		id: 'emailHelpContact';
		label: 'Email for Contact Us';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERConferenceEmailConfiguration >> descriptionSenderEmailAddress [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #senderEmailAddress; 
		priority: 10;
		required: true;
		withoutLabel: true;
		addCondition: [ :value | value matchesRegex: '\S+@\S+\.\S+' ]
		labelled: 'Please enter a valid email';
		id: 'senderEmailAddress';
		label: 'Sender email address (Required)';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
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
		id: 'welcomeText';
		componentClass: MDLMATextAreaComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERConferenceEmailConfiguration >> emailHelp [
	^ emailHelp ifNil: [ emailHelp := 'example@mail.com' ]
]

{ #category : #accessing }
ERConferenceEmailConfiguration >> emailHelp: anObject [
	emailHelp := anObject
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

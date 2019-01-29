Class {
	#name : #ERConferenceOrganizer1,
	#superclass : #Object,
	#instVars : [
		'name',
		'fiscalSituation',
		'webPageUrl',
		'addressString'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #accessing }
ERConferenceOrganizer1 >> addressString [
	^ addressString
]

{ #category : #accessing }
ERConferenceOrganizer1 >> addressString: anObject [
	addressString := anObject
]

{ #category : #'as yet unclassified' }
ERConferenceOrganizer1 >> descriptionAddressString [
	<magritteDescription>
	| tmp |
	tmp := MAMemoDescription new.
	tmp 
		accessor: #addressString; 
		priority: 40;
		required: false;
		lineCount: 5;
		withoutLabel: true;
		componentClass: MDLMATextAreaComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERConferenceOrganizer1 >> descriptionFiscalSituation [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #fiscalSituation; 
		priority: 20;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERConferenceOrganizer1 >> descriptionName [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #name; 
		priority: 10;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERConferenceOrganizer1 >> descriptionWebPageUrl [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #webPageUrl; 
		priority: 30;
		required: false;
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERConferenceOrganizer1 >> fiscalSituation [
	^ fiscalSituation
]

{ #category : #accessing }
ERConferenceOrganizer1 >> fiscalSituation: anObject [
	fiscalSituation := anObject
]

{ #category : #accessing }
ERConferenceOrganizer1 >> name [
	^ name
]

{ #category : #accessing }
ERConferenceOrganizer1 >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ERConferenceOrganizer1 >> webPageUrl [
	^ webPageUrl
]

{ #category : #accessing }
ERConferenceOrganizer1 >> webPageUrl: anObject [
	webPageUrl := anObject
]

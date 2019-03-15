Class {
	#name : #ERConferenceOrganizer,
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
ERConferenceOrganizer >> addressString [
	^ addressString
]

{ #category : #accessing }
ERConferenceOrganizer >> addressString: anObject [
	addressString := anObject
]

{ #category : #'as yet unclassified' }
ERConferenceOrganizer >> descriptionAddressString [
	<magritteDescription>
	| tmp |
	tmp := MAMemoDescription new.
	tmp 
		accessor: #addressString; 
		priority: 40;
		required: false;
		lineCount: 5;
		withoutLabel: true;
		id: 'addressString';
		componentClass: MDLMATextAreaComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERConferenceOrganizer >> descriptionFiscalSituation [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #fiscalSituation; 
		priority: 20;
		required: false;
		withoutLabel: true;
		id: 'fiscalSituation';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERConferenceOrganizer >> descriptionName [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #name; 
		priority: 10;
		required: false;
		withoutLabel: true;
		id: 'name';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERConferenceOrganizer >> descriptionWebPageUrl [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #webPageUrl; 
		priority: 30;
		required: false;
		withoutLabel: true;
		id: 'webPageUrl';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERConferenceOrganizer >> fiscalSituation [
	^ fiscalSituation
]

{ #category : #accessing }
ERConferenceOrganizer >> fiscalSituation: anObject [
	fiscalSituation := anObject
]

{ #category : #accessing }
ERConferenceOrganizer >> name [
	^ name
]

{ #category : #accessing }
ERConferenceOrganizer >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ERConferenceOrganizer >> webPageUrl [
	^ webPageUrl
]

{ #category : #accessing }
ERConferenceOrganizer >> webPageUrl: anObject [
	webPageUrl := anObject
]

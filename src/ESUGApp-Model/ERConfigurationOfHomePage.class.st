"
Description
--------------------

I am a model of Configuration Of Home Page
"
Class {
	#name : #ERConfigurationOfHomePage,
	#superclass : #Object,
	#instVars : [
		'title',
		'htmlContent'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #'acessing-magritte' }
ERConfigurationOfHomePage >> descriptionHtmlContent [
	<magritteDescription>
	| tmp |
	tmp := MAMemoDescription new.
	tmp 
		accessor: #htmlContent; 
		priority: 30;
		required: true;
		lineCount: 5;
		withoutLabel: true;
		id: 'htmlContent';
		componentClass: MDLMATextAreaComponent.
	^ tmp yourself
]

{ #category : #'acessing-magritte' }
ERConfigurationOfHomePage >> descriptionTitle [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #title; 
		priority: 10;
		required: true;
		withoutLabel: true;
		id: 'title';
		label: 'Title (Required)';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERConfigurationOfHomePage >> htmlContent [
	^ htmlContent
]

{ #category : #accessing }
ERConfigurationOfHomePage >> htmlContent: anObject [
	htmlContent := anObject
]

{ #category : #accessing }
ERConfigurationOfHomePage >> title [
	^ title
]

{ #category : #accessing }
ERConfigurationOfHomePage >> title: anObject [
	title := anObject
]

Class {
	#name : #EREsugApp,
	#superclass : #WAComponent,
	#instVars : [
		'controller',
		'content'
	],
	#category : #'ESUGApp-View-Page'
}

{ #category : #registry }
EREsugApp class >> canBeRoot [
	^ true
]

{ #category : #registry }
EREsugApp class >> initialize [
	"self initialize"

	(WAAdmin register: self asApplicationAt: 'ESUG')
		addLibrary: JQDeploymentLibrary;
		addLibrary: MDLLibrary;
		addLibrary: CssForLoginMDL;
		addLibrary: ERLibrary;
		preferenceAt: #sessionClass put: ERSession";
		cache expiryPolicy configuration 
    at: #cacheTimeout put: 60"
]

{ #category : #registry }
EREsugApp class >> register: aFormView [
	|formRegister|
	formRegister := self new.
	aFormView content: formRegister content.
	aFormView pageController: formRegister controller .
	aFormView initializeTabForms.
	^ formRegister 
]

{ #category : #initialization }
EREsugApp >> children [ 
	^ Array with: content
]

{ #category : #accessing }
EREsugApp >> content [
	^ content
]

{ #category : #accessing }
EREsugApp >> content: anObject [
	content := anObject
]

{ #category : #accessing }
EREsugApp >> controller [
	^ controller
]

{ #category : #accessing }
EREsugApp >> controller: anObject [
	controller := anObject
]

{ #category : #initialization }
EREsugApp >> initialize [
	super initialize.
	controller := ERRegistrationController new.
	content := ERContent new.
	self initializeLoginView
]

{ #category : #initialization }
EREsugApp >> initializeLoginView [
	| aFormView |
	aFormView := ERLoginPage new.
	aFormView content: self content.
	^ aFormView
]

{ #category : #rendering }
EREsugApp >> renderContentOn: html [
	html render: content
]

{ #category : #initialization }
EREsugApp >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot beHtml5.
	anHtmlRoot meta
		attributeAt: 'name' put: 'viewport';
		content: 'width=device-width, initial-scale=1'.
	anHtmlRoot link
				relationship: 'icon';
				type: 'image/png';
				url: (CssForLoginMDL urlOf: #esugPng)
]

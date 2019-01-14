Class {
	#name : #EREsugApp,
	#superclass : #WAComponent,
	#instVars : [
		'controller',
		'content'
	],
	#category : #'ESUGApp-View'
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
		addLibrary: ERMaterialBlueRedMinCss;
		addLibrary: ERJQValidateForm;
		addLibrary: CssForLoginMDL;
		addLibrary: ERLibrary;
		preferenceAt: #sessionClass put: ERSession
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
	aFormView := ERLoginView new.
	aFormView content: self content.
	^ aFormView
]

{ #category : #initialization }
EREsugApp >> renderContentOn: html [
	html render: content
]

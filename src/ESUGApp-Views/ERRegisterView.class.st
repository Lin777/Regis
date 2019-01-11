Class {
	#name : #ERRegisterView,
	#superclass : #WAComponent,
	#instVars : [
		'controller',
		'content'
	],
	#category : #'ESUGApp-Views'
}

{ #category : #registry }
ERRegisterView class >> register: aFormView [
	|formRegister|
	formRegister := self new.
	aFormView content: formRegister content.
	aFormView pageController: formRegister controller .
	aFormView initializeTabForms.
	^ formRegister 
]

{ #category : #accessing }
ERRegisterView >> content [
	^ content
]

{ #category : #accessing }
ERRegisterView >> content: anObject [
	content := anObject
]

{ #category : #accessing }
ERRegisterView >> controller [
	^ controller
]

{ #category : #accessing }
ERRegisterView >> controller: anObject [
	controller := anObject
]

{ #category : #initialization }
ERRegisterView >> initialize [
	super initialize.
	controller := ERRegistrationController new.
	content := ERContent new
]

{ #category : #initialization }
ERRegisterView >> renderContentOn: html [
	html render: content
]

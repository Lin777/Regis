Class {
	#name : #ERFinishRegisterGroupManagerPage,
	#superclass : #ERFinishRegisterPage,
	#category : #'ESUGApp-View-Page'
}

{ #category : #'as yet unclassified' }
ERFinishRegisterGroupManagerPage >> actionsBody: html [
	
]

{ #category : #rendering }
ERFinishRegisterGroupManagerPage >> backAction [
	self returnToThePreviousState
]

{ #category : #rendering }
ERFinishRegisterGroupManagerPage >> cancelAction [
	self returnToThePreviousState
]

{ #category : #rendering }
ERFinishRegisterGroupManagerPage >> finishRegister [
	| user |
	user := pageController saveGroupManager.
	self redirectLoggedPage: user
]

{ #category : #rendering }
ERFinishRegisterGroupManagerPage >> finishRegister: html [
	| user |
	user := pageController saveGroupManager.
	self redirectLoggedPage: user
]

{ #category : #rendering }
ERFinishRegisterGroupManagerPage >> renderPageOn: html [
	html mdlGrid
		noSpacing;
		with: [ self renderContactInformation: html.
			self renderAffiliation: html.
			self renderActions: html ]
]

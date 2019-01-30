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
	user := pageController saveAsGroupManager.
	"user
		ifNotNil: [ self session login: user.
			self call: ERLoggedPage new ].
	self answer: true"
	self redirectLoggedPage: user
]

{ #category : #rendering }
ERFinishRegisterGroupManagerPage >> renderBody: html with: aBlock [
	html div
		style:
			'background-image: url(''/files/CssForLoginMDL/profile_city.jpg''); background-repeat: repeat-y; background-size: cover; height: 100vh; ';
		with: [ html break.
			html break.
			aBlock value ]
]

{ #category : #rendering }
ERFinishRegisterGroupManagerPage >> renderPageOn: html [
	html mdlGrid
		class: 'mdl-grid--no-spacing';
		with: [ self renderContactInformation: html.
			self renderAffiliation: html.
			self renderActions: html ]
]

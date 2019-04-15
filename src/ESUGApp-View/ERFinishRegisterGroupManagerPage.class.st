Class {
	#name : #ERFinishRegisterGroupManagerPage,
	#superclass : #ERFinishRegisterPage,
	#category : #'ESUGApp-View-Page'
}

{ #category : #'as yet unclassified' }
ERFinishRegisterGroupManagerPage >> actionsBody: html [
	
]

{ #category : #rendering }
ERFinishRegisterGroupManagerPage >> finishRegister [
	"| user |
	user := pageController saveGroupManager.
	self redirectLoggedPage: user"
	self redirectLoggedPage: attendee userAccount
]

{ #category : #rendering }
ERFinishRegisterGroupManagerPage >> renderActions: html [
	html mdlCardActions
		class: 'mdl-card--border';
		with: [ 
			html mdlAnchorButton
		colored;
		id: 'okButton';
		callback: [ self finishRegister ];
		with: 'Ok']
]

{ #category : #rendering }
ERFinishRegisterGroupManagerPage >> renderPageOn: html [
	html mdlGrid
		noSpacing;
		with: [ self renderContactInformation: html.
			self renderAffiliation: html.
			self renderActions: html ]
]

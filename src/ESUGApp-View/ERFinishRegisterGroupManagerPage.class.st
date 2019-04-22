Class {
	#name : #ERFinishRegisterGroupManagerPage,
	#superclass : #ERFinishRegisterPage,
	#category : #'ESUGApp-View-Page'
}

{ #category : #actions }
ERFinishRegisterGroupManagerPage >> finishRegister [
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

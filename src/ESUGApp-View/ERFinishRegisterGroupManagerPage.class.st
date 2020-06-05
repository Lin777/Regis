"
Description
--------------------

I am an Summary Page for group manager register
"
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
ERFinishRegisterGroupManagerPage >> renderContactInformation: html [
	"Render contact informatin of group manager"

	html mdlCell
		class: 'mdl-cell--4-col';
		with: [ self renderTitle: html with: 'Group Manager Information'.
			self renderFirstNameOn: html.
			self renderLastNameOn: html.
			self renderEmailOn: html.
			html break ]
]

{ #category : #rendering }
ERFinishRegisterGroupManagerPage >> renderGroupContactInformation: html [
	
	html mdlCell
		class: 'mdl-cell--4-col';
		with: [ 
			self renderTitle: html with: 'Group Information'.
			self renderFacebookUrlOn: html.
			self renderTwitterUrlOn: html.
			self renderHomePageUrlOn: html.
			self renderAddressOn: html.
			self renderAddress2On: html.
			self renderCityOn: html.
			self renderProvinceOn: html.
			self renderPostalOn: html.
			self renderCountryOn: html ]
]

{ #category : #rendering }
ERFinishRegisterGroupManagerPage >> renderPageOn: html [
	"Render group final registration"
	
	html mdlGrid
		noSpacing;
		with: [ 
			self renderContactInformation: html.
			self renderGroupContactInformation: html.
			self renderAffiliation: html.
			self renderActions: html ]
]

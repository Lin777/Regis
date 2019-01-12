Class {
	#name : #ERFinishRegisterGroupManagerPage,
	#superclass : #ERFinishRegisterPage,
	#category : #'ESUGApp-View'
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
ERFinishRegisterGroupManagerPage >> finishAction [
	| user |
	user := pageController saveAsGroupManager.
	user
		ifNotNil: [ self session login: user.
			self call: ERLoggedPage new ].
	self answer: true
]

{ #category : #rendering }
ERFinishRegisterGroupManagerPage >> nextAction [
	| user |
	user := pageController saveAsGroupManager.
	user
		ifNotNil: [ self session login: user.
			self call: ERLoggedPage new  ].
	self answer: true
]

{ #category : #rendering }
ERFinishRegisterGroupManagerPage >> renderAffiliation: html [
	html mdlCell
		class: 'mdl-cell--4-col';
		with: [ self renderTitle: html with: 'Affiliation'.
			self
				createTextStrongWithoutParagraph: 'Organization Name: '
				with: #orgName
				on: html.
			self
				createTextStrongWithoutParagraph: 'Address Line 1: '
				with: #orgAddrees1
				on: html.
			self
				createTextStrongWithoutParagraph: 'Address Line 2: '
				with: #orgAddrees2
				on: html.
			self
				createTextStrongWithoutParagraph: 'City: '
				with: #orgCity
				on: html.
			html break ].
	html mdlCell
		class: 'mdl-cell--4-col';
		with: [ html break.
			html break. html break.
			html horizontalRule.
			self
				createTextStrongWithoutParagraph: 'Province/States: '
				with: #orgProvince
				on: html.
			self
				createTextStrongWithoutParagraph: 'Postal/Zip Code: '
				with: #orgPostal
				on: html.
			self
				createTextStrongWithoutParagraph: 'Country: '
				with: #orgCountry
				on: html.
			self
				createTextStrongWithoutParagraph: 'MemberShip Type: '
				with: #membershipType
				on: html.
			html break ]
]

{ #category : #rendering }
ERFinishRegisterGroupManagerPage >> renderBody: html with: aBlock [
	html div
		style:
			'background-image: url(''/files/CssForLoginMDL/profile_city.jpg''); background-size: cover; height: 100vh; ';
		with: [ html break.
			html break.
			aBlock value ]
]

{ #category : #rendering }
ERFinishRegisterGroupManagerPage >> renderContactInformation: html [
	html mdlCell
		class: 'mdl-cell--4-col';
		with: [ self renderTitle: html with: 'Contact Information'.
			self
				createTextStrongWithoutParagraph: 'First Name: '
				with: #firstName
				on: html.
			self
				createTextStrongWithoutParagraph: 'Last Name: '
				with: #lastName
				on: html.
			self
				createTextStrongWithoutParagraph: 'Email: '
				with: #email
				on: html.
			html break ]
]

{ #category : #rendering }
ERFinishRegisterGroupManagerPage >> renderPageOn: html [
	html mdlGrid
		class: 'mdl-grid--no-spacing';
		with: [ self renderContactInformation: html.
			self renderAffiliation: html.
			self renderActions: html ]
]

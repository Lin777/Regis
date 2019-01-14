Class {
	#name : #ERFinishRegisterAttendeePage,
	#superclass : #ERFinishRegisterPage,
	#category : #'ESUGApp-View-Page'
}

{ #category : #'as yet unclassified' }
ERFinishRegisterAttendeePage >> actionsBody: html [
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> backAction [
	
	self returnToThePreviousState
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> cancelAction [
	self returnToThePreviousState 
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> finishAction [
	attendee paymentTypeIsBankTransfer
		ifTrue: [ ^ self registerAndShowFinishViewForBankTransfer ].
	attendee paymentTypeIsCreditCard
		ifTrue: [ ^ self registerAndRedirectionPayPAL ].
	ERException new
		messageText: 'The type of payment entered is not valid. ';
		signal
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> nextAction [
	attendee paymentTypeIsBankTransfer
		ifTrue: [ ^ self registerAndShowFinishViewForBankTransfer ].
	attendee paymentTypeIsCreditCard
		ifTrue: [ ^ self registerAndRedirectionPayPAL ].
	ERException new
		messageText: 'The type of payment entered is not valid. ';
		signal
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> registerAndRedirectionPayPAL [
	| url |
	pageController save.
	url := pageController payPalUrlFor: attendee.
	self requestContext redirectTo: url
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> registerAndShowFinishViewForBankTransfer [
	| finishRegisterView |
	finishRegisterView := ERBankTransferPage
		on: attendee
		withContent: content
		withController: pageController.
	content state: finishRegisterView
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderAffiliation: html [
	html mdlCell class: 'mdl-cell--4-col';
	with: [ 
	self renderTitle: html with: 'Affiliation'.
	self createTextStrongWithoutParagraph:'Organization Name: ' with: #orgName on: html.
	self createTextStrongWithoutParagraph:'Address Line 1: ' with: #orgAddrees1 on: html.
	self createTextStrongWithoutParagraph:'Address Line 2: ' with: #orgAddrees2 on: html.
	self createTextStrongWithoutParagraph:'City: ' with: #orgCity on: html.
	self createTextStrongWithoutParagraph:'Province/States: ' with: #orgProvince on: html.
	self createTextStrongWithoutParagraph:'Postal/Zip Code: ' with: #orgPostal on: html.
	self createTextStrongWithoutParagraph:'Country: ' with: #orgCountry on: html.
	self createTextStrongWithoutParagraph:'MemberShip Type: ' with: #membershipType on: html.
	self renderTitle: html with: 'Additional Information'.
	self createTextStrongWithoutParagraph:'Additional Text: ' with: #additionalText on: html.
	self createTextStrongWithoutParagraph:'Keywords: ' with: #keywords on: html.
	]
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderBody: html with: aBlock [
	html div
		style:
			'background-image: url(''/files/CssForLoginMDL/profile_city.jpg''); background-size: cover; height: 100vh; ';
		with: [ html break.
			html break.
			aBlock value ]
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderContactInformation: html [
	html mdlCell
		class: 'mdl-cell--4-col';
		with: [ self renderTitle: html with: 'Contact Information'.
			self createTextStrongWithoutParagraph: 'First Name: ' with: #firstName on: html.
			self createTextStrongWithoutParagraph: 'Last Name: ' with: #lastName on: html.
			self createTextStrongWithoutParagraph: 'Email: ' with: #email on: html.
			self createTextStrongWithoutParagraph: 'Facebook: ' with: #facebookURL on: html.
			self createTextStrongWithoutParagraph: 'Twitter: ' with: #twitterURL on: html.
			self createTextStrongWithoutParagraph: 'Home Page: ' with: #homePage on: html.
			
			self createTextStrongWithoutParagraph: 'Address Line 1: ' with: #address on: html.
			self createTextStrongWithoutParagraph: 'Address Line 2: ' with: #address2 on: html.
			self createTextStrongWithoutParagraph: 'City: ' with: #city on: html.
			self createTextStrongWithoutParagraph: 'Province/States: ' with: #province on: html.
			self createTextStrongWithoutParagraph: 'Postal/Zip Code: ' with: #postal on: html.
			self createTextStrongWithoutParagraph: 'Country: ' with: #country on: html.
			self renderTitle: html with: 'Conference Options'.
			self createTextStrongWithoutParagraph: 'Day(s) to attend: ' withText: self stringOfDays on: html.
			self createTextStrongWithoutParagraph: 'Gender: ' with: #gender on: html.
			self createTextStrongWithoutParagraph: 'TShirt: ' with: #tshirtSize on: html.
			self createTextStrongWithoutParagraph: 'Type Food: ' with: #foodPreference on: html.
			self createTextStrongWithoutParagraph: 'Goes Social Event: ' withText: (self stringForBooleanForASymbol: #attendSocialEvent) on: html.
			self createTextStrongWithoutParagraph: 'Add mailling list: ' withText: (self stringForBooleanForASymbol: #addedToMainList) on: html.
			html break
	
			 ]
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderPageOn: html [
	html mdlGrid class: 'mdl-grid--no-spacing';
	with: [ 
		self renderContactInformation: html.
		self renderAffiliation: html.
		self renderPaymentInformation: html.
		self renderActions: html.
	]
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderPaymentInformation: html [
	html mdlCell
		class: 'mdl-cell--4-col';
		with: [ self renderTitle: html with: 'Payment Information'.
			self
				createTextStrongWithoutParagraph: 'Payment Type: '
				with: #paymentType
				on: html.
			self
				createTextStrongWithoutParagraph: 'Payment Currency: '
				with: #paymentCurrency
				on: html.
			self
				createTextStrongWithoutParagraph: 'Conference Fee: '
				withText: (pageController conferenceFeeFor: attendee )
				on: html ]
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> stringForBooleanForASymbol: aSymbol [
	(attendee perform: aSymbol) ifTrue: [ ^ 'Yes' ] ifFalse: [ ^ 'No' ] 
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> stringOfDays [
	|result listOfDays|
	listOfDays := attendee attendance.
	result := ''.
	listOfDays keys do: [ :each | (listOfDays at: each) ifTrue: [ result := result , ' ',  each capitalized  ] ].
	^ result 
]

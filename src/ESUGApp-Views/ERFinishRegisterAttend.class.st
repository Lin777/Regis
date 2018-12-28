Class {
	#name : #ERFinishRegisterAttend,
	#superclass : #ERPageView,
	#category : #'ESUGApp-Views'
}

{ #category : #testing }
ERFinishRegisterAttend class >> canBeRoot [
	^ true
]

{ #category : #initialization }
ERFinishRegisterAttend class >> initialize [

    (WAAdmin register: self asApplicationAt: 'FinishRegisterAttend')
        addLibrary: JQDeploymentLibrary;
        addLibrary: MDLLibrary;
        addLibrary: ERMaterialBlueRedMinCss;
        addLibrary: CssForLoginMDL;
        addLibrary: ERJQValidateForm;
        addLibrary: ERLibrary;
        preferenceAt: #sessionClass put: ERSession
]

{ #category : #'as yet unclassified' }
ERFinishRegisterAttend >> actionsBody: html [
]

{ #category : #'as yet unclassified' }
ERFinishRegisterAttend >> colorIcon [
	^ 'mdl-color--green'
]

{ #category : #initialization }
ERFinishRegisterAttend >> initialize [
	super initialize.
	title := 'Registration Summary'.
	icon := 'done'.
	id := 'finishRegisterAttend'.
	classContainer := 'mdl-card-register'.
	attendee := (ERAttendee find: [:each | each email = 'cusi@gmail.com'])
]

{ #category : #rendering }
ERFinishRegisterAttend >> renderActions: html [
	html mdlCardActions class: 'mdl-card--border';
	with: [ 
		html anchor url: 'AttendeeNormalTabs.html';
		class: 'mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect';
		with: 'Back'.
		html anchor url: 'FinishRegisterAttend2.html';
		class: 'mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect';
		with: 'Next'.
		html anchor class: 'mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect';
		with: 'Cancel'.
		html anchor url: 'FinishRegisterAttend2.html';
		class: 'mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect';
		with: 'Finish'.	
	]
]

{ #category : #rendering }
ERFinishRegisterAttend >> renderAffiliation: html [
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
ERFinishRegisterAttend >> renderBody: html with: aBlock [
	html mdlLayout with: aBlock
]

{ #category : #rendering }
ERFinishRegisterAttend >> renderContactInformation: html [
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
ERFinishRegisterAttend >> renderPageOn: html [
	html mdlGrid class: 'mdl-grid--no-spacing';
	with: [ 
		self renderContactInformation: html.
		self renderAffiliation: html.
		self renderPaymentInformation: html.
		self renderActions: html.
	]
]

{ #category : #rendering }
ERFinishRegisterAttend >> renderPaymentInformation: html [
	html mdlCell class: 'mdl-cell--4-col';
	with: [ 
	self renderTitle: html with: 'Payment Information'.
	self createTextStrongWithoutParagraph:'Payment Type: ' with: #paymentType on: html.
	self createTextStrongWithoutParagraph:'Payment Currency: ' with: #paymentCurrency on: html.
	self createTextStrongWithoutParagraph:'Conference Fee: ' withText: '666.00' on: html.
	]
]

{ #category : #rendering }
ERFinishRegisterAttend >> renderStrong: html with: aString1 and: aString2 [
	html strong: aString1.
	aString2 ifNotNil: [ 
		html text: aString2.
		html break 	
	]
]

{ #category : #rendering }
ERFinishRegisterAttend >> renderTitle: html with: aString [
	html heading level6 with: [
		self renderStrong: html with: aString and: nil.
	].
	html horizontalRule.
]

{ #category : #rendering }
ERFinishRegisterAttend >> stringForBooleanForASymbol: aSymbol [
	(attendee perform: aSymbol) ifTrue: [ ^ 'Yes' ] ifFalse: [ ^ 'No' ] 
]

{ #category : #rendering }
ERFinishRegisterAttend >> stringOfDays [
	|result listOfDays|
	listOfDays := attendee attendance.
	result := ''.
	listOfDays keys do: [ :each | (listOfDays at: each) ifTrue: [ result := result , ' ',  each capitalized  ] ].
	^ result 
]

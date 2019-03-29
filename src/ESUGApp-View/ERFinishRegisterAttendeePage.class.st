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
ERFinishRegisterAttendeePage >> finishRegister [
	attendee paymentInformation paymentTypeIsBankTransfer
		ifTrue: [ ^ self registerAndShowFinishViewForBankTransfer ].
	attendee paymentInformation paymentTypeIsCreditCard
		ifTrue: [ ^ self registerAndRedirectionPayPAL ].
	ERException paymentInvalid signal
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> registerAndRedirectionPayPAL [
	| url |
	pageController saveAttendee.
	url := pageController payPalUrlForGroup: attendee.
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
ERFinishRegisterAttendeePage >> renderAddPersonToSocialDinnerOn: html [
	html strong: 'Add person to Social Dinner: '.
			html text: (self stringForBoolean: 
				attendee conferenceInformation addPersonToSocialDinner).
	html break.
	
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderAddToMainListOn: html [
	html strong: 'Add mailling list: '.
			html text: (self stringForBoolean: 
				attendee conferenceInformation addedToMainList).
	html break.
	
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderAdditionalTextOn: html [
	html strong: 'Additional Text: '.
			html text: (attendee additionalInformation additionalText).
	html break.
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderAddress2On: html [
	html strong: 'Address 2: '.
			html text: (attendee contactInformation address2).
	html break.
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderAddressOn: html [
	html strong: 'Address: '.
			html text: (attendee contactInformation address).
	html break.
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderAffiliation: html [
	html mdlCell class: 'mdl-cell--4-col';
	with: [ 
	self renderTitle: html with: 'Affiliation'.
	self renderNameOrgOn: html.
	self renderAddressOrgOn: html.
	self renderAddress2OrgOn: html.
	self renderCityOrgOn: html.
	self renderProvinceOrgOn: html.
	self renderPostalOrgOn: html.
	self renderCountryOrgOn: html.
	self renderMemberShipTypeOn: html.
	self renderTitle: html with: 'Additional Information'.
	self renderAdditionalTextOn: html.
	self renderKeywordsOn: html.
	]
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderAttendeeToSocialEventOn: html [
	html strong: 'Goes Social Event: '.
			html text: (self stringForBoolean: 
				attendee conferenceInformation attendSocialEvent).
	html break.
	
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderCityOn: html [
	html strong: 'City: '.
			html text: (attendee contactInformation city).
	html break.
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderConferenceFeeOn: html [
	html strong: 'Conference Fee: '.
			html text:  
				(attendee paymentInformation paymentAmount).
	html break.
				
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderContactInformation: html [
	html mdlCell
		class: 'mdl-cell--4-col';
		with: [ self renderTitle: html with: 'Contact Information'.
			self renderFirstNameOn: html.
			self renderLastNameOn: html.
			self renderEmailOn: html.
			self renderFacebookUrlOn: html.
			self renderTwitterUrlOn: html.
			self renderHomePageUrlOn: html.
			self renderAddressOn: html.
			self renderAddress2On: html.
			self renderCityOn: html.
			self renderProvinceOn: html.
			self renderPostalOn: html.
			self renderCountryOn: html.
			self renderTitle: html with: 'Conference Options'.
			self renderDaysOfAssistanceOn: html.
			self renderGenderOn: html.
			self renderTShirtSizeOn: html.
			self renderFoodPreferenceOn: html.
			self renderAttendeeToSocialEventOn: html.
			self renderAddPersonToSocialDinnerOn: html.
			self renderAddToMainListOn: html.
			html break ]
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderCountryOn: html [
	html strong: 'Country '.
			html text: (attendee contactInformation country).
	html break.
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderDaysOfAssistanceOn: html [
	html strong: 'Day(s) to attend: '.
			html text: (attendee conferenceInformation daysOfAssistance).
	html break.
	
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderFacebookUrlOn: html [
	html strong: 'Facebook URL: '.
			html text: (attendee contactInformation facebookURL).
	html break.
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderFoodPreferenceOn: html [
	html strong: 'Type Food:  '.
			html text: (attendee conferenceInformation foodPreference).
	html break.
	
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderGenderOn: html [
	html strong: 'Gender: '.
			html text: (attendee conferenceInformation gender).
	html break.
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderHomePageUrlOn: html [
	html strong: 'Home Page: '.
			html text: (attendee contactInformation homePageURL).
	html break.
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderKeywordsOn: html [
	html strong: 'keywords: '.
			html text: (attendee additionalInformation keywords).
	html break.
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderPageOn: html [
	html mdlGrid noSpacing;
	with: [ 
		self renderContactInformation: html.
		self renderAffiliation: html.
		self renderPaymentInformation: html.
		self renderActions: html.
	]
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderPaymentCurrencyOn: html [
	html strong: 'Payment Currency: '.
			html text:  
				attendee paymentInformation paymentCurrency.
	html break.
				
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderPaymentInformation: html [
	html mdlCell
		class: 'mdl-cell--4-col';
		with: [ self renderTitle: html with: 'Payment Information'.
			self renderPaymentTypeOn: html.
			self renderPaymentCurrencyOn: html.
			self renderConferenceFeeOn: html]
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderPaymentTypeOn: html [
	html strong: 'Payment Type: '.
			html text:  
				attendee paymentInformation paymentType.
	html break.
				
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderPostalOn: html [
	html strong: 'Postal: '.
			html text: (attendee contactInformation postal).
	html break.
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderPostalOrgOn: html [
	html strong: 'Postal/Zip Code: '.
			html text: 
				attendee affiliationInformation organizationPostal.
	html break.
	
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderProvinceOn: html [
	html strong: 'Province: '.
			html text: (attendee contactInformation province).
	html break.
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderProvinceOrgOn: html [
	html strong: 'Province/States: '.
			html text: 
				attendee affiliationInformation organizationProvince.
	html break.
	
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderTShirtSizeOn: html [
	html strong: 'TShirt: '.
			html text: (attendee conferenceInformation tshirtSize).
	html break.
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderTwitterUrlOn: html [
	html strong: 'Twitter URL: '.
			html text: (attendee contactInformation twitterURL).
	html break.
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> stringForBoolean: aBoolean [
	aBoolean ifTrue: [ ^ 'Yes' ] ifFalse: [ ^ 'No' ] 
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

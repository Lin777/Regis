"
Description
--------------------

I am an Summary Page for register attendee
"
Class {
	#name : #ERFinishRegisterAttendeePage,
	#superclass : #ERFinishRegisterPage,
	#category : #'ESUGApp-View-Page'
}

{ #category : #rendering }
ERFinishRegisterAttendeePage >> content: anObject [
	content := anObject
]

{ #category : #actions }
ERFinishRegisterAttendeePage >> downloadInvoice [
	self requestContext respond: [ :response |
		|stream file |
		file := ERPDFInvoice pdfDocOf: attendee.
		stream := (RWBinaryOrTextStream on: String new) binary.
		file exportTo: stream.
		response
            contentType: (WAMimeType main: 'application' sub: 'pdf');
            document: stream close; contents ;
            attachmentWithFileName: ('invoice-', attendee id asString, '.pdf') ]
]

{ #category : #actions }
ERFinishRegisterAttendeePage >> okAction [
	self redirectLoggedPage: attendee userAccount
	
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderActions: html [
	html mdlCardActions
		class: 'mdl-card--border';
		with: [ 
			html mdlAnchorButton
				colored;
				id: 'okButton';
				callback: [ self okAction ];
				with: 'Ok'.
		
			html mdlAnchorButton
				colored;
				id: 'next';
				callback:  [ self downloadInvoice ];
				with: 'Get Invoice'. ]
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
ERFinishRegisterAttendeePage >> renderAdditionalInfo: html [
	html mdlCell 
		class: 'mdl-cell--4-col';
		with: [
			self renderTitle: html with: 'Additional Information'.
			self renderAdditionalTextOn: html.
			self renderKeywordsOn: html.
			html break ]
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderAdditionalTextOn: html [
	html strong: 'Additional Text: '.
			html text: (attendee additionalInformation additionalText).
	html break.
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderAttendeeToSocialEventOn: html [
	html strong: 'Goes Social Event: '.
			html text: (self stringForBoolean: 
				attendee conferenceInformation attendSocialEvent).
	html break.
	
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderConferenceInformation: html [
	html mdlCell
		class: 'mdl-cell--4-col';
		with: [ 
			self renderTitle: html with: 'Conference Options'.
			self renderDaysOfAssistanceOn: html.
			self renderGenderOn: html.
			self renderTShirtSizeOn: html.
			self renderFoodPreferenceOn: html.
			self renderAttendeeToSocialEventOn: html.
			self renderAddPersonToSocialDinnerOn: html.
			self renderAddToMainListOn: html ]
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderContactInformation: html [
	"Render contact information of an attendee"

	html mdlCell
		class: 'mdl-cell--4-col';
		with: [ 
			self renderTitle: html with: 'Contact Information'.
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
			self renderCountryOn: html ]
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderDaysOfAssistanceOn: html [
	html strong: 'Day(s) to attend: '.
			html text: (attendee conferenceInformation daysOfAssistance).
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
		self renderConferenceInformation: html.
		self renderAffiliation: html.
		self renderAdditionalInfo: html.
		self renderPaymentInformation: html.
		self renderActions: html ]
]

{ #category : #rendering }
ERFinishRegisterAttendeePage >> renderTShirtSizeOn: html [
	html strong: 'TShirt: '.
			html text: (attendee conferenceInformation tshirtSize).
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
	^ attendee conferenceInformation daysOfAssistance
]

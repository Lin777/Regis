"
Description
--------------------

I am an abstract page for finish register page(Summary page of register)
"
Class {
	#name : #ERFinishRegisterPage,
	#superclass : #ERPage,
	#category : #'ESUGApp-View-Page'
}

{ #category : #'as yet unclassified' }
ERFinishRegisterPage class >> on: anAttendee withContent: content withController: aController [
	^ self new
		attendee: anAttendee;
		content: content;
		pageController: aController.
		
]

{ #category : #accessing }
ERFinishRegisterPage >> colorIcon [
	^ 'mdl-color--green'
]

{ #category : #accessing }
ERFinishRegisterPage >> content: anObject [
	content := anObject
]

{ #category : #initialization }
ERFinishRegisterPage >> initialize [
	super initialize.
	title := 'Registration Summary'.
	icon := 'done'.
	id := 'login-conatiner'.
	classContainer := 'mdl-card-register'
]

{ #category : #actions }
ERFinishRegisterPage >> redirectLoggedPage: anUser [
	anUser
		ifNotNil: [ self session login: anUser.
			self call: ERLoggedPage new].
	self answer: true

]

{ #category : #rendering }
ERFinishRegisterPage >> renderActions: html [
	self subclassResponsibility  
	
]

{ #category : #accessing }
ERFinishRegisterPage >> renderAddress2On: html [

	html strong: 'Address 2: '.
			html text: (attendee contactInformation address2).
	html break.
]

{ #category : #rendering }
ERFinishRegisterPage >> renderAddress2OrgOn: html [
	html strong: 'Address Line 2: '.
			html text: 
				attendee affiliationInformation organizationAddrees2.
	html break.
	
]

{ #category : #accessing }
ERFinishRegisterPage >> renderAddressOn: html [

	html strong: 'Address: '.
			html text: (attendee contactInformation address).
	html break.
]

{ #category : #rendering }
ERFinishRegisterPage >> renderAddressOrgOn: html [
	html strong: 'Address Line 1: '.
			html text: 
				attendee affiliationInformation organizationAddrees1.
	html break.
	
]

{ #category : #rendering }
ERFinishRegisterPage >> renderAffiliation: html [
		html mdlCell 
		class: 'mdl-cell--4-col';
		with: [ 
			self renderTitle: html with: 'Affiliation'.
			self renderNameOrgOn: html.
			self renderAddressOrgOn: html.
			self renderAddress2OrgOn: html.
			self renderCityOrgOn: html.
			self renderProvinceOrgOn: html.
			self renderPostalOrgOn: html.
			self renderCountryOrgOn: html.
			self renderMemberShipTypeOn: html ]
]

{ #category : #rendering }
ERFinishRegisterPage >> renderBody: html with: aBlock [
	html div
		style: self styleBackgound ;
		with: [ html break.
			html break.
			aBlock value ]
]

{ #category : #accessing }
ERFinishRegisterPage >> renderCityOn: html [
	html strong: 'City: '.
	html text: (attendee contactInformation city).
	html break.
]

{ #category : #rendering }
ERFinishRegisterPage >> renderCityOrgOn: html [
	html strong: 'City: '.
			html text: 
				attendee affiliationInformation organizationCity.
	html break.
	
]

{ #category : #rendering }
ERFinishRegisterPage >> renderConferenceFeeOn: html [
	html strong: 'Conference Fee: '.
			html text:  
				(attendee paymentInformation paymentAmount).
	html break
]

{ #category : #rendering }
ERFinishRegisterPage >> renderContactInformation: html [
	"Render contact information of an user or group"

	self subclassResponsibility.
]

{ #category : #accessing }
ERFinishRegisterPage >> renderCountryOn: html [ 
	html strong: 'Country '.
	html text: (attendee contactInformation country).
	html break.
]

{ #category : #rendering }
ERFinishRegisterPage >> renderCountryOrgOn: html [
	html strong: 'Country: '.
			html text: 
				attendee affiliationInformation organizationCountry.
	html break.
	
]

{ #category : #rendering }
ERFinishRegisterPage >> renderEmailOn: html [
	html strong: 'Email: '.
			html text: (attendee userAccount email).
	html break.
]

{ #category : #rendering }
ERFinishRegisterPage >> renderFacebookUrlOn: html [

	html strong: 'Facebook URL: '.
			html text: (attendee contactInformation facebookURL).
	html break
]

{ #category : #rendering }
ERFinishRegisterPage >> renderFirstNameOn: html [
	html strong: 'First Name: '.
			html text: (attendee userAccount firstName).
	html break.
]

{ #category : #rendering }
ERFinishRegisterPage >> renderHomePageUrlOn: html [
	html strong: 'Home Page: '.
			html text: (attendee contactInformation homePageURL).
	html break.
]

{ #category : #rendering }
ERFinishRegisterPage >> renderLastNameOn: html [
	html strong: 'Last Name: '.
			html text: (attendee userAccount lastName).
	html break.
]

{ #category : #rendering }
ERFinishRegisterPage >> renderMemberShipTypeOn: html [
	html strong: 'MemberShip Type: '.
			html text:  
				attendee affiliationInformation membershipType.
	html break.
	
]

{ #category : #rendering }
ERFinishRegisterPage >> renderNameOrgOn: html [
	html strong: 'Organization Name: '.
			html text:  
				attendee affiliationInformation organizationName.
	html break.
	
]

{ #category : #rendering }
ERFinishRegisterPage >> renderPageOn: html [
	"Render page to finish register page"

	self subclassResponsibility 
]

{ #category : #rendering }
ERFinishRegisterPage >> renderPaymentCurrencyOn: html [
	html strong: 'Payment Currency: '.
			html text:  
				attendee paymentInformation paymentCurrency.
	html break
]

{ #category : #rendering }
ERFinishRegisterPage >> renderPaymentInformation: html [
	"Render payment information of registered user or group"

	html mdlCell
		class: 'mdl-cell--4-col';
		with: [ 
			self renderTitle: html with: 'Payment Information'.
			self renderPaymentTypeOn: html.
			self renderPaymentCurrencyOn: html.
			self renderConferenceFeeOn: html.
			html break ]
]

{ #category : #rendering }
ERFinishRegisterPage >> renderPaymentTypeOn: html [
	html strong: 'Payment Type: '.
			html text:  
				attendee paymentInformation paymentType.
	html break
]

{ #category : #rendering }
ERFinishRegisterPage >> renderPostalOn: html [
	html strong: 'Postal: '.
			html text: (attendee contactInformation postal).
	html break.
]

{ #category : #rendering }
ERFinishRegisterPage >> renderPostalOrgOn: html [
	html strong: 'Postal/Zip Code: '.
			html text: 
				attendee affiliationInformation organizationPostal.
	html break.
	
]

{ #category : #rendering }
ERFinishRegisterPage >> renderProvinceOn: html [
	html strong: 'Province: '.
			html text: (attendee contactInformation province).
	html break.
]

{ #category : #rendering }
ERFinishRegisterPage >> renderProvinceOrgOn: html [
	html strong: 'Province/States: '.
			html text: 
				attendee affiliationInformation organizationProvince.
	html break.
	
]

{ #category : #rendering }
ERFinishRegisterPage >> renderStrong: html with: aString1 and: aString2 [
	html strong: aString1.
	aString2
		ifNotNil: [ html text: aString2.
			html break ]
]

{ #category : #rendering }
ERFinishRegisterPage >> renderTitle: html with: aString [
	html heading level6
		with: [ self renderStrong: html with: aString and: nil ].
	html horizontalRule
]

{ #category : #rendering }
ERFinishRegisterPage >> renderTwitterUrlOn: html [
	html strong: 'Twitter URL: '.
			html text: (attendee contactInformation twitterURL).
	html break.
]

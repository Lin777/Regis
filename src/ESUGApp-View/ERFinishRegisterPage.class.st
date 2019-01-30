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

{ #category : #rendering }
ERFinishRegisterPage >> backAction [
	self subclassResponsibility
]

{ #category : #rendering }
ERFinishRegisterPage >> cancelAction [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
ERFinishRegisterPage >> colorIcon [
	^ 'mdl-color--green'
]

{ #category : #accessing }
ERFinishRegisterPage >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERFinishRegisterPage >> finishAction [
	self finishRegister 
]

{ #category : #rendering }
ERFinishRegisterPage >> finishRegister [
	self subclassResponsibility 
]

{ #category : #initialization }
ERFinishRegisterPage >> initialize [
	super initialize.
	title := 'Registration Summary'.
	icon := 'done'.
	id := 'login-conatiner'.
	classContainer := 'mdl-card-register'
]

{ #category : #rendering }
ERFinishRegisterPage >> nextAction [
	self finishRegister
]

{ #category : #'as yet unclassified' }
ERFinishRegisterPage >> redirectLoggedPage: anUser [
	anUser
		ifNotNil: [ self session login: anUser.
			self call: ERLoggedPage new].
	self answer: true

]

{ #category : #'tools registry' }
ERFinishRegisterPage >> register [
	| user |
	user := pageController save.
	self validateRegister: user
]

{ #category : #rendering }
ERFinishRegisterPage >> registerAsGroupManager [
	| user |
	user := pageController saveAsGroupManager.
	self validateRegister: user
]

{ #category : #rendering }
ERFinishRegisterPage >> renderActions: html [
	html mdlCardActions
		class: 'mdl-card--border';
		with: [ self
				createColoredAnchorButton: 'Back'
				with: [ self backAction ]
				id: 'back'
				on: html.
			self
				createColoredAnchorButton: 'Next'
				with: [ self nextAction ]
				id: 'next'
				on: html.
			self
				createColoredAnchorButton: 'Cancel'
				with: [ self cancelAction ]
				id: 'cancel'
				on: html.
			self
				createColoredAnchorButton: 'Finish'
				with: [ self finishAction ]
				id: 'finish'
				on: html ]
]

{ #category : #rendering }
ERFinishRegisterPage >> renderAddress2OrgOn: html [
	html strong: 'Address Line 2: '.
			html text: 
				attendee affiliationInformation organizationAddrees2.
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
		with: [ self renderTitle: html with: 'Affiliation'.
	self renderNameOrgOn: html.
	self renderAddressOrgOn: html.
	self renderAddress2OrgOn: html.
	self renderCityOrgOn: html].
	html mdlCell
		class: 'mdl-cell--4-col';
		with: [ html break.
			html break. html break.
			html horizontalRule.
	self renderProvinceOrgOn: html.
	self renderPostalOrgOn: html.
	self renderCountryOrgOn: html.
	self renderMemberShipTypeOn: html.
	html break]
]

{ #category : #rendering }
ERFinishRegisterPage >> renderCityOrgOn: html [
	html strong: 'City: '.
			html text: 
				attendee affiliationInformation organizationCity.
	html break.
	
]

{ #category : #rendering }
ERFinishRegisterPage >> renderContactInformation: html [
	html mdlCell
		class: 'mdl-cell--4-col';
		with: [ self renderTitle: html with: 'Contact Information'.
			self renderFirstNameOn: html.
			self renderLastNameOn: html.
			self renderEmailOn: html.
			html break]
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
ERFinishRegisterPage >> renderFirstNameOn: html [
	html strong: 'First Name: '.
			html text: (attendee userAccount firstName).
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
	self subclassResponsibility 
]

{ #category : #rendering }
ERFinishRegisterPage >> renderPostalOrgOn: html [
	html strong: 'Postal/Zip Code: '.
			html text: 
				attendee affiliationInformation organizationPostal.
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

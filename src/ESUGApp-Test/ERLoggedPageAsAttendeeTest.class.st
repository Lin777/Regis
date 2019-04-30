"
Description
--------------------

A ERLoggedPageAsAttendeeTest is a test class for testing the behavior of page when the user sign in as Attendee
"
Class {
	#name : #ERLoggedPageAsAttendeeTest,
	#superclass : #ERParasolTest,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Test-Parasol'
}

{ #category : #myRegistrationProposedAwardsTests }
ERLoggedPageAsAttendeeTest >> fillAllFieldsOfAward [
	self selectElementWithID: 'nameAward' send: 'Award'.
	self selectElementWithID: 'otherDevelopers' send: 'Devs'.
	self selectElementWithID: 'smalltalkDialect' send: 'French' .
	self selectElementWithID: 'affiliation' send: 'Inria'.
	self selectElementWithID: 'downloadUrl' send: 'https://drive.google.com/accounts' .
	self selectElementWithID: 'demoUrl' send: 'https://drive.google.com/accounts'.
	self selectElementWithID: 'licence' send: 'Pharo'.
	self selectElementWithID: 'keywords' send: 'MIT'.
]

{ #category : #adminChangePasswordTests }
ERLoggedPageAsAttendeeTest >> fillAllFieldsOfChangePassword [
	self selectElementWithID: 'currentPassword' send: '12345678'.
	self selectElementWithID: 'password' send: '123456789'.
	self selectElementWithID: 'confirmPassword' send: '123456789'
]

{ #category : #myRegistrationProposedTalksTest }
ERLoggedPageAsAttendeeTest >> fillAllFieldsOfTalk [
	self selectElementWithID: 'name' send: 'Talk Example'.
	self selectElementWithID: 'description' send: 'This is a talk to ....'.
	self selectElementWithID: 'authorsWithoutSubmitter' send: 'Example Dev'.
	self selectElementWithID: 'presentation' send: 'https://www.google.com/' 
]

{ #category : #actions }
ERLoggedPageAsAttendeeTest >> loginAsAttendee [
	self selectElementWithID: 'email-login' send: attendee userAccount email.
	self selectElementWithID: 'password-login' send: '12345678'.
	self clickElementWithID: 'login-button'
]

{ #category : #tests }
ERLoggedPageAsAttendeeTest >> pressOptionMyRegistration [
	self clickElementWithID: 'My Registration-option'
]

{ #category : #myRegistrationSummaryTests }
ERLoggedPageAsAttendeeTest >> redirectByTypeOfPayment [
	attendee paymentInformation paymentTypeIsBankTransfer 
		ifTrue: [ self assert: (self textOfTagName: 'h3') equals: 'Bank Transfer' ]
		ifFalse: [ "This test takes a lot time"
			"(Delay forSeconds: 10) wait.
			self assert: (driver getCurrentURL beginsWith: 'https://www.paypal.com')" ]
]

{ #category : #tests }
ERLoggedPageAsAttendeeTest >> selectChangePasswordTab [
	self clickElementWithID: 'changePassword'
]

{ #category : #tests }
ERLoggedPageAsAttendeeTest >> selectProposedAwardsTab [
	self clickElementWithID: 'tab-Proposed Awards'
]

{ #category : #tests }
ERLoggedPageAsAttendeeTest >> selectProposedTalksTab [
	self clickElementWithID: 'tab-Proposed Talks'
]

{ #category : #accessing }
ERLoggedPageAsAttendeeTest >> setUp [
	super setUp.
	ERTest generateDataForTest .
	controller := ERConfigurationController new.
	attendee := controller conference attends first.
	self loginAsAttendee .
	
]

{ #category : #myRegistrationProposedAwardsTests }
ERLoggedPageAsAttendeeTest >> testAddAwardWithEmptyAffiliation [
	
	self pressOptionMyRegistration.
	self selectProposedAwardsTab .
	self clickElementWithID: 'addAward'.
	self fillAllFieldsOfAward.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'affiliation' with: ''.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Affiliation')
]

{ #category : #myRegistrationProposedAwardsTests }
ERLoggedPageAsAttendeeTest >> testAddAwardWithEmptyDownloadURL [
	
	self pressOptionMyRegistration.
	self selectProposedAwardsTab .
	self clickElementWithID: 'addAward'.
	self fillAllFieldsOfAward.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'downloadUrl' with: ''.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Download Url')
]

{ #category : #myRegistrationProposedAwardsTests }
ERLoggedPageAsAttendeeTest >> testAddAwardWithEmptyName [
	
	self pressOptionMyRegistration.
	self selectProposedAwardsTab .
	self clickElementWithID: 'addAward'.
	self fillAllFieldsOfAward.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'nameAward' with: ''.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Name')
]

{ #category : #myRegistrationProposedTalksTest }
ERLoggedPageAsAttendeeTest >> testAddTalkCorrectly [
	
	self pressOptionMyRegistration.
	self selectProposedTalksTab .
	self clickElementWithID: 'addTalk'.
	self fillAllFieldsOfTalk.
	self clickElementWithID: 'accept-change-affiliation'.
	self deny: (ERTalk find: [ :talk | talk name = 'Talk Example' ] ) = nil
]

{ #category : #myRegistrationProposedTalksTest }
ERLoggedPageAsAttendeeTest >> testAddTalkWithEmptyDescription [
	
	self pressOptionMyRegistration.
	self selectProposedTalksTab .
	self clickElementWithID: 'addTalk'.
	self fillAllFieldsOfTalk.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'description' with: ''.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Description')
]

{ #category : #myRegistrationProposedTalksTest }
ERLoggedPageAsAttendeeTest >> testAddTalkWithEmptyName [
	
	self pressOptionMyRegistration.
	self selectProposedTalksTab .
	self clickElementWithID: 'addTalk'.
	self fillAllFieldsOfTalk.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'name' with: ''.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Name')
]

{ #category : #adminUserTests }
ERLoggedPageAsAttendeeTest >> testEditUserObtainAnErrorAndAfterCancelEdition [
	|emailAfterUpdate|
	self pressOptionAdmin  .
	acceptFormButton := 'accept-user'.
	"Update that generate an error"
	self updateField: 'email' with: 'mike@gmail.com'.
	"Cancel update"
	self clickElementWithID: 'cancel-user'.
	emailAfterUpdate := ERUserAccount find: [ :each | each id = attendee userAccount id ].
	self deny: emailAfterUpdate email = 'mike@gmail.com'.
]

{ #category : #adminUserTests }
ERLoggedPageAsAttendeeTest >> testEditUserWithAlreadyEmailRegistered [
	self pressOptionAdmin  .
	acceptFormButton := 'accept-user'.
	self updateField: 'email' with: 'mike@gmail.com'.
	self assert: (self textOfElementWithID: 'adminAlert') equals: 'This email is already registered'
]

{ #category : #adminUserTests }
ERLoggedPageAsAttendeeTest >> testEditUserWithEmptyEmail [
	self pressOptionAdmin  .
	acceptFormButton := 'accept-user'.
	self updateField: 'email' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'Email')
]

{ #category : #adminUserTests }
ERLoggedPageAsAttendeeTest >> testEditUserWithEmptyFirstName [
	self pressOptionAdmin  .
	acceptFormButton := 'accept-user'.
	self updateField: 'firstName' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'First Name')
]

{ #category : #adminUserTests }
ERLoggedPageAsAttendeeTest >> testEditUserWithEmptyLastName [
	self pressOptionAdmin  .
	acceptFormButton := 'accept-user'.
	self updateField: 'lastName' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'Last Name')
]

{ #category : #adminUserTests }
ERLoggedPageAsAttendeeTest >> testEditUserWithInvalidFormatOfEmail [
	self pressOptionAdmin  .
	acceptFormButton := 'accept-user'.
	self updateField: 'email' with: 'evelyn@.com'.
	self assert: self getTextOfError 
		equals: 'Email (Required): Please enter a valid email'
]

{ #category : #myRegistrationSummaryTests }
ERLoggedPageAsAttendeeTest >> testModifyRegistrationOfSummary [
	self pressOptionMyRegistration.
	self clickElementWithID: 'modifyRegistration'.
	self shouldnt: [driver findElementByID: 'tab-Contact'] raise: BPNoSuchElementException 
]

{ #category : #myRegistrationProposedAwardsTests }
ERLoggedPageAsAttendeeTest >> testPressAddAward [
	self pressOptionMyRegistration.
	self selectProposedAwardsTab .
	self clickElementWithID: 'addAward'.
	self assert: (self textOfTagName: 'h3') equals: 'Award'.
	
]

{ #category : #myRegistrationProposedTalksTest }
ERLoggedPageAsAttendeeTest >> testPressAddTalk [
	self pressOptionMyRegistration.
	self selectProposedTalksTab .
	self clickElementWithID: 'addTalk'.
	self assert: (self textOfTagName: 'h3') equals: 'Talk'.
	
]

{ #category : #adminUserTests }
ERLoggedPageAsAttendeeTest >> testPressAdminOption [
	self pressOptionAdmin .
	self assert: (driver findElementByTagName: 'h3') getText equals: 'Edit profile'.
]

{ #category : #myRegistrationProposedAwardsTests }
ERLoggedPageAsAttendeeTest >> testPressAwardsTab [
	self pressOptionMyRegistration.
	self selectProposedAwardsTab .
	self assert: (self textOfElementWithID: 'tab-proposedAwards' andTagName: 'h3') equals: 'Submitted Awards'.
	
]

{ #category : #adminChangePasswordTests }
ERLoggedPageAsAttendeeTest >> testPressChangePasswordTab [
	self pressOptionAdmin .
	self selectChangePasswordTab .
	self assert: (driver findElementByTagName: 'h3')  getText
		equals: 'Modify Password'
]

{ #category : #myRegistrationSummaryTests }
ERLoggedPageAsAttendeeTest >> testPressExportInvoiceButtonOfSummary [
	|href|
	self createDownloadDirectory .
	self pressOptionMyRegistration.
	href := (driver findElementByID: 'exportInvoice') getAttribute: 'href'.
	self downloadFileOf: href to: ( 'Download' asFileReference ) / 'invoice.pdf'
]

{ #category : #myRegistrationSummaryTests }
ERLoggedPageAsAttendeeTest >> testPressMyRegistrationOption [
	self pressOptionMyRegistration.
	self assert: (self textOfTagName:'h3') equals: 'Registration Summary'.
	self shouldnt: [driver findElementByID: 'modifyRegistration'] raise: BPNoSuchElementException .
	self shouldnt: [driver findElementByID: 'pay'] raise: BPNoSuchElementException .
	self shouldnt: [driver findElementByID: 'exportInvoice'] raise: BPNoSuchElementException .
]

{ #category : #myRegistrationSummaryTests }
ERLoggedPageAsAttendeeTest >> testPressPayButtonOfSummary [
	"self pressOptionMyRegistration.
	(driver findElementByID: 'pay') click.
	self redirectByTypeOfPayment.
	attendee paymentInformation swapPaymentType.
	attendee := controller updateAttendee: attendee.
	driver goBack.
	(driver findElementByID: 'pay') click.
	self redirectByTypeOfPayment."
]

{ #category : #myRegistrationProposedTalksTest }
ERLoggedPageAsAttendeeTest >> testPressTalksTab [
	self pressOptionMyRegistration.
	self selectProposedTalksTab .
	self assert: (self textOfElementWithID: 'tab-proposedTalks' andTagName: 'h3') equals: 'Submitted Talks'.
	
]

{ #category : #adminChangePasswordTests }
ERLoggedPageAsAttendeeTest >> testUpdatePasswordWithANewPasswordLessThanEightCharacters [
	self pressOptionAdmin .
	self selectChangePasswordTab .
	self fillAllFieldsOfChangePassword .
	acceptFormButton := 'accept-change-password'.
	self updateField: 'password' with: '1234'.
	self shouldnt: [ driver findElementByClassName: 'is-invalid' ] raise: BPNoSuchElementException.
]

{ #category : #adminChangePasswordTests }
ERLoggedPageAsAttendeeTest >> testUpdatePasswordWithAllFieldsCorrectly [
	|newAttendee|
	self pressOptionAdmin .
	self selectChangePasswordTab .
	self fillAllFieldsOfChangePassword .
	self clickElementWithID: 'accept-change-password'.
	newAttendee := ERUserAccount find: [ :each | each id = attendee userAccount id ].
	self assert: newAttendee password equals: (ERUserAccount hashPassword: '123456789') .
]

{ #category : #adminChangePasswordTests }
ERLoggedPageAsAttendeeTest >> testUpdatePasswordWithIncorrectConfirmPassword [
	self pressOptionAdmin .
	self selectChangePasswordTab .
	self fillAllFieldsOfChangePassword .
	acceptFormButton := 'accept-change-password'.
	self updateField: 'confirmPassword' with: '123456789111'.
	self shouldnt: [ driver findElementByClassName: 'is-invalid' ] raise: BPNoSuchElementException.
]

{ #category : #adminChangePasswordTests }
ERLoggedPageAsAttendeeTest >> testUpdatePasswordWithIncorrectCurrentPassword [
	self pressOptionAdmin .
	self selectChangePasswordTab .
	self fillAllFieldsOfChangePassword .
	acceptFormButton := 'accept-change-password'.
	self updateField: 'currentPassword' with: '123456789'.
	self assert: (self textOfElementWithID: 'changePasswordAlert') equals: 'The password entered does not match the current password'
]

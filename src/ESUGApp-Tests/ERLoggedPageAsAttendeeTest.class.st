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
	#category : #'ESUGApp-Tests-Parasol'
}

{ #category : #actions }
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

{ #category : #actions }
ERLoggedPageAsAttendeeTest >> fillAllFieldsOfChangePassword [
	self selectElementWithID: 'currentPassword' send: '12345678'.
	self selectElementWithID: 'password' send: '123456789'.
	self selectElementWithID: 'confirmPassword' send: '123456789'
]

{ #category : #actions }
ERLoggedPageAsAttendeeTest >> fillAllFieldsOfTalk [
	self selectElementWithID: 'title' send: 'Talk Example'.
	self selectElementWithID: 'description' send: 'This is a talk to ....'.
	self selectElementWithID: 'bio' send: 'This is a bio to ....'.
	self selectElementWithID: 'authorsWithoutSubmitter' send: 'Example Dev'.
	self selectElementWithID: 'presentation' send: 'https://www.google.com/' 
]

{ #category : #actions }
ERLoggedPageAsAttendeeTest >> loginAsAttendee [
	self selectElementWithID: 'email-login' send: attendee userAccount email.
	self selectElementWithID: 'password-login' send: '12345678'.
	self clickElementWithID: 'login-button'
]

{ #category : #actions }
ERLoggedPageAsAttendeeTest >> pressOptionMyRegistration [
	self clickElementWithID: 'My Registration-option'
]

{ #category : #actions }
ERLoggedPageAsAttendeeTest >> redirectByTypeOfPayment [
	attendee paymentInformation paymentTypeIsBankTransfer 
		ifTrue: [ self assert: (self textOfTagName: 'h3') equals: 'Bank Transfer' ]
		ifFalse: [ "This test takes a lot time"
			"(Delay forSeconds: 10) wait.
			self assert: (driver getCurrentURL beginsWith: 'https://www.paypal.com')" ]
]

{ #category : #actions }
ERLoggedPageAsAttendeeTest >> selectChangePasswordTab [
	self clickElementWithID: 'changePassword'
]

{ #category : #actions }
ERLoggedPageAsAttendeeTest >> selectProposedAwardsTab [
	self clickElementWithID: 'tab-Proposed Awards'
]

{ #category : #actions }
ERLoggedPageAsAttendeeTest >> selectProposedTalksTab [
	self clickElementWithID: 'tab-Proposed Talks'
]

{ #category : #running }
ERLoggedPageAsAttendeeTest >> setUp [

	super setUp.
	ERTest generateDataForTest.
	controller := ERConfigurationController new.
	attendee := controller conference attends first.
	self loginAsAttendee.
]

{ #category : #'my Registration ProposedAwards Tests' }
ERLoggedPageAsAttendeeTest >> testAddAwardWithEmptyAffiliation [
	
	self pressOptionMyRegistration.
	self selectProposedAwardsTab .
	self clickElementWithID: 'addAward'.
	self fillAllFieldsOfAward.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'affiliation' with: ''.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Affiliation')
]

{ #category : #'my Registration ProposedAwards Tests' }
ERLoggedPageAsAttendeeTest >> testAddAwardWithEmptyDownloadURL [
	
	self pressOptionMyRegistration.
	self selectProposedAwardsTab .
	self clickElementWithID: 'addAward'.
	self fillAllFieldsOfAward.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'downloadUrl' with: ''.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Download Url')
]

{ #category : #'my Registration ProposedAwards Tests' }
ERLoggedPageAsAttendeeTest >> testAddAwardWithEmptyName [
	
	self pressOptionMyRegistration.
	self selectProposedAwardsTab .
	self clickElementWithID: 'addAward'.
	self fillAllFieldsOfAward.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'nameAward' with: ''.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Name')
]

{ #category : #'my Registration Proposed Talks Test' }
ERLoggedPageAsAttendeeTest >> testAddTalkCorrectly [
	
	self pressOptionMyRegistration.
	self selectProposedTalksTab .
	self clickElementWithID: 'addTalk'.
	self fillAllFieldsOfTalk.
	self clickElementWithID: 'accept-change-affiliation'.
	self deny: (ERTalk find: [ :talk | talk title = 'Talk Example' ] ) = nil
]

{ #category : #'my Registration Proposed Talks Test' }
ERLoggedPageAsAttendeeTest >> testAddTalkWithEmptyBio [
	
	self pressOptionMyRegistration.
	self selectProposedTalksTab .
	self clickElementWithID: 'addTalk'.
	self fillAllFieldsOfTalk.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'bio' with: ''.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Bio')
]

{ #category : #'my Registration Proposed Talks Test' }
ERLoggedPageAsAttendeeTest >> testAddTalkWithEmptyDescription [
	
	self pressOptionMyRegistration.
	self selectProposedTalksTab .
	self clickElementWithID: 'addTalk'.
	self fillAllFieldsOfTalk.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'description' with: ''.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Abstract')
]

{ #category : #'my Registration Proposed Talks Test' }
ERLoggedPageAsAttendeeTest >> testAddTalkWithEmptyTitle [
	
	self pressOptionMyRegistration.
	self selectProposedTalksTab .
	self clickElementWithID: 'addTalk'.
	self fillAllFieldsOfTalk.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'title' with: ''.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Title')
]

{ #category : #'admin User Tests' }
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

{ #category : #'admin User Tests' }
ERLoggedPageAsAttendeeTest >> testEditUserWithAlreadyEmailRegistered [
	self pressOptionAdmin  .
	acceptFormButton := 'accept-user'.
	self updateField: 'email' with: 'mike@gmail.com'.
	self assert: (self textOfElementWithID: 'adminAlert') equals: 'This email is already registered'
]

{ #category : #'admin User Tests' }
ERLoggedPageAsAttendeeTest >> testEditUserWithEmptyEmail [
	self pressOptionAdmin  .
	acceptFormButton := 'accept-user'.
	self updateField: 'email' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'Email')
]

{ #category : #'admin User Tests' }
ERLoggedPageAsAttendeeTest >> testEditUserWithEmptyFirstName [
	self pressOptionAdmin  .
	acceptFormButton := 'accept-user'.
	self updateField: 'firstName' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'First Name')
]

{ #category : #'admin User Tests' }
ERLoggedPageAsAttendeeTest >> testEditUserWithEmptyLastName [
	self pressOptionAdmin  .
	acceptFormButton := 'accept-user'.
	self updateField: 'lastName' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'Last Name')
]

{ #category : #'admin User Tests' }
ERLoggedPageAsAttendeeTest >> testEditUserWithInvalidFormatOfEmail [
	self pressOptionAdmin  .
	acceptFormButton := 'accept-user'.
	self updateField: 'email' with: 'evelyn@.com'.
	self assert: self getTextOfError 
		equals: 'Email (Required): Please enter a valid email'
]

{ #category : #'my Registration Summary Tests' }
ERLoggedPageAsAttendeeTest >> testModifyRegistrationOfSummary [
	self pressOptionMyRegistration.
	self clickElementWithID: 'modifyRegistration'.
	self shouldnt: [driver findElementByID: 'tab-Contact'] raise: BPNoSuchElementException 
]

{ #category : #'my Registration ProposedAwards Tests' }
ERLoggedPageAsAttendeeTest >> testPressAddAward [
	self pressOptionMyRegistration.
	self selectProposedAwardsTab .
	self clickElementWithID: 'addAward'.
	self assert: (self textOfTagName: 'h3') equals: 'Award'.
	
]

{ #category : #'my Registration Proposed Talks Test' }
ERLoggedPageAsAttendeeTest >> testPressAddTalk [
	self pressOptionMyRegistration.
	self selectProposedTalksTab .
	self clickElementWithID: 'addTalk'.
	self assert: (self textOfTagName: 'h3') equals: 'Talk'.
	
]

{ #category : #'admin User Tests' }
ERLoggedPageAsAttendeeTest >> testPressAdminOption [
	self pressOptionAdmin .
	self assert: (driver findElementByTagName: 'h3') getText equals: 'Edit profile'.
]

{ #category : #'my Registration ProposedAwards Tests' }
ERLoggedPageAsAttendeeTest >> testPressAwardsTab [
	self pressOptionMyRegistration.
	self selectProposedAwardsTab .
	self assert: (self textOfElementWithID: 'tab-proposedAwards' andTagName: 'h3') equals: 'Submitted Awards'.
	
]

{ #category : #'admin Change Password Tests' }
ERLoggedPageAsAttendeeTest >> testPressChangePasswordTab [
	self pressOptionAdmin .
	self selectChangePasswordTab .
	self assert: (driver findElementByTagName: 'h3')  getText
		equals: 'Modify Password'
]

{ #category : #'my Registration Summary Tests' }
ERLoggedPageAsAttendeeTest >> testPressExportInvoiceButtonOfSummary [
	|href|
	self createDownloadDirectory .
	self pressOptionMyRegistration.
	href := (driver findElementByID: 'exportInvoice') getAttribute: 'href'.
	self downloadFileOf: href to: ( 'Download' asFileReference ) / 'invoice.pdf'
]

{ #category : #'my Registration Summary Tests' }
ERLoggedPageAsAttendeeTest >> testPressMyRegistrationOption [
	self pressOptionMyRegistration.
	self assert: (self textOfTagName:'h3') equals: 'Registration Summary'.
	self shouldnt: [driver findElementByID: 'modifyRegistration'] raise: BPNoSuchElementException .
	self shouldnt: [driver findElementByID: 'pay'] raise: BPNoSuchElementException .
	self shouldnt: [driver findElementByID: 'exportInvoice'] raise: BPNoSuchElementException .
]

{ #category : #'my Registration Summary Tests' }
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

{ #category : #'my Registration Proposed Talks Test' }
ERLoggedPageAsAttendeeTest >> testPressTalksTab [
	self pressOptionMyRegistration.
	self selectProposedTalksTab .
	self assert: (self textOfElementWithID: 'tab-proposedTalks' andTagName: 'h3') equals: 'Submitted Talks'.
	
]

{ #category : #'admin Change Password Tests' }
ERLoggedPageAsAttendeeTest >> testUpdatePasswordWithANewPasswordLessThanEightCharacters [
	self pressOptionAdmin .
	self selectChangePasswordTab .
	self fillAllFieldsOfChangePassword .
	acceptFormButton := 'accept-change-password'.
	self updateField: 'password' with: '1234'.
	self shouldnt: [ driver findElementByClassName: 'is-invalid' ] raise: BPNoSuchElementException.
]

{ #category : #'admin Change Password Tests' }
ERLoggedPageAsAttendeeTest >> testUpdatePasswordWithAllFieldsCorrectly [
	|newAttendee|
	self pressOptionAdmin .
	self selectChangePasswordTab .
	self fillAllFieldsOfChangePassword .
	self clickElementWithID: 'accept-change-password'.
	newAttendee := ERUserAccount find: [ :each | each id = attendee userAccount id ].
	self assert: newAttendee password equals: (ERUserAccount hashPassword: '123456789') .
]

{ #category : #'admin Change Password Tests' }
ERLoggedPageAsAttendeeTest >> testUpdatePasswordWithIncorrectConfirmPassword [
	self pressOptionAdmin .
	self selectChangePasswordTab .
	self fillAllFieldsOfChangePassword .
	acceptFormButton := 'accept-change-password'.
	self updateField: 'confirmPassword' with: '123456789111'.
	self shouldnt: [ driver findElementByClassName: 'is-invalid' ] raise: BPNoSuchElementException.
]

{ #category : #'admin Change Password Tests' }
ERLoggedPageAsAttendeeTest >> testUpdatePasswordWithIncorrectCurrentPassword [
	self pressOptionAdmin .
	self selectChangePasswordTab .
	self fillAllFieldsOfChangePassword .
	acceptFormButton := 'accept-change-password'.
	self updateField: 'currentPassword' with: '123456789'.
	self assert: (self textOfElementWithID: 'changePasswordAlert') equals: 'The password entered does not match the current password'
]

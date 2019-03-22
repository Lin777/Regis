Class {
	#name : #ERLoggedPageAsAttendeeTest,
	#superclass : #ERParasolTest,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Test-Parasol'
}

{ #category : #adminChangePasswordTests }
ERLoggedPageAsAttendeeTest >> currentPassword: aString1 password: aString2 confirmPassword: aString3 [ 
	|currentPassword password confirmPassword|
	currentPassword := driver findElementByID: 'currentPassword'.
	password := driver findElementByID: 'password'.
	confirmPassword := driver findElementByID: 'confirmPassword'.
	currentPassword sendKeys: aString1 .
	password sendKeys: aString2.
	confirmPassword sendKeys: aString3.
]

{ #category : #myRegistrationProposedAwardsTests }
ERLoggedPageAsAttendeeTest >> fillAllFieldsOfAward [
	self nameAward: 'Award' otherDevelopers: 'Devs' smalltalkDialect: 'French' affiliation: 'Inria' downloadUrl: 'https://drive.google.com/accounts' demoUrl: 'https://drive.google.com/accounts' keywords: 'Pharo' licence: 'MIT'
]

{ #category : #adminChangePasswordTests }
ERLoggedPageAsAttendeeTest >> fillAllFieldsOfChangePassword [
	self currentPassword: '12345678' password: '123456789' confirmPassword: '123456789'
]

{ #category : #myRegistrationProposedTalksTest }
ERLoggedPageAsAttendeeTest >> fillAllFieldsOfTalk [
	self name: 'Talk Example' description: 'This is a talk to ....' authorsWithoutSubmitter: 'Example Dev' 
]

{ #category : #'as yet unclassified' }
ERLoggedPageAsAttendeeTest >> loginAsAttendee [
	|email password signIn|
	email := driver findElementByID: 'email-login'.
	password := driver findElementByID: 'password-login'.
	signIn := driver findElementByID: 'login-button'.
	email sendKeys: attendee userAccount email.
	password sendKeys: '12345678'.
	signIn click.
]

{ #category : #myRegistrationProposedTalksTest }
ERLoggedPageAsAttendeeTest >> name: aString1 description: aString2 authorsWithoutSubmitter: aString3 [ 
	|firstName lastName email|
	firstName := driver findElementByID: 'name'.
	lastName := driver findElementByID: 'description'.
	email := driver findElementByID: 'authorsWithoutSubmitter'.
	firstName sendKeys: aString1 .
	lastName sendKeys: aString2.
	email sendKeys: aString3.
]

{ #category : #myRegistrationProposedAwardsTests }
ERLoggedPageAsAttendeeTest >> nameAward: aString1 otherDevelopers: aString2 smalltalkDialect: aString3 affiliation: aString4 downloadUrl: aString5 demoUrl: aString6 keywords: aString7 licence: aString8 [
	|nameAward otherDevelopers smalltalkDialect affiliation downloadUrl demoUrl keywords licence|
	nameAward := driver findElementByID: 'nameAward'.
	otherDevelopers := driver findElementByID: 'otherDevelopers'.
	smalltalkDialect := driver findElementByID: 'smalltalkDialect'.
	affiliation := driver findElementByID: 'affiliation'.
	downloadUrl := driver findElementByID: 'downloadUrl'.
	demoUrl := driver findElementByID: 'demoUrl'.
	licence := driver findElementByID: 'licence'.
	keywords := driver findElementByID: 'keywords'.
	nameAward sendKeys: aString1 .
	otherDevelopers sendKeys: aString2.
	smalltalkDialect sendKeys: aString3.
	affiliation sendKeys: aString4.
	downloadUrl sendKeys: aString5.
	demoUrl sendKeys: aString6.
	keywords sendKeys: aString7.
	licence sendKeys: aString8 
]

{ #category : #tests }
ERLoggedPageAsAttendeeTest >> pressOptionAdmin [
	(driver findElementByID: 'Admin-option') click.
]

{ #category : #tests }
ERLoggedPageAsAttendeeTest >> pressOptionMyRegistration [
	(driver findElementByID: 'My Registration-option') click.
]

{ #category : #myRegistrationSummaryTests }
ERLoggedPageAsAttendeeTest >> redirectByTypeOfPayment [
	attendee paymentInformation paymentTypeIsBankTransfer 
		ifTrue: [ self assert: (driver findElementByTagName: 'h3') getText equals: 'Bank Transfer' ]
		ifFalse: [ "This test takes a lot time"
			"(Delay forSeconds: 10) wait.
			self assert: (driver getCurrentURL beginsWith: 'https://www.paypal.com')" ]
]

{ #category : #tests }
ERLoggedPageAsAttendeeTest >> selectChangePasswordTab [
	(driver findElementByID: 'tab-Change Password') click.
]

{ #category : #tests }
ERLoggedPageAsAttendeeTest >> selectProposedAwardsTab [
	(driver findElementByID: 'tab-Proposed Awards') click.
]

{ #category : #tests }
ERLoggedPageAsAttendeeTest >> selectProposedTalksTab [
	(driver findElementByID: 'tab-Proposed Talks') click.
]

{ #category : #accessing }
ERLoggedPageAsAttendeeTest >> setUp [
	super setUp.
	ERTest generateDataForTest .
	controller := ERConfigurationController new.
	attendee := controller attends first.
	self loginAsAttendee .
	
]

{ #category : #myRegistrationProposedAwardsTests }
ERLoggedPageAsAttendeeTest >> testAddAwardWithEmptyAffiliation [
	
	self pressOptionMyRegistration.
	self selectProposedAwardsTab .
	(driver findElementByID: 'addAward')click.
	self fillAllFieldsOfAward.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'affiliation' with: ''.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Affiliation')
]

{ #category : #myRegistrationProposedAwardsTests }
ERLoggedPageAsAttendeeTest >> testAddAwardWithEmptyDownloadURL [
	
	self pressOptionMyRegistration.
	self selectProposedAwardsTab .
	(driver findElementByID: 'addAward')click.
	self fillAllFieldsOfAward.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'downloadUrl' with: ''.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Download Url')
]

{ #category : #myRegistrationProposedAwardsTests }
ERLoggedPageAsAttendeeTest >> testAddAwardWithEmptyName [
	
	self pressOptionMyRegistration.
	self selectProposedAwardsTab .
	(driver findElementByID: 'addAward')click.
	self fillAllFieldsOfAward.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'nameAward' with: ''.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Name')
]

{ #category : #myRegistrationProposedTalksTest }
ERLoggedPageAsAttendeeTest >> testAddTalkCorrectly [
	
	self pressOptionMyRegistration.
	self selectProposedTalksTab .
	(driver findElementByID: 'addTalk')click.
	self fillAllFieldsOfTalk.
	(driver findElementByID: 'accept-change-affiliation')click.
	self deny: (ERTalk find: [ :talk | talk name = 'Talk Example' ] ) = nil
]

{ #category : #myRegistrationProposedTalksTest }
ERLoggedPageAsAttendeeTest >> testAddTalkWithEmptyDescription [
	
	self pressOptionMyRegistration.
	self selectProposedTalksTab .
	(driver findElementByID: 'addTalk')click.
	self fillAllFieldsOfTalk.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'description' with: ''.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Description')
]

{ #category : #myRegistrationProposedTalksTest }
ERLoggedPageAsAttendeeTest >> testAddTalkWithEmptyName [
	
	self pressOptionMyRegistration.
	self selectProposedTalksTab .
	(driver findElementByID: 'addTalk')click.
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
	(driver findElementByID: 'cancel-user')	 click.
	emailAfterUpdate := ERUserAccount find: [ :each | each id = attendee userAccount id ].
	self deny: emailAfterUpdate email = 'mike@gmail.com'.
]

{ #category : #adminUserTests }
ERLoggedPageAsAttendeeTest >> testEditUserWithAlreadyEmailRegistered [
	self pressOptionAdmin  .
	acceptFormButton := 'accept-user'.
	self updateField: 'email' with: 'mike@gmail.com'.
	self assert: (driver findElementByID: 'adminUserAlert') getText equals: 'This email is already registered'
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

{ #category : #adminUserTests }
ERLoggedPageAsAttendeeTest >> testEditUserWithNoValidFirstName [
	self pressOptionAdmin  .
	acceptFormButton := 'accept-user'.
	self updateField: 'firstName' with: 'Evelyn123'.
	self assert: self getTextOfError 
		equals: (self messageOnlyTextIsAcceptedFor: 'First Name')
]

{ #category : #adminUserTests }
ERLoggedPageAsAttendeeTest >> testEditUserWithNoValidLastName [
	self pressOptionAdmin  .
	acceptFormButton := 'accept-user'.
	self updateField: 'lastName' with: 'Evelyn123'.
	self assert: self getTextOfError 
		equals: (self messageOnlyTextIsAcceptedFor: 'Last Name')
]

{ #category : #myRegistrationSummaryTests }
ERLoggedPageAsAttendeeTest >> testModifyRegistrationOfSummary [
	self pressOptionMyRegistration.
	(driver findElementByID: 'modifyRegistration') click.
	self shouldnt: [driver findElementByID: 'tab-Contact'] raise: BPNoSuchElementException 
]

{ #category : #myRegistrationProposedAwardsTests }
ERLoggedPageAsAttendeeTest >> testPressAddAward [
	self pressOptionMyRegistration.
	self selectProposedAwardsTab .
	(driver findElementByID: 'addAward')click.
	self assert: (driver findElementByTagName: 'h3') getText equals: 'Award'.
	
]

{ #category : #myRegistrationProposedTalksTest }
ERLoggedPageAsAttendeeTest >> testPressAddTalk [
	self pressOptionMyRegistration.
	self selectProposedTalksTab .
	(driver findElementByID: 'addTalk')click.
	self assert: (driver findElementByTagName: 'h3') getText equals: 'Talk'.
	
]

{ #category : #adminUserTests }
ERLoggedPageAsAttendeeTest >> testPressAdminOption [
	self pressOptionAdmin .
	self assert: ((driver findElementByID: 'tab-adminUser')findElementByTagName: 'h3') getText equals: 'User'.
	
]

{ #category : #myRegistrationProposedAwardsTests }
ERLoggedPageAsAttendeeTest >> testPressAwardsTab [
	self pressOptionMyRegistration.
	self selectProposedAwardsTab .
	self assert: ((driver findElementByID: 'tab-proposedAwards')findElementByTagName: 'h3') getText equals: 'Submitted Awards'.
	
]

{ #category : #adminChangePasswordTests }
ERLoggedPageAsAttendeeTest >> testPressChangePasswordTab [
	self pressOptionAdmin .
	self selectChangePasswordTab .
	self assert: ((driver findElementByID: 'tab-changePassword') findElementByTagName: 'h3') getText 
		equals: 'Modify Password'
]

{ #category : #myRegistrationSummaryTests }
ERLoggedPageAsAttendeeTest >> testPressExportInvoiceButtonOfSummary [
	|href|
	self createDownloadDirectory .
	self pressOptionMyRegistration.
	href := (driver findElementByID: 'exportInvoice') getAttribute: 'href'.
	self downloadFileOf: href to: Smalltalk imageDirectory / 'Download' / 'invoice.pdf'
]

{ #category : #myRegistrationSummaryTests }
ERLoggedPageAsAttendeeTest >> testPressMyRegistrationOption [
	self pressOptionMyRegistration.
	self assert: (driver findElementByTagName: 'h3') getText equals: 'Registration Summary'.
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
	self assert: ((driver findElementByID: 'tab-proposedTalks')findElementByTagName: 'h3') getText equals: 'Submitted Talks'.
	
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
	(driver findElementByID: 'accept-change-password') click.
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
	self assert: (driver findElementByID: 'adminChangePasswordAlert') getText equals: 'The password entered does not match the current password'
]

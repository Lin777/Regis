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
	self nameAward: 'Award' otherDevelopers: 'Devs' smalltalkDialect: 'French' affiliation: 'Inria' downloadUrl: 'https://drive.google.com/accounts' demoUrl: 'https://drive.google.com/accounts' keywords: 'Pharo' licence: 'MIT'
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
	self deny: (ERTalk find: [ :talk | talk name = 'Talk Example' ] ) equals: nil
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

{ #category : #myRegistrationProposedAwardsTests }
ERLoggedPageAsAttendeeTest >> testPressAwardsTab [
	self pressOptionMyRegistration.
	self selectProposedAwardsTab .
	self assert: ((driver findElementByID: 'tab-proposedAwards')findElementByTagName: 'h3') getText equals: 'Submitted Awards'.
	
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
	self pressOptionMyRegistration.
	(driver findElementByID: 'pay') click.
	"(Delay forSeconds: 10) wait."
	self redirectByTypeOfPayment.
	attendee paymentInformation swapPaymentType.
	attendee := controller updateAttendee: attendee.
	driver goBack.
	(driver findElementByID: 'pay') click.
	self redirectByTypeOfPayment.
]

{ #category : #myRegistrationProposedTalksTest }
ERLoggedPageAsAttendeeTest >> testPressTalksTab [
	self pressOptionMyRegistration.
	self selectProposedTalksTab .
	self assert: ((driver findElementByID: 'tab-proposedTalks')findElementByTagName: 'h3') getText equals: 'Submitted Talks'.
	
]

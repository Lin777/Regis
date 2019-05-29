"
Description
--------------------

A ERLoggedPageAsGroupManagerTest is a test class for testing the behavior of page when the user sign in as GroupManager
"
Class {
	#name : #ERLoggedPageAsGroupManagerTest,
	#superclass : #ERParasolTest,
	#instVars : [
		'group'
	],
	#category : #'ESUGApp-Test-Parasol'
}

{ #category : #groupManagerMembersTabTests }
ERLoggedPageAsGroupManagerTest >> addGroupManagerAsAttendee [
	self clickElementWithID: 'contactInfoForm-nextButton'.
	self clickElementWithID: 'conferenceOptionsForm-nextButton'.
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self clickElementWithID: 'additionalInfoForm-nextButton'.
	self clickElementWithID: 'registerButton'.
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> fillAllUserFields [
	self selectElementWithID: 'firstName' send: 'register'.
	self selectElementWithID: 'lastName' send: 'register'.
	self selectElementWithID: 'email' send: 'register@gmail.com'.
	self selectElementWithID: 'passwordRegister' send: '12345678'.
	self selectElementWithID: 'confirmPasswordRegister' send: '12345678'
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> firstName: aString1 lastName: aString2 email: aString3 password: aString4 confirmPassword: aString5 [
	|firstName lastName email password confirmPassword|
	firstName := driver findElementByID: 'firstName'.
	lastName := driver findElementByID: 'lastName'.
	email := driver findElementByID: 'email'.
	password := driver findElementByID: 'password'.
	confirmPassword := driver findElementByID: 'confirmPassword'.
	firstName sendKeys: aString1 .
	lastName sendKeys: aString2.
	email sendKeys: aString3.
	password sendKeys: aString4.
	confirmPassword sendKeys: aString5.
]

{ #category : #actions }
ERLoggedPageAsGroupManagerTest >> loginAsGroupManager [
	self selectElementWithID: 'email-login' send: group groupManager userAccount email.
	self selectElementWithID: 'password-login' send: '12345678'.
	self clickElementWithID:'login-button'
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> pressNextButtonAdditional [
	self pressNextButtonAffiliation .
	self clickElementWithID: 'additionalInfoForm-nextButton'
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> pressNextButtonAffiliation [ 
	self pressNextButtonConference .
	self clickElementWithID: 'affiliationInfoForm-nextButton'
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> pressNextButtonConference [
	self pressNextButtonContact .
	self clickElementWithID: 'conferenceOptionsForm-nextButton'
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> pressNextButtonContact [
	self pressNextButtonUser.
	self clickElementWithID: 'contactInfoForm-nextButton'
	
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> pressNextButtonPayment [
	self pressNextButtonAdditional.
	self clickElementWithID:  'registerButton'
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> pressNextButtonUser [
	self fillAllUserFields.
	self clickElementWithID: 'basicInfoForm-nextButton'
]

{ #category : #actions }
ERLoggedPageAsGroupManagerTest >> pressOptionGroupRegistration [
	self clickElementWithID: 'Group Registration-option'
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> setUp [
	super setUp.
	ERTest generateDataForTest .
	controller := ERGroupManagerController new.
	group := controller conference groups first.
	self loginAsGroupManager .
]

{ #category : #groupManagerSumaryTests }
ERLoggedPageAsGroupManagerTest >> testModifyBillingInfoOfSummary [
	self pressOptionGroupRegistration.
	self clickElementWithID: 'modifyAffiliation'.
	self assert: (self textOfTagName: 'h3') equals: 'Billing Information'
]

{ #category : #groupManagerMembersTabTests }
ERLoggedPageAsGroupManagerTest >> testPressDeleteAttendeeAcceptAlert [
	|attendee cantOfAttendees|
	attendee := group listAttends first.
	self pressOptionGroupRegistration .
	cantOfAttendees := group listAttends size.
	self clickElementWithID: attendee id, '-delete'.
	driver acceptAlert .
	(Delay forSeconds: 2) wait.
	self assert: group listAttends size equals: cantOfAttendees - 1
	
]

{ #category : #groupManagerMembersTabTests }
ERLoggedPageAsGroupManagerTest >> testPressDeleteAttendeeDismissAlert [
	|attendee cantOfAttendees|
	attendee := group listAttends first.
	self pressOptionGroupRegistration .
	cantOfAttendees := group listAttends size.
	self clickElementWithID: attendee id, '-delete'.
	driver dismissAlert .
	(Delay forSeconds: 2) wait.
	self assert: group listAttends size equals: cantOfAttendees
	
]

{ #category : #groupManagerMembersTabTests }
ERLoggedPageAsGroupManagerTest >> testPressDeleteGroupManagerAttendeeAcceptAlert [
	|attendee cantOfAttendees|
	self pressOptionGroupRegistration .
	cantOfAttendees := group listAttends size.
	self clickElementWithID: 'registerMyselfAsAttendee'.
	self addGroupManagerAsAttendee.
	attendee := group listAttends detect: [:att | att userAccount id = group groupManager userAccount id].
	self pressOptionGroupRegistration .
	cantOfAttendees := group listAttends size.
	self clickElementWithID: attendee id, '-delete'.
	driver acceptAlert .
	(Delay forSeconds: 2) wait.
	self assert: group listAttends size equals: cantOfAttendees - 1.
	self deny:
	 (ERUserAccount detect: [:user | user id = group groupManager userAccount id])= nil
	
]

{ #category : #groupManagerSumaryTests }
ERLoggedPageAsGroupManagerTest >> testPressExportInvoiceButtonOfSummary [
	|href|
	self createDownloadDirectory .
	self pressOptionGroupRegistration .
	href := (driver findElementByID: 'exportInvoice') getAttribute: 'href'.
	self downloadFileOf: href to: ( 'Download' asFileReference ) /'invoice.pdf'
]

{ #category : #groupManagerSumaryTests }
ERLoggedPageAsGroupManagerTest >> testPressGroupManagerOption [
	self pressOptionGroupRegistration.
	self assert: (self textOfTagName: 'h3') equals: 'Group Registration'.
	self shouldnt: [driver findElementByID: 'modifyAffiliation'] raise: BPNoSuchElementException .
	self shouldnt: [driver findElementByID: 'pay'] raise: BPNoSuchElementException .
	self shouldnt: [driver findElementByID: 'exportInvoice'] raise: BPNoSuchElementException .
]

{ #category : #groupManagerMembersTabTests }
ERLoggedPageAsGroupManagerTest >> testRegisterMyselfAsAttendee [
	|cantOfAttendees|
	self pressOptionGroupRegistration .
	cantOfAttendees := group listAttends size.
	self clickElementWithID: 'registerMyselfAsAttendee'.
	self addGroupManagerAsAttendee.
	self assert: group listAttends size equals: cantOfAttendees + 1.
	self assert: group groupManager userAccount isAttendee .
	self deny: (group listAttends detect: 
		[:att | att userAccount id = group groupManager userAccount id]) = nil
	
]

{ #category : #groupManagerMembersTabTests }
ERLoggedPageAsGroupManagerTest >> testRegisterNewAttendeeToGroup [
	|cantOfAttendees|
	self pressOptionGroupRegistration .
	cantOfAttendees := group listAttends size.
	self clickElementWithID: 'registerAttendee'.
	self pressNextButtonPayment.
	self assert: group listAttends size equals: cantOfAttendees + 1
	
]

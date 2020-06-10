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
	#category : #'ESUGApp-Tests-Parasol'
}

{ #category : #actions }
ERLoggedPageAsGroupManagerTest >> addGroupManagerAsAttendee [
	self clickElementWithID: 'conferenceOptionsForm-nextButton'.
	self clickElementWithID: 'registerButton'.
]

{ #category : #actions }
ERLoggedPageAsGroupManagerTest >> fillAllUserFieldsOfIndex: anIndex [
	self selectElementWithID: ('firstName', anIndex printString) send: 'register'.
	self selectElementWithID: ('lastName', anIndex printString) send: 'register'.
	self selectElementWithID: ('email', anIndex printString) send: 'register@gmail.com'.
	self selectElementWithID: ('passwordRegister', anIndex printString) send: '12345678'.
	self selectElementWithID: ('confirmPasswordRegister', anIndex printString) send: '12345678'
]

{ #category : #actions }
ERLoggedPageAsGroupManagerTest >> fillAllUserFieldsWithOtherEmailOnIndex: anIndex [
	self selectElementWithID: ('firstName', anIndex printString) send: 'register2'.
	self selectElementWithID: ('lastName', anIndex printString) send: 'register2'.
	self selectElementWithID: ('email', anIndex printString) send: 'register2@gmail.com'.
	self selectElementWithID: ('passwordRegister', anIndex printString) send: '12345678'.
	self selectElementWithID: ('confirmPasswordRegister', anIndex printString) send: '12345678'
]

{ #category : #actions }
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

{ #category : #actions }
ERLoggedPageAsGroupManagerTest >> pressNextButtonAdditionalWithIndex: anIndex [

	self clickElementWithID: 'additionalInfoForm', anIndex printString, '-nextButton'
]

{ #category : #actions }
ERLoggedPageAsGroupManagerTest >> pressNextButtonConferenceWithIndex: anIndex [
	self clickElementWithID: 'conferenceOptionsForm', anIndex printString, '-nextButton'
]

{ #category : #actions }
ERLoggedPageAsGroupManagerTest >> pressNextButtonContact [
	self pressNextButtonUser.
	self clickElementWithID: 'contactInfoForm-nextButton'
	
]

{ #category : #actions }
ERLoggedPageAsGroupManagerTest >> pressNextButtonPayment [
	self pressNextButtonAdditional.
	self clickElementWithID:  'registerButton'
]

{ #category : #actions }
ERLoggedPageAsGroupManagerTest >> pressNextButtonUserWithIndex: anIndex [

	self clickElementWithID: 'basicInfoForm', anIndex printString, '-nextButton'
]

{ #category : #actions }
ERLoggedPageAsGroupManagerTest >> pressOptionGroupRegistration [
	self clickElementWithID: 'Group Management-option'
]

{ #category : #running }
ERLoggedPageAsGroupManagerTest >> setUp [
	super setUp.
	ERTest generateDataForTest.
	controller := ERGroupController new.
	group := controller conference groups first.
	self loginAsGroupManager.
]

{ #category : #'group Manager Members Tab Tests' }
ERLoggedPageAsGroupManagerTest >> testAddingTwoMembersToRegisterInGroup [
	| text1 text2 |
	self pressOptionGroupRegistration.
	self clickElementWithID: 'newUserOptionBar'.
	self clickElementWithID: 'newUserOptionBar'.
	text1 := self textOfUserRegisterBarWithId: 'ui-id-1'.
	text2 := self textOfUserRegisterBarWithId: 'ui-id-2'.
	self assert: text1 equals: 'New user 1'.
	self assert: text2 equals: 'New user 2'
]

{ #category : #'group Manager Sumary Tests' }
ERLoggedPageAsGroupManagerTest >> testModifyGroupInfoOfSummary [
	self pressOptionGroupRegistration.
	self clickElementWithID: 'modifyAffiliation'.
	self assert: (self textOfElementWithID: 'tab-Contact') equals: 'CONTACT'.
	self assert: (self textOfElementWithID: 'tab-Billing Information') equals: 'BILLING INFORMATION'.
	self assert: (self textOfElementWithID: 'tab-Payment') equals: 'PAYMENT'
]

{ #category : #'group Manager Members Tab Tests' }
ERLoggedPageAsGroupManagerTest >> testPressDeleteAttendeeAcceptAlert [
	| attendee cantOfAttendees |
	attendee := group listAttends first.
	self pressOptionGroupRegistration .
	cantOfAttendees := group listAttends size.
	self clickElementWithID: attendee id, '-delete'.
	driver acceptAlert .
	(Delay forSeconds: 2) wait.
	self assert: group listAttends size equals: cantOfAttendees - 1
	
]

{ #category : #'group Manager Members Tab Tests' }
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

{ #category : #'group Manager Members Tab Tests' }
ERLoggedPageAsGroupManagerTest >> testPressDeleteGroupManagerAttendeeAcceptAlert [
	| attendee cantOfAttendees |
	self pressOptionGroupRegistration .
	cantOfAttendees := group listAttends size.
	self clickElementWithID: 'registerMyselfAsAttendee'.
	self addGroupManagerAsAttendee.
	attendee := group listAttends detect: [ :att | att userAccount id = group groupManager userAccount id ].
	self pressOptionGroupRegistration .
	cantOfAttendees := group listAttends size.
	self clickElementWithID: attendee id, '-delete'.
	driver acceptAlert .
	(Delay forSeconds: 2) wait.
	self assert: group listAttends size equals: cantOfAttendees - 1.
	self deny:
	 (ERUserAccount detect: [ :user | user id = group groupManager userAccount id ])= nil
]

{ #category : #'group Manager Sumary Tests' }
ERLoggedPageAsGroupManagerTest >> testPressExportInvoiceButtonOfSummary [
	| href |
	self createDownloadDirectory .
	self pressOptionGroupRegistration .
	href := (driver findElementByID: 'exportInvoice') getAttribute: 'href'.
	self downloadFileOf: href to: ( 'Download' asFileReference ) /'invoice.pdf'
]

{ #category : #'group Manager Sumary Tests' }
ERLoggedPageAsGroupManagerTest >> testPressGroupManagerOption [

	self pressOptionGroupRegistration.
	self assert: (self textOfTagName: 'h3') equals: 'Registration'.
	self shouldnt: [driver findElementByID: 'modifyAffiliation'] raise: BPNoSuchElementException.
	self shouldnt: [driver findElementByID: 'pay'] raise: BPNoSuchElementException .
	self shouldnt: [driver findElementByID: 'exportInvoice'] raise: BPNoSuchElementException .
]

{ #category : #'group Manager Members Tab Tests' }
ERLoggedPageAsGroupManagerTest >> testRegisterMyselfAsAttendee [
	| cantOfAttendees |
	self pressOptionGroupRegistration .
	cantOfAttendees := group listAttends size.
	self clickElementWithID: 'registerMyselfAsAttendee'.
	self addGroupManagerAsAttendee.
	self assert: group listAttends size equals: cantOfAttendees + 1.
	self assert: group groupManager userAccount isAttendee .
	self deny: (group listAttends detect: 
		[ :att | att userAccount id = group groupManager userAccount id ]) = nil
	
]

{ #category : #'group Manager Members Tab Tests' }
ERLoggedPageAsGroupManagerTest >> testRegisterTwoUsersInGroup [

	| cantOfAttendees |
	cantOfAttendees := group listAttends size.
	self pressOptionGroupRegistration.
	self clickElementWithID: 'newUserOptionBar'.
	self fillAllUserFieldsOfIndex: 1.
	self pressNextButtonUserWithIndex: 1.
	self pressNextButtonConferenceWithIndex: 1.
	self clickElementWithID: 'registerButton', 1 printString.
	self clickElementWithID: 'newUserOptionBar'.
	self fillAllUserFieldsWithOtherEmailOnIndex: 1.
	self pressNextButtonUserWithIndex: 1.
	self pressNextButtonConferenceWithIndex: 1.
	self clickElementWithID: 'registerButton', 1 printString.
	self assert: group listAttends size equals: cantOfAttendees + 2
]

{ #category : #'group Manager Members Tab Tests' }
ERLoggedPageAsGroupManagerTest >> testRegisterUserInGroup [

	| cantOfAttendees |
	cantOfAttendees := group listAttends size.
	self pressOptionGroupRegistration.
	self clickElementWithID: 'newUserOptionBar'.
	self fillAllUserFieldsOfIndex: 1.
	self pressNextButtonUserWithIndex: 1.
	self pressNextButtonConferenceWithIndex: 1.
	self clickElementWithID: 'registerButton', 1 printString.
	self assert: group listAttends size equals: cantOfAttendees + 1
]

{ #category : #'group Manager Members Tab Tests' }
ERLoggedPageAsGroupManagerTest >> testRemovingOneMemberInTheMiddleOfTwoMembersInGroup [

	| text1 text2 |
	self pressOptionGroupRegistration.
	self clickElementWithID: 'newUserOptionBar'.
	self clickElementWithID: 'newUserOptionBar'.
	self clickElementWithID: 'newUserOptionBar'.
	self clickElementWithID: 'ui-id-2'.
	self clickElementWithID: 'basicInfoForm2-removeRegister'.
	text1 := self textOfUserRegisterBarWithId: 'ui-id-1'.
	text2 := self textOfUserRegisterBarWithId: 'ui-id-2'.
	self assert: text1 equals: 'New user 1'.
	self assert: text2 equals: 'New user 2'.
	self should: [ driver findElementByID: 'ui-id-3' ] raise: BPNoSuchElementException.
]

{ #category : #'group Manager Members Tab Tests' }
ERLoggedPageAsGroupManagerTest >> testRemovingOneMemberOfRegisterInGroup [

	self pressOptionGroupRegistration.
	self clickElementWithID: 'newUserOptionBar'.
	self clickElementWithID: 'basicInfoForm1-removeRegister'.
	self should: [ driver findElementByID: 'ui-id-1' ] raise: BPNoSuchElementException.
]

{ #category : #actions }
ERLoggedPageAsGroupManagerTest >> textOfUserRegisterBarWithId: anId [ 
	| element |
	element := ((driver findElementByID: anId) findElementByClassName: 'option-text') getText.
	^ element
]

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
	(driver findElementByID: 'contactInfoForm-nextButton') click.
	(driver findElementByID: 'conferenceOptionsForm-nextButton') click.
	(driver findElementByID: 'affiliationInfoForm-nextButton')click.
	 (driver findElementByID: 'additionalInfoForm-nextButton') click.
	(driver findElementByID: 'paymentInformationForm-nextButton')click.
	(driver findElementByID: 'registerButton') click.
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> fillAllUserFields [
	self firstName: 'register' lastName: 'register' email: 'register@gmail.com' password: '12345678' confirmPassword: '12345678'.
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

{ #category : #'as yet unclassified' }
ERLoggedPageAsGroupManagerTest >> loginAsGroupManager [
	|email password signIn|
	email := driver findElementByID: 'email-login'.
	password := driver findElementByID: 'password-login'.
	signIn := driver findElementByID: 'login-button'.
	email sendKeys: group groupManager userAccount email.
	password sendKeys: '12345678'.
	signIn click.
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> pressDoneButton [
	self pressNextButtonPayment .
	(driver findElementByID: 'registerButton') click.
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> pressNextButtonAdditional [
	|next|
	self pressNextButtonAffiliation .
	next := driver findElementByID: 'additionalInfoForm-nextButton'.
	next click.
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> pressNextButtonAffiliation [ 
	|next|
	self pressNextButtonConference .
	next := driver findElementByID: 'affiliationInfoForm-nextButton'.
	next click.
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> pressNextButtonConference [
	|next|
	self pressNextButtonContact .
	next := driver findElementByID: 'conferenceOptionsForm-nextButton'.
	next click.
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> pressNextButtonContact [
	|next|
	self pressNextButtonUser.
	next := driver findElementByID: 'contactInfoForm-nextButton'.
	next click.
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> pressNextButtonPayment [
	|next|
	self pressNextButtonAdditional.
	next := driver findElementByID: 'paymentInformationForm-nextButton'.
	next click.
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> pressNextButtonUser [
	|next|
	self fillAllUserFields.
	next := driver findElementByID: 'basicInfoForm-nextButton'.
	next click.
]

{ #category : #'as yet unclassified' }
ERLoggedPageAsGroupManagerTest >> pressOptionGroupRegistration [
	(driver findElementByID: 'Group Registration-option') click.
]

{ #category : #'as yet unclassified' }
ERLoggedPageAsGroupManagerTest >> selectMembersTab [
	(driver findElementByID: 'tab-Members') click.
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
ERLoggedPageAsGroupManagerTest >> testModifyAffiliationOfSummary [
	self pressOptionGroupRegistration.
	(driver findElementByID: 'modifyAffiliation') click.
	self assert: (driver findElementByTagName: 'h3') getText equals: 'Affiliation Information'
]

{ #category : #groupManagerMembersTabTests }
ERLoggedPageAsGroupManagerTest >> testPressDeleteAttendeeAcceptAlert [
	|attendee cantOfAttendees|
	attendee := group listAttends first.
	self pressOptionGroupRegistration .
	self selectMembersTab.
	cantOfAttendees := group listAttends size.
	(driver findElementByID: attendee id, '-delete') click.
	driver acceptAlert .
	(Delay forSeconds: 2) wait.
	self assert: group listAttends size equals: cantOfAttendees - 1
	
]

{ #category : #groupManagerMembersTabTests }
ERLoggedPageAsGroupManagerTest >> testPressDeleteAttendeeDismissAlert [
	|attendee cantOfAttendees|
	attendee := group listAttends first.
	self pressOptionGroupRegistration .
	self selectMembersTab.
	cantOfAttendees := group listAttends size.
	(driver findElementByID: attendee id, '-delete') click.
	driver dismissAlert .
	(Delay forSeconds: 2) wait.
	self assert: group listAttends size equals: cantOfAttendees
	
]

{ #category : #groupManagerMembersTabTests }
ERLoggedPageAsGroupManagerTest >> testPressDeleteGroupManagerAttendeeAcceptAlert [
	|attendee cantOfAttendees|
	self pressOptionGroupRegistration .
	self selectMembersTab.
	cantOfAttendees := group listAttends size.
	(driver findElementByID: 'registerMyselfAsAttendee') click.
	self addGroupManagerAsAttendee.
	attendee := group listAttends detect: [:att | att userAccount id = group groupManager userAccount id].
	self pressOptionGroupRegistration .
	self selectMembersTab.
	cantOfAttendees := group listAttends size.
	(driver findElementByID: attendee id, '-delete') click.
	driver acceptAlert .
	(Delay forSeconds: 2) wait.
	self assert: group listAttends size equals: cantOfAttendees - 1.
	self deny:
	 (ERUserAccount detect: [:user | user id = group groupManager userAccount id])
	equals: nil
	
]

{ #category : #groupManagerSumaryTests }
ERLoggedPageAsGroupManagerTest >> testPressExportInvoiceButtonOfSummary [
	|href|
	self createDownloadDirectory .
	self pressOptionGroupRegistration .
	href := (driver findElementByID: 'exportInvoice') getAttribute: 'href'.
	self downloadFileOf: href to: Smalltalk imageDirectory / 'Download' / 'invoice.pdf'
]

{ #category : #groupManagerSumaryTests }
ERLoggedPageAsGroupManagerTest >> testPressGroupManagerOption [
	self pressOptionGroupRegistration.
	self assert: (driver findElementByTagName: 'h3') getText equals: 'Group Manager Short Description'.
	self shouldnt: [driver findElementByID: 'modifyAffiliation'] raise: BPNoSuchElementException .
	self shouldnt: [driver findElementByID: 'pay'] raise: BPNoSuchElementException .
	self shouldnt: [driver findElementByID: 'exportInvoice'] raise: BPNoSuchElementException .
]

{ #category : #groupManagerMembersTabTests }
ERLoggedPageAsGroupManagerTest >> testRegisterMyselfAsAttendee [
	|cantOfAttendees|
	self pressOptionGroupRegistration .
	self selectMembersTab.
	cantOfAttendees := group listAttends size.
	(driver findElementByID: 'registerMyselfAsAttendee') click.
	self addGroupManagerAsAttendee.
	self assert: group listAttends size equals: cantOfAttendees + 1.
	self assert: group groupManager userAccount isAttendee .
	self deny: (group listAttends detect: 
		[:att | att userAccount id = group groupManager userAccount id]) equals: nil
	
]

{ #category : #groupManagerMembersTabTests }
ERLoggedPageAsGroupManagerTest >> testRegisterNewAttendeeToGroup [
	|cantOfAttendees|
	self pressOptionGroupRegistration .
	self selectMembersTab .
	cantOfAttendees := group listAttends size.
	(driver findElementByID: 'registerAttendee') click.
	self pressDoneButton .
	self assert: group listAttends size equals: cantOfAttendees + 1
	
]

{ #category : #groupManagerSumaryTests }
ERLoggedPageAsGroupManagerTest >> testUpdateAffiliationWithEmptyOrganizationAddress [
	self pressOptionGroupRegistration .
	(driver findElementByID: 'modifyAffiliation') click.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'organizationAddrees1' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'Address 1')
]

{ #category : #groupManagerSumaryTests }
ERLoggedPageAsGroupManagerTest >> testUpdateAffiliationWithEmptyOrganizationCity [
	self pressOptionGroupRegistration .
	(driver findElementByID: 'modifyAffiliation') click.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'organizationCity' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'City')
]

{ #category : #groupManagerSumaryTests }
ERLoggedPageAsGroupManagerTest >> testUpdateAffiliationWithEmptyOrganizationName [
	self pressOptionGroupRegistration .
	(driver findElementByID: 'modifyAffiliation') click.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'organizationName' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'Organization Name')
]

{ #category : #groupManagerSumaryTests }
ERLoggedPageAsGroupManagerTest >> testUpdateAffiliationWithEmptyOrganizationPostal [
	self pressOptionGroupRegistration .
	(driver findElementByID: 'modifyAffiliation') click.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'organizationPostal' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'Postal/Zipcode')
]

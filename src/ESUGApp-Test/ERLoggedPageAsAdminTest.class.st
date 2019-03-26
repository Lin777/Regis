"
A ERLoggedPageAsAdminTest is a test class for testing the behavior of page when the user sign in as Admin
"
Class {
	#name : #ERLoggedPageAsAdminTest,
	#superclass : #ERParasolTest,
	#category : #'ESUGApp-Test-Parasol'
}

{ #category : #tests }
ERLoggedPageAsAdminTest >> getNameOfConference [
	^ controller conference configuration name 
]

{ #category : #'as yet unclassified' }
ERLoggedPageAsAdminTest >> loginAsAdmin [
	|email password signIn|
	email := driver findElementByID: 'email-login'.
	password := driver findElementByID: 'password-login'.
	signIn := driver findElementByID: 'login-button'.
	email sendKeys: 'admin@esug.org'.
	password sendKeys: '12345678'.
	signIn click.
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> messageInvalidInputFor: aString [
	^ aString, ' (Required): Invalid input given'
]

{ #category : #'as yet unclassified' }
ERLoggedPageAsAdminTest >> messageWrongDateFormatFor: aString [
	^ aString, ': This field only supports dates with the following format "MM/DD/YYYY"'
]

{ #category : #configurationAttendeesTest }
ERLoggedPageAsAdminTest >> moveToAttendeeOption [
	self pressOptionUsers .
	self selectAttendeesTab .
]

{ #category : #configurationProposalsTests }
ERLoggedPageAsAdminTest >> moveToAwardsOption [
	self pressOptionProposals  .
	self selectAwardsTab  .
]

{ #category : #configurationAdminOptionTests }
ERLoggedPageAsAdminTest >> moveToBackupTab [
	self pressOptionAdmin .
	self selectTabBackup . 
]

{ #category : #configurationAdminOptionTests }
ERLoggedPageAsAdminTest >> moveToChangePasswordTab [
	self pressOptionAdmin .
	self selectTabChangePassword 
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> moveToFeeOption [
	self pressOptionConfiguration .
	self selectFeeTab .
]

{ #category : #configurationGroupManagerTests }
ERLoggedPageAsAdminTest >> moveToGroupManagerOption [
	self pressOptionUsers .
	self selectGroupManagerTab  .
]

{ #category : #configurationInvoicesTests }
ERLoggedPageAsAdminTest >> moveToInvoicesOption [
	self pressOptionConfiguration .
	self selectInovicesTab .
]

{ #category : #configurationTicketTest }
ERLoggedPageAsAdminTest >> moveToTicketsOption [
	self pressOptionConfiguration .
	self selectTicketTab .
]

{ #category : #configurationGroupManagerTests }
ERLoggedPageAsAdminTest >> pressEditGroup [
	| group|
	group := controller conference groups first.
	self moveToGroupManagerOption .
	(driver findElementByID: group id, '-modify') click.
	
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> pressEditUser [
	| user|
	user := controller conference findUserByEmail: 'ana@gmail.com'.
	self pressOptionUsers.
	(driver findElementByID: user id, '-modify') click.
]

{ #category : #tests }
ERLoggedPageAsAdminTest >> pressOptionAdmin [
	(driver findElementByID: 'Admin-option') click.
]

{ #category : #tests }
ERLoggedPageAsAdminTest >> pressOptionConfiguration [
	(driver findElementByID: 'Configuration-option') click.
]

{ #category : #tests }
ERLoggedPageAsAdminTest >> pressOptionProposals [
	(driver findElementByID: 'Proposals-option') click.
]

{ #category : #tests }
ERLoggedPageAsAdminTest >> pressOptionStatistics [
	(driver findElementByID: 'Statistics-option') click.
]

{ #category : #tests }
ERLoggedPageAsAdminTest >> pressOptionUsers [
	(driver findElementByID: 'Users-option') click.
]

{ #category : #configurationAttendeesTest }
ERLoggedPageAsAdminTest >> selectAttendeesTab [
	(driver findElementByID: 'tab-Attendees') click.
]

{ #category : #configurationProposalsTests }
ERLoggedPageAsAdminTest >> selectAwardsTab [
	(driver findElementByID: 'tab-Awards') click.
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> selectFeeTab [
	(driver findElementByID: 'tab-Fee') click.
]

{ #category : #configurationGroupManagerTests }
ERLoggedPageAsAdminTest >> selectGroupManagerTab [
	(driver findElementByID: 'tab-Group Manager') click.
]

{ #category : #configurationInvoicesTests }
ERLoggedPageAsAdminTest >> selectInovicesTab [

	(driver findElementByID: 'tab-Invoices') click.
]

{ #category : #configurationAdminOptionTests }
ERLoggedPageAsAdminTest >> selectTabBackup [
	(driver findElementByID: 'tab-Backup') click
]

{ #category : #configurationAdminOptionTests }
ERLoggedPageAsAdminTest >> selectTabChangePassword [
	(driver findElementByID: 'tab-Change Password') click
]

{ #category : #configurationAdminOptionTests }
ERLoggedPageAsAdminTest >> selectTabOpenCloseRegistration [
	(driver findElementByID: 'tab-Open / Close registration') click
]

{ #category : #configurationAdminOptionTests }
ERLoggedPageAsAdminTest >> selectTabRestore [
	(driver findElementByID: 'tab-Restore') click
]

{ #category : #configurationTicketTest }
ERLoggedPageAsAdminTest >> selectTicketTab [

	(driver findElementByID: 'tab-Tickets') click.
]

{ #category : #tests }
ERLoggedPageAsAdminTest >> setUp [
	super setUp.
	self loginAsAdmin .
	ERTest generateDataForTest .
	controller := ERConfigurationController new.
]

{ #category : #configurationAdminOptionTests }
ERLoggedPageAsAdminTest >> testAdminOptionModifyPassword [
	self moveToChangePasswordTab .
	self shouldnt: [ driver findElementByID: 'groupManagerFunctions' ] raise: BPNoSuchElementException
]

{ #category : #configurationAdminOptionTests }
ERLoggedPageAsAdminTest >> testAdminOptionTabBackup [
	self moveToBackupTab . 
	self shouldnt: [ driver findElementByID: 'yes-tabBackup' ] raise: BPNoSuchElementException
]

{ #category : #configurationAdminOptionTests }
ERLoggedPageAsAdminTest >> testAdminOptionTabOpenCloseRegistration [
	|value isOpen|
	self pressOptionAdmin .
	self selectTabOpenCloseRegistration .
	self shouldnt: [ driver findElementByID: 'yes-tabOpenClose' ] raise: BPNoSuchElementException.
	value := ((driver findElementByID: 'tab-tabOpenClose') findElementByTagName: 'h3') getText.
	isOpen := controller conference conferenceIsOpenRegistration .
	isOpen
		ifTrue: [ self assert: value equals: 'Registration is opened. Are you sure you want close it?' ]
		ifFalse: [ self assert: value equals: 'Registration is closed. Are you sure you want open it?' ].
	(driver findElementByID: 'yes-tabOpenClose') click.
	self deny: controller conference conferenceIsOpenRegistration = isOpen 
]

{ #category : #configurationAdminOptionTests }
ERLoggedPageAsAdminTest >> testAdminOptionTabRestore [
	self pressOptionAdmin .
	self selectTabRestore .
	self shouldnt: [ driver findElementByID: 'yes-tabRestore' ] raise: BPNoSuchElementException
]

{ #category : #configurationAdminOptionTests }
ERLoggedPageAsAdminTest >> testAdminOptionTabUser [
	self pressOptionAdmin.
	self assert: (driver findElementByTagName: 'h3') getText equals: 'User'
]

{ #category : #configurationAttendeesTest }
ERLoggedPageAsAdminTest >> testApplyReductionToAttendee [
	|select attendee coupon|
	coupon := self validCoupon .
	attendee := controller conference attends first.
	self moveToAttendeeOption .
	(driver findElementByID: attendee id, '-applyReduction') click.
	self assert: (driver findElementByTagName: 'h3') getText equals: 'Apply Reduction Ticket'.
	select := driver findElementByID: 'selectTickets'.
	self assert: (select getAttribute: 'value') equals: '1'.
	select sendKeys: coupon ticketId .
	 (driver findElementByID: 'accept-change-affiliation') click.
	self assert: attendee paymentInformation coupon equals: coupon ticketId 
]

{ #category : #configurationAttendeesTest }
ERLoggedPageAsAdminTest >> testCancelEditAttendee [
	|attendee updateAttendee|
	attendee := controller conference attends first.
	self moveToAttendeeOption .
	(driver findElementByID: attendee id, '-modify')click.
	(driver findElementByID: 'contactInfoForm-goBackLoginButton')click.
	driver acceptAlert .
	updateAttendee := (ERAttendee find: [:att | att id = attendee id]).
	self assert: updateAttendee userAccount equals: attendee userAccount .
	self assert: updateAttendee contactInformation equals: attendee contactInformation .
	self assert: updateAttendee conferenceInformation equals: attendee conferenceInformation .
	self assert: updateAttendee affiliationInformation equals: attendee affiliationInformation .
	self assert: updateAttendee additionalInformation equals: attendee additionalInformation .
	self assert: updateAttendee paymentInformation equals: attendee paymentInformation .
]

{ #category : #configurationInvoicesTests }
ERLoggedPageAsAdminTest >> testCheckHasPaidInvoice [
	|delete invoice|
	invoice := controller conference invoices first.
	self moveToInvoicesOption .
	delete := driver findElementByID: invoice id, '-hasPaid'.
	delete click.
	self assert: (controller invoices first paymentInformation hasPaid)
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testDeleteUserAcceptAlert [
	|delete user|
	user := controller conference findUserByEmail: 'ana@gmail.com'.
	self pressOptionUsers .
	delete := driver findElementByID: user id, '-delete'.
	delete click.
	driver acceptAlert .
	(Delay forSeconds: 2) wait.
	self assert: (ERUserAccount find: [ :anUser | anUser id =user id ]) equals: nil
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testDeleteUserAdminAcceptAlert [
	|delete user|
	user := controller conference findUserByEmail: 'admin@esug.org'.
	self pressOptionUsers .
	delete := driver findElementByID: user id, '-delete'.
	delete click.
	driver acceptAlert.
	self assert: (driver findElementByID: 'tabAlert') getText equals: 
	ERException adminUserDoesNotDelete messageText
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testDeleteUserDismissAlert [
	|delete user|
	user := controller conference findUserByEmail: 'ana@gmail.com'.
	self pressOptionUsers .
	delete := driver findElementByID: user id, '-delete'.
	delete click.
	driver dismissAlert .
	(Delay forSeconds: 2) wait.
	self assert: 
		(ERUserAccount find: [ :anUser | anUser id =user id ]) equals: user
]

{ #category : #configurationAttendeesTest }
ERLoggedPageAsAdminTest >> testEditAttendee [
	| attendee|
	attendee := controller conference attends first.
	self moveToAttendeeOption .
	(driver findElementByID: attendee id, '-modify')click.
	self shouldnt: [driver findElementByID: 'tab-Contact'] raise: BPNoSuchElementException 
]

{ #category : #configurationGroupManagerTests }
ERLoggedPageAsAdminTest >> testEditGroup [
	|edit group|
	group := controller conference groups first.
	self moveToGroupManagerOption .
	edit := driver findElementByID: group id, '-modify'.
	edit click.
	self assert: (driver findElementByTagName: 'h3') getText equals: 'Affiliation Information'
]

{ #category : #configurationGroupManagerTests }
ERLoggedPageAsAdminTest >> testEditGroupWithEmptyOrganizationAddress [
	self pressEditGroup  .
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'organizationAddrees1' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'Address 1')
]

{ #category : #configurationGroupManagerTests }
ERLoggedPageAsAdminTest >> testEditGroupWithEmptyOrganizationName [	
	self pressEditGroup  .
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'organizationName' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'Organization Name')
]

{ #category : #configurationGroupManagerTests }
ERLoggedPageAsAdminTest >> testEditGroupWithEmptyOrganizationPostla [
	self pressEditGroup  .
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'organizationPostal' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'Postal/Zipcode')
]

{ #category : #configurationAttendeesTest }
ERLoggedPageAsAdminTest >> testEditUserOfAttendee [
	|check attendee|
	attendee := controller conference attends first.
	self moveToAttendeeOption .
	check := driver findElementByID: attendee id, '-modifyUser'.
	check click.
	self assert: (driver findElementByTagName: 'h3') getText equals: 'User'
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testEditUserWithAnEmailAlreadyRegistered [
	self pressEditUser .
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'email' with: 'admin@esug.org'.
	self assert: (driver findElementByID: 'formAlert') getText equals: 
		ERException emailAlreadyRegistered messageText 
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testEditUserWithEmptyEmail [
	self pressEditUser .
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'email' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'Email')
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testEditUserWithEmptyLastName [
	self pressEditUser .
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'lastName' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'Last Name')
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testEditUserWithEmptyName [
	self pressEditUser .
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'firstName' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'First Name')
]

{ #category : #configurationAttendeesTest }
ERLoggedPageAsAdminTest >> testIsVolunterAttendee [
	|check attendee|
	attendee := controller conference attends first.
	self moveToAttendeeOption .
	check := driver findElementByID: attendee id, '-isVolunter'.
	check click.
	self assert: (ERAttendee find: [ :ticket | ticket id =attendee id ]) userAccount isStudent 
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testPressCancelAfterUpdateAFieldOfConference [
	| newValue|
	newValue := '10/10/dsfd'.
	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'dateTo' with: newValue .
	self assert: self getTextOfError equals: (self messageWrongDateFormatFor: 'To (Required)').
	(driver findElementByID: 'cancelUpdate') click.
	self assert: ((driver findElementByID: 'closeConferenceConfiguration-dialog') getAttribute: 'open') equals: 'true'.
	((driver findElementByClassName: 'mdl-dialog__actions') findElementByTagName: 'a') click.
	self deny: controller conference configuration dateTo = newValue 
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testPressCancelModifyUserAfterChange [
	|cancel user userUpdate|
	user := controller conference findUserByEmail: 'ana@gmail.com'.
	self pressOptionUsers.
	(driver findElementByID: user id, '-modify') click.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'email' with: ''.
	(driver findElementByID: 'cancelButton') click.
	self assert: ((driver findElementByID: 'buttonClose-dialog') getAttribute: 'open') equals: 'true'.
	cancel := (driver findElementByClassName: 'mdl-dialog__actions') findElementByTagName: 'a'.
	cancel click.
	userUpdate := ERUserAccount detect: [ :each | each id = user id].
	self deny: userUpdate email = ''
]

{ #category : #configurationTicketTest }
ERLoggedPageAsAdminTest >> testPressDeleteATicketAcceptAlert [
	|delete coupon|
	coupon := self validCoupon id.
	self moveToTicketsOption.
	delete := driver findElementByID: coupon, '-delete'.
	delete click.
	driver acceptAlert .
	(Delay forSeconds: 2) wait.
	self assert: (ERReductionTicket find: [ :ticket | ticket id =coupon ]) equals: nil
]

{ #category : #configurationTicketTest }
ERLoggedPageAsAdminTest >> testPressDeleteATicketDismissAlert [
	|delete coupon|
	coupon := self validCoupon id.
	self moveToTicketsOption.
	delete := driver findElementByID: coupon, '-delete'.
	delete click.
	driver dismissAlert .
	(Delay forSeconds: 2) wait.
	self assert: (ERReductionTicket find: [ :ticket | ticket id =coupon ]) equals: self validCoupon
]

{ #category : #configurationAttendeesTest }
ERLoggedPageAsAdminTest >> testPressDeleteAttendeeAcceptAlert [
	|delete attendee|
	attendee := controller conference attends first.
	self moveToAttendeeOption .
	delete := driver findElementByID: attendee id, '-delete'.
	delete click.
	driver acceptAlert .
	(Delay forSeconds: 2) wait.
	self assert: (ERAttendee find: [ :ticket | ticket id =attendee id ]) equals: nil
]

{ #category : #configurationAttendeesTest }
ERLoggedPageAsAdminTest >> testPressDeleteAttendeeDismissAlert [
	|delete attendee|
	attendee := controller conference attends first.
	self moveToAttendeeOption .
	delete := driver findElementByID: attendee id, '-delete'.
	delete click.
	driver dismissAlert .
	(Delay forSeconds: 2) wait.
	self assert: (ERAttendee find: [ :ticket | ticket id =attendee id ]) equals: attendee
]

{ #category : #configurationGroupManagerTests }
ERLoggedPageAsAdminTest >> testPressDeleteGroupAcceptAlert [
	|delete group|
	group := controller conference groups first.
	self moveToGroupManagerOption .
	delete := driver findElementByID: group id, '-delete'.
	delete click.
	driver acceptAlert .
	(Delay forSeconds: 2) wait.
	self assert: (ERGroup find: [ :ticket | ticket id =group id ]) equals: nil
]

{ #category : #configurationGroupManagerTests }
ERLoggedPageAsAdminTest >> testPressDeleteGroupDismissAlert [
	|delete group|
	group := controller conference groups first.
	self moveToGroupManagerOption .
	delete := driver findElementByID: group id, '-delete'.
	delete click.
	driver dismissAlert .
	(Delay forSeconds: 2) wait.
	self deny: (ERGroup find: [ :ticket | ticket id =group id ]) = nil
]

{ #category : #configurationInvoicesTests }
ERLoggedPageAsAdminTest >> testPressDownloadButtonOfInvoice [
	|invoice href|
	self createDownloadDirectory .
	invoice := controller conference invoices first.
	self moveToInvoicesOption.
	href := (driver findElementByID: invoice id, '-export') getAttribute: 'href'.
	self downloadFileOf: href to: Smalltalk imageDirectory / 'Download' / 'invoice.pdf'
]

{ #category : #configurationTicketTest }
ERLoggedPageAsAdminTest >> testPressEditTicket [
	|delete coupon|
	coupon := self validCoupon.
	self moveToTicketsOption.
	delete := driver findElementByID: coupon id, '-modify'.
	delete click.
	self assert: (driver findElementByTagName: 'h3') getText 
	equals: 'Reduction Tickets'.
	self assert: ((driver findElementByID: 'ticketId') getAttribute: 'value')
	equals: coupon ticketId .
]

{ #category : #configurationInvoicesTests }
ERLoggedPageAsAdminTest >> testPressExportAllInvoicesButtonOfInvoice [
	"|button href|
	self moveToInvoicesOption .
	button := driver findElementByID: 'exportAllInvoices'.
	button click.
	(Delay forSeconds: 5) wait.
	href := (driver findElementByID: 'downloadAllInvoices') getAttribute: 'href'.
	self deny: (href = nil)"
]

{ #category : #configurationAttendeesTest }
ERLoggedPageAsAdminTest >> testPressExportAttendeees [
	| href|
	self createDownloadDirectory .
	self moveToAttendeeOption.
	href := (driver findElementByID: 'exportAttends') getAttribute: 'href'.
	self downloadFileOf: href to: Smalltalk imageDirectory / 'Download' / 'attendees.csv'
]

{ #category : #configurationProposalsTests }
ERLoggedPageAsAdminTest >> testPressExportAwards [
	| href|
	self createDownloadDirectory .
	self moveToAwardsOption .
	href := (driver findElementByID: 'exportAwards') getAttribute: 'href'.
	self downloadFileOf: href to: Smalltalk imageDirectory / 'Download' / 'awards.csv'
]

{ #category : #configurationGroupManagerTests }
ERLoggedPageAsAdminTest >> testPressExportGroups [
	| href|
	self createDownloadDirectory .
	self moveToGroupManagerOption .
	href := (driver findElementByID: 'exportGroups') getAttribute: 'href'.
	self downloadFileOf: href to: Smalltalk imageDirectory / 'Download' / 'groups.csv'
]

{ #category : #configurationProposalsTests }
ERLoggedPageAsAdminTest >> testPressExportTalks [
	| href|
	self createDownloadDirectory .
	self pressOptionProposals .
	href := (driver findElementByID: 'exportTalks') getAttribute: 'href'.
	self downloadFileOf: href to: Smalltalk imageDirectory / 'Download' / 'talks.csv'
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testPressExportUsers [
	| href|
	self createDownloadDirectory .
	self pressOptionUsers .
	href := (driver findElementByID: 'exportUsers') getAttribute: 'href'.
	self downloadFileOf: href to: Smalltalk imageDirectory / 'Download' / 'users.csv'
]

{ #category : #configurationGroupManagerTests }
ERLoggedPageAsAdminTest >> testPressModifyGroupManagerUser [
	|edit group|
	group := controller conference groups first.
	self moveToGroupManagerOption .
	edit := driver findElementByID: group id, '-modifyUser'.
	edit click.
	self assert: (driver findElementByTagName: 'h3') getText equals: 'User'
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testPressModifyUser [
	|update user|
	user := controller conference findUserByEmail: 'ana@gmail.com'.
	self pressOptionUsers.
	update := driver findElementByID: user id, '-modify'.
	update click.
	self assert: (driver findElementByTagName: 'h3') getText equals: 
	'User'
]

{ #category : #configurationProposalsTests }
ERLoggedPageAsAdminTest >> testPressProposalsOption [
	self pressOptionProposals .
	self assert: (driver findElementByTagName: 'h3') getText equals: 'Submitted Talks'
]

{ #category : #configurationStatistics }
ERLoggedPageAsAdminTest >> testStatisticsView [
	self pressOptionStatistics .
	self assert: (driver findElementByTagName: 'h3') getText equals: 'Statistics'.
	self assert: (driver findElementsByTagName: 'table') size equals: 3
]

{ #category : #configurationAttendeesTest }
ERLoggedPageAsAdminTest >> testUncheckIsVolunterAttendee [
	|check attendee|
	attendee := controller conference attends first.
	controller convertToStudentVolunterThis: attendee.
	self moveToAttendeeOption .
	check := driver findElementByID: attendee id, '-isVolunter'.
	check click.
	self deny: (ERAttendee find: [ :ticket | ticket id =attendee id ]) userAccount isStudent 
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateAddressStringBankInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'addressStringBank' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'AddressString')
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateApiKeyConferenceWithEmptyValue [

	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'apiKey' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Api key')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateBankPayPalUrlFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'bankPayPalUrl' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'PayPal URL')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateBicBankInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'bic' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'BIC')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateCodeBankInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'code' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Code')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateCounterCodeBankInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'counterCode' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Counter code')
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateDateEarlyRegistrationDeadlineConferenceWithWrongFormat [
	
	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'earlyRegistrationDeadline' with: '10/10/dsfd' .
	self assert: self getTextOfError equals: (self messageWrongDateFormatFor: 'Early Registration Deadline (Required)')
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateDateFromConference [
	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'dateFrom' with: '10/10/2019' .
	self assert: controller conference configuration dateFrom equals: '10/10/2019' 
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateDateFromConferenceWithHigherDateThanDateTo [
	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'dateFrom' with: '10/10/2019'.
	self assert: (driver findElementByID: 'formConferenceConfigurationAlert' ) getText equals: ERException invalidEsugDates messageText
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateDateFromConferenceWithWrongFormat [
	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'dateFrom' with: '10/10/dsfd'.
	self assert: self getTextOfError equals: ( self messageWrongDateFormatFor: 'From (Required)')
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateDateSubmissionDeadlineConferenceWithWrongFormat [
	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'dateSubmissionDeadline' with: '10/10/dsfd'.
	self assert: self getTextOfError equals: (self messageWrongDateFormatFor:'Submission Deadline (Required)')
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateDateToConferenceWithWrongFormat [
	
	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'dateTo' with: '10/10/dsfd' .
	self assert: self getTextOfError equals: (self messageWrongDateFormatFor: 'To (Required)')
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateDescriptionConference [
	| newValue|
	newValue := 'The European Smalltalk User Group (ESUG) is a non-profit users organization that supports all kinds of Smalltalk initiatives, especially free-open source ones that benefit the whole Smalltalk community'.
	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'description' with: newValue .
	self assert: controller conference configuration description equals: newValue 
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateHomePageUrlConference [
	| newValue|
	newValue := 'http://www.esug.org/wiki/'.
	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'homePageUrl' with: newValue .
	self assert: controller conference configuration homePageUrl equals: newValue 
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateIbanBankAccountInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'iban' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Iban')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateNameBankInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'nameBank' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Name')
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateNameConferenceWithEmptyValue [
	
	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'name' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Name')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateNumberBankAccountInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'number' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Number')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateOwnerBankAccountInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'owner' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Owner')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePaypalCommisionFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'payPalCommissionPercentage' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Paypal Commission Percentage')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePaypalCommisionFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'payPalCommissionPercentage' with: 'One' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'Paypal Commission Percentage')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePriceForAddPersonFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'extraPersonSD' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Price for add person to the Social Dinner')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePriceForAddPersonFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'extraPersonSD' with: 'One' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'Price for add person to the Social Dinner')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePriceForEarlyAllDaysFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'erfAllDaysFee' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'All Days Fee')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePriceForEarlyAllDaysFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'erfAllDaysFee' with: 'asdf' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'All Days Fee')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePriceForEarlyOneDayFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'erfOneDayFee' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'One Day Fee')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePriceForEarlyOneDayFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'erfOneDayFee' with: 'One' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'One Day Fee')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePriceForLateAllDaysFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'lrfAllDaysFee' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'All Days Fee')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePriceForLateAllDaysFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'lrfAllDaysFee' with: 'One' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'All Days Fee')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePriceForLateOneDayFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'lrfOneDayFee' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'One Day Fee')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePriceForLateOneDayFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'lrfOneDayFee' with: 'One' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'One Day Fee')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateRibKeyBankAccountInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'ribKey' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Rib Key')
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateSenderEmailAddressConferenceWithEmptyValue [
	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'senderEmailAddress' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Sender email address')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateStaticCommisionPaypalFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'staticCommissionPaypal' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Static Commission Paypal')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateStaticCommisionPaypalFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'staticCommissionPaypal' with: 'One' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'Static Commission Paypal')
]

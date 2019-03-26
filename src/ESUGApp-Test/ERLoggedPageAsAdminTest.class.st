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
	self selectElementWithID: 'email-login' send: 'admin@esug.org'.
	self selectElementWithID: 'password-login' send: '12345678'.
	self clickElementWithID: 'login-button'
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
	self clickElementWithID: group id, '-modify'
	
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> pressEditUser [
	| user|
	user := controller conference findUserByEmail: 'ana@gmail.com'.
	self pressOptionUsers.
	self clickElementWithID:  user id, '-modify'
]

{ #category : #tests }
ERLoggedPageAsAdminTest >> pressOptionAdmin [
	self clickElementWithID:  'Admin-option'
]

{ #category : #tests }
ERLoggedPageAsAdminTest >> pressOptionConfiguration [
	self clickElementWithID:  'Configuration-option'
]

{ #category : #tests }
ERLoggedPageAsAdminTest >> pressOptionProposals [
	self clickElementWithID:  'Proposals-option'
]

{ #category : #tests }
ERLoggedPageAsAdminTest >> pressOptionStatistics [
	self clickElementWithID:  'Statistics-option'
]

{ #category : #tests }
ERLoggedPageAsAdminTest >> pressOptionUsers [
	self clickElementWithID: 'Users-option'
]

{ #category : #configurationAttendeesTest }
ERLoggedPageAsAdminTest >> selectAttendeesTab [
	self clickElementWithID: 'tab-Attendees'
]

{ #category : #configurationProposalsTests }
ERLoggedPageAsAdminTest >> selectAwardsTab [
	self clickElementWithID: 'tab-Awards'
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> selectFeeTab [
	self clickElementWithID: 'tab-Fee'
]

{ #category : #configurationGroupManagerTests }
ERLoggedPageAsAdminTest >> selectGroupManagerTab [
	self clickElementWithID: 'tab-Group Manager'
]

{ #category : #configurationInvoicesTests }
ERLoggedPageAsAdminTest >> selectInovicesTab [
	self clickElementWithID: 'tab-Invoices'
]

{ #category : #configurationAdminOptionTests }
ERLoggedPageAsAdminTest >> selectTabBackup [
	self clickElementWithID: 'tab-Backup'
]

{ #category : #configurationAdminOptionTests }
ERLoggedPageAsAdminTest >> selectTabChangePassword [
	self clickElementWithID: 'tab-Change Password'
]

{ #category : #configurationAdminOptionTests }
ERLoggedPageAsAdminTest >> selectTabOpenCloseRegistration [
	self clickElementWithID: 'tab-Open / Close registration'
]

{ #category : #configurationAdminOptionTests }
ERLoggedPageAsAdminTest >> selectTabRestore [
	self clickElementWithID: 'tab-Restore'
]

{ #category : #configurationTicketTest }
ERLoggedPageAsAdminTest >> selectTicketTab [
	self clickElementWithID: 'tab-Tickets'
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
	self clickElementWithID: 'yes-tabOpenClose'.
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
	self clickElementWithID: attendee id, '-applyReduction'.
	self assert: (driver findElementByTagName: 'h3') getText equals: 'Apply Reduction Ticket'.
	select := driver findElementByID: 'selectTickets'.
	self assert: (select getAttribute: 'value') equals: '1'.
	select sendKeys: coupon ticketId .
	self clickElementWithID: 'accept-change-affiliation'.
	self assert: attendee paymentInformation coupon equals: coupon ticketId 
]

{ #category : #configurationAttendeesTest }
ERLoggedPageAsAdminTest >> testCancelEditAttendee [
	|attendee updateAttendee|
	attendee := controller conference attends first.
	self moveToAttendeeOption .
	self clickElementWithID: attendee id, '-modify'.
	self clickElementWithID: 'contactInfoForm-goBackLoginButton'.
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
	|invoice|
	invoice := controller conference invoices first.
	self moveToInvoicesOption .
	self clickElementWithID: invoice id, '-hasPaid'.
	self assert: (controller conference invoices first paymentInformation hasPaid)
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testDeleteUserAcceptAlert [
	|user|
	user := controller conference findUserByEmail: 'ana@gmail.com'.
	self pressOptionUsers .
	self clickElementWithID: user id, '-delete'.
	driver acceptAlert .
	(Delay forSeconds: 2) wait.
	self assert: (ERUserAccount find: [ :anUser | anUser id =user id ]) equals: nil
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testDeleteUserAdminAcceptAlert [
	| user|
	user := controller conference findUserByEmail: 'admin@esug.org'.
	self pressOptionUsers .
	self clickElementWithID: user id, '-delete'.
	driver acceptAlert.
	self assert: (driver findElementByID: 'tabAlert') getText equals: 
	ERException adminUserDoesNotDelete messageText
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testDeleteUserDismissAlert [
	| user|
	user := controller conference findUserByEmail: 'ana@gmail.com'.
	self pressOptionUsers .
	self clickElementWithID: user id, '-delete'.
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
	self clickElementWithID: attendee id, '-modify'.
	self shouldnt: [driver findElementByID: 'tab-Contact'] raise: BPNoSuchElementException 
]

{ #category : #configurationGroupManagerTests }
ERLoggedPageAsAdminTest >> testEditGroup [
	| group|
	group := controller conference groups first.
	self moveToGroupManagerOption .
	self clickElementWithID: group id, '-modify'.
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
	|attendee|
	attendee := controller conference attends first.
	self moveToAttendeeOption .
	self clickElementWithID: attendee id, '-modifyUser'.
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
	| attendee|
	attendee := controller conference attends first.
	self moveToAttendeeOption .
	self clickElementWithID: attendee id, '-isVolunter'.
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
	self clickElementWithID: 'cancelUpdate'.
	self assert: ((driver findElementByID: 'closeConferenceConfiguration-dialog') getAttribute: 'open') equals: 'true'.
	((driver findElementByClassName: 'mdl-dialog__actions') findElementByTagName: 'a') click.
	self deny: controller conference configuration dateTo = newValue 
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testPressCancelModifyUserAfterChange [
	|cancel user userUpdate|
	user := controller conference findUserByEmail: 'ana@gmail.com'.
	self pressOptionUsers.
	self clickElementWithID: user id, '-modify'.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'email' with: ''.
	self clickElementWithID: 'cancelButton'.
	self assert: ((driver findElementByID: 'buttonClose-dialog') getAttribute: 'open') equals: 'true'.
	cancel := (driver findElementByClassName: 'mdl-dialog__actions') findElementByTagName: 'a'.
	cancel click.
	userUpdate := ERUserAccount detect: [ :each | each id = user id].
	self deny: userUpdate email = ''
]

{ #category : #configurationTicketTest }
ERLoggedPageAsAdminTest >> testPressDeleteATicketAcceptAlert [
	|coupon|
	coupon := self validCoupon id.
	self moveToTicketsOption.
	self clickElementWithID: coupon, '-delete'.
	driver acceptAlert .
	(Delay forSeconds: 2) wait.
	self assert: (ERReductionTicket find: [ :ticket | ticket id =coupon ]) equals: nil
]

{ #category : #configurationTicketTest }
ERLoggedPageAsAdminTest >> testPressDeleteATicketDismissAlert [
	| coupon|
	coupon := self validCoupon id.
	self moveToTicketsOption.
	self clickElementWithID: coupon, '-delete'.
	driver dismissAlert .
	(Delay forSeconds: 2) wait.
	self assert: (ERReductionTicket find: [ :ticket | ticket id =coupon ]) equals: self validCoupon
]

{ #category : #configurationAttendeesTest }
ERLoggedPageAsAdminTest >> testPressDeleteAttendeeAcceptAlert [
	| attendee|
	attendee := controller conference attends first.
	self moveToAttendeeOption .
	self clickElementWithID: attendee id, '-delete'.
	driver acceptAlert .
	(Delay forSeconds: 2) wait.
	self assert: (ERAttendee find: [ :ticket | ticket id =attendee id ]) equals: nil
]

{ #category : #configurationAttendeesTest }
ERLoggedPageAsAdminTest >> testPressDeleteAttendeeDismissAlert [
	| attendee|
	attendee := controller conference attends first.
	self moveToAttendeeOption .
	self clickElementWithID: attendee id, '-delete'.
	driver dismissAlert .
	(Delay forSeconds: 2) wait.
	self assert: (ERAttendee find: [ :ticket | ticket id =attendee id ]) equals: attendee
]

{ #category : #configurationGroupManagerTests }
ERLoggedPageAsAdminTest >> testPressDeleteGroupAcceptAlert [
	| group|
	group := controller conference groups first.
	self moveToGroupManagerOption .
	self clickElementWithID: group id, '-delete'.
	driver acceptAlert .
	(Delay forSeconds: 2) wait.
	self assert: (ERGroup find: [ :ticket | ticket id =group id ]) equals: nil
]

{ #category : #configurationGroupManagerTests }
ERLoggedPageAsAdminTest >> testPressDeleteGroupDismissAlert [
	| group|
	group := controller conference groups first.
	self moveToGroupManagerOption .
	self clickElementWithID: group id, '-delete'.
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
	| coupon|
	coupon := self validCoupon.
	self moveToTicketsOption.
	self clickElementWithID: coupon id, '-modify'.
	self assert: (driver findElementByTagName: 'h3') getText 
	equals: 'Reduction Tickets'.
	self assert: ((driver findElementByID: 'ticketId') getAttribute: 'value')
	equals: coupon ticketId .
]

{ #category : #configurationInvoicesTests }
ERLoggedPageAsAdminTest >> testPressExportAllInvoicesButtonOfInvoice [
	"| href|
	self moveToInvoicesOption .
	self selectElementWithID: 'exportAllInvoices'.
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
	| group|
	group := controller conference groups first.
	self moveToGroupManagerOption .
	self clickElementWithID: group id, '-modifyUser'.
	self assert: (driver findElementByTagName: 'h3') getText equals: 'User'
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testPressModifyUser [
	| user|
	user := controller conference findUserByEmail: 'ana@gmail.com'.
	self pressOptionUsers.
	self clickElementWithID: user id, '-modify'.
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
	| attendee|
	attendee := controller conference attends first.
	controller convertToStudentVolunterThis: attendee.
	self moveToAttendeeOption .
	self clickElementWithID: attendee id, '-isVolunter'.
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

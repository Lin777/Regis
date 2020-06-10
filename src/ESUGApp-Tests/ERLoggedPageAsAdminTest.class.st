"
Description
--------------------

A ERLoggedPageAsAdminTest is a test class for testing the behavior of page when the user sign in as Admin
"
Class {
	#name : #ERLoggedPageAsAdminTest,
	#superclass : #ERParasolTest,
	#category : #'ESUGApp-Tests-Parasol'
}

{ #category : #actions }
ERLoggedPageAsAdminTest >> fillAmount [
	self selectElementWithID: 'amount' send: '25'.
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> fillLimit [
	self selectElementWithID: 'limit' send: '5'.
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> fillPercentage [
	self selectElementWithID: 'percentage' send: '25'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> fillTicketId [
	self selectElementWithID: 'ticketId' send: 'example123'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> getNameOfConference [
	^ controller conference configuration name 
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> loginAsAdmin [
	self selectElementWithID: 'email-login' send: 'admin@esug.org'.
	self selectElementWithID: 'password-login' send: '12345678'.
	self clickElementWithID: 'login-button'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> messageInvalidInputFor: aString [
	^ aString, ' (Required): Invalid input given'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> messageWrongDateFormatFor: aString [
	^ aString, ': This field only supports dates with the following format "MM/DD/YYYY"'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> moveToAttendeeOption [
	self pressOptionConference.
	self selectAttendeesTab.
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> moveToAwardsOption [
	self pressOptionProposals  .
	self selectAwardsTab  .
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> moveToChangePasswordTab [
	self pressOptionAdmin .
	self selectTabChangePassword 
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> moveToConferenceOption [
	self pressOptionConfiguration.
	self clickElementWithID: 'tab-Conference'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> moveToFeeOption [
	self pressOptionConfiguration.
	self selectFeeTab.
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> moveToGroupManagerOption [
	self pressOptionUsers.
	self selectGroupManagerTab.
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> moveToInvoicesOption [
	self pressOptionInvoice.
	self selectInvoicesTab.
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> moveToTicketsOption [
	self pressOptionConfiguration.
	self selectTicketTab.
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> moveToUserOption [
	self pressUserConfiguration.
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> pressEditGroup [
	| group |
	group := controller conference groups first.
	self moveToGroupManagerOption.
	self clickElementWithID: group id, '-modify'
	
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> pressEditUser [
	| user|
	user := controller conference findUserByEmail: 'ana@gmail.com'.
	self pressOptionUsers.
	self clickElementWithID:  user id, '-modify'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> pressNextAffiliationButton [
	self clickElementWithID: 'affiliationInfoForm-nextButton'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> pressNextButton [
	self clickElementWithID:  'Conference-option'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> pressOptionConference [
	self clickElementWithID:  'Attendees-option'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> pressOptionConfiguration [
	self clickElementWithID:  'Configuration-option'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> pressOptionInvoice [
	self clickElementWithID:  'Invoices-option'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> pressOptionProposals [
	self clickElementWithID:  'Proposals-option'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> pressOptionStatistics [
	self clickElementWithID:  'Statistics-option'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> pressOptionUsers [
	self clickElementWithID: 'Users-option'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> pressUserConfiguration [
	self clickElementWithID:  'Users-option'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> selectAddTicket [
	self moveToTicketsOption.
	self clickElementWithID: 'addTicket'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> selectAttendeesTab [
	self clickElementWithID: 'tab-Attendees'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> selectAwardsTab [
	self clickElementWithID: 'tab-Awards'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> selectConfigurationTab [
	self clickElementWithID: 'tab-Configuration'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> selectFeeTab [
	self clickElementWithID: 'tab-Fee'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> selectGroupBillingInformationTab [
	self clickElementWithID:  'tab-Billing Information'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> selectGroupManagerTab [
	self clickElementWithID: 'tab-Group information'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> selectInvoicesTab [
	self clickElementWithID: 'tab-Invoices'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> selectPaymentInformationTab [
	self clickElementWithID:  'tab-Payment'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> selectTabChangePassword [
	self clickElementWithID: 'changePassword'
]

{ #category : #actions }
ERLoggedPageAsAdminTest >> selectTicketTab [
	self clickElementWithID: 'tab-Tickets'
]

{ #category : #running }
ERLoggedPageAsAdminTest >> setUp [

	super setUp.
	self loginAsAdmin.
	ERTest generateDataForTest.
	controller := ERConfigurationController new.
]

{ #category : #'configurationTicket Tests' }
ERLoggedPageAsAdminTest >> testAddTicketSuccesfull [
	|amountOfTickets|
	amountOfTickets := controller conference reductionTickets size.
	self selectAddTicket .
	self fillTicketId .
	self fillLimit .
	self fillPercentage.
	self clickElementWithID: 'acceptAddTicket'.
	self assert: controller conference reductionTickets size equals: amountOfTickets +1.
	self deny: (controller conference reductionTickets detect: 
		[:ticket | ticket ticketId = 'example123']) = nil
	
]

{ #category : #'configurationTicket Tests' }
ERLoggedPageAsAdminTest >> testAddTicketWithAlreadyRegisteredTicketID [
	|coupon|
	coupon := self validCoupon.
	self selectAddTicket.
	self selectElementWithID: 'ticketId' send: coupon ticketId .
	self fillPercentage .
	self fillLimit .
	self clickElementWithID: 'acceptAddTicket'.
	self assert: (self textOfElementWithID: 'formTicketAlert') 
			equals: ERException ticketWithIdAlreadyExist messageText
]

{ #category : #'configurationTicket Tests' }
ERLoggedPageAsAdminTest >> testAddTicketWithEmptyLimit [
	self selectAddTicket.
	self fillTicketId .
	self fillPercentage .
	self clickElementWithID: 'acceptAddTicket'.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Limit')
]

{ #category : #'configurationTicket Tests' }
ERLoggedPageAsAdminTest >> testAddTicketWithEmptyPercentage [
	self selectAddTicket.
	self fillTicketId .
	self fillLimit .
	self clickElementWithID: 'acceptAddTicket'.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Percentage')
]

{ #category : #'configurationTicket Tests' }
ERLoggedPageAsAdminTest >> testAddTicketWithEmptyTicketID [
	self selectAddTicket.
	self fillPercentage .
	self fillLimit .
	self clickElementWithID: 'acceptAddTicket'.
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Id')
]

{ #category : #'configurationTicket Tests' }
ERLoggedPageAsAdminTest >> testAddTicketWithNonNumericLimit [
	self selectAddTicket .
	self fillTicketId .
	self fillPercentage .
	self selectElementWithID: 'limit' send: 'text'.
	self clickElementWithID: 'acceptAddTicket'.
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'Limit')
]

{ #category : #'configurationTicket Tests' }
ERLoggedPageAsAdminTest >> testAddTicketWithNonNumericPercentage [
	self selectAddTicket .
	self fillTicketId .
	self fillLimit .
	self selectElementWithID: 'percentage' send: 'text'.
	self clickElementWithID: 'acceptAddTicket'.
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'Percentage')
]

{ #category : #'configuration Admin Option Tests' }
ERLoggedPageAsAdminTest >> testAdminOptionModifyPassword [
	self moveToChangePasswordTab .
	self shouldnt: [ driver findElementByID: 'currentPassword' ] raise: BPNoSuchElementException
]

{ #category : #'configuration Admin Option Tests' }
ERLoggedPageAsAdminTest >> testAdminOptionTabUser [
	self pressOptionAdmin.
	self assert: (self textOfTagName: 'h3') equals: 'Edit profile'
]

{ #category : #'configuration Attendees Test' }
ERLoggedPageAsAdminTest >> testApplyReductionToAttendee [
	|select attendee coupon|
	coupon := self validCoupon .
	attendee := controller conference attends first.
	self moveToAttendeeOption .
	self clickElementWithID: attendee id, '-applyReduction'.
	self assert: (self textOfTagName: 'h3') equals: 'Apply Reduction Ticket'.
	select := driver findElementByID: 'selectTickets'.
	self assert: (select getAttribute: 'value') equals: '1'.
	select sendKeys: coupon ticketId .
	self clickElementWithID: 'accept-change-affiliation'.
	self assert: attendee paymentInformation coupon equals: coupon ticketId 
]

{ #category : #'configuration Attendees Test' }
ERLoggedPageAsAdminTest >> testCancelEditAttendee [
	|attendee updateAttendee|
	attendee := controller conference attends first.
	self moveToAttendeeOption.
	self selectAttendeesTab.
	self clickElementWithID: attendee id, '-modify'.
	self clickElementWithID: 'contactInfoForm-goBackLoginButton'.
	updateAttendee := (ERAttendee find: [:att | att id = attendee id]).
	self assert: updateAttendee userAccount equals: attendee userAccount.
	self assert: updateAttendee contactInformation equals: attendee contactInformation.
	self assert: updateAttendee conferenceInformation equals: attendee conferenceInformation.
	self assert: updateAttendee affiliationInformation equals: attendee affiliationInformation.
	self assert: updateAttendee additionalInformation equals: attendee additionalInformation.
	self assert: updateAttendee paymentInformation equals: attendee paymentInformation.
]

{ #category : #'configuration Invoices Tests' }
ERLoggedPageAsAdminTest >> testCheckHasPaidInvoice [
	|invoice|
	invoice := controller conference invoices first.
	self moveToInvoicesOption.
	self clickElementWithID: invoice id, '-hasPaid'.
	self assert: (controller conference invoices first paymentInformation hasPaid)
]

{ #category : #'configuration Users Tests' }
ERLoggedPageAsAdminTest >> testDeleteUserAcceptAlert [
	|user|
	user := controller conference findUserByEmail: 'ana@gmail.com'.
	self pressOptionUsers .
	self clickElementWithID: user id, '-delete'.
	driver acceptAlert .
	(Delay forSeconds: 2) wait.
	self assert: (ERUserAccount find: [ :anUser | anUser id =user id ]) equals: nil
]

{ #category : #'configuration Users Tests' }
ERLoggedPageAsAdminTest >> testDeleteUserAdminAcceptAlert [
	| user|
	user := controller conference findUserByEmail: 'admin@esug.org'.
	self pressOptionUsers .
	self clickElementWithID: user id, '-delete'.
	driver acceptAlert.
	self assert: (self textOfElementWithID: 'tabAlert') equals: 
	ERException adminUserDoesNotDelete messageText
]

{ #category : #'configuration Users Tests' }
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

{ #category : #'configuration Attendees Test' }
ERLoggedPageAsAdminTest >> testEditAttendee [
	| attendee|
	attendee := controller conference attends first.
	self moveToAttendeeOption .
	self clickElementWithID: attendee id, '-modify'.
	self shouldnt: [driver findElementByID: 'tab-Contact'] raise: BPNoSuchElementException 
]

{ #category : #'configuration Group Manager Tests' }
ERLoggedPageAsAdminTest >> testEditGroup [
	| group|
	group := controller conference groups first.
	self moveToGroupManagerOption.
	self clickElementWithID: group id, '-modify'.
	self assert: (self textOfElementWithID: 'tab-Contact')equals: 'CONTACT'.
	self assert: (self textOfElementWithID: 'tab-Billing Information')equals: 'BILLING INFORMATION'.
	self assert: (self textOfElementWithID: 'tab-Payment')equals: 'PAYMENT'.
]

{ #category : #'configuration Group Manager Tests' }
ERLoggedPageAsAdminTest >> testEditGroupWithEmptyOrganizationAddress [

	self pressEditGroup.
	self selectGroupBillingInformationTab.
	acceptFormButton := 'affiliationInfoForm-nextButton'.
	self updateField: 'organizationAddrees1' with: ''.
	self assert: (self textOfElementWithID: 'organizationAddrees1-error')
		equals: 'This field is required.'
]

{ #category : #'configuration Group Manager Tests' }
ERLoggedPageAsAdminTest >> testEditGroupWithEmptyOrganizationName [	

	"self pressEditGroup.
	self selectGroupBillingInformationTab.
	acceptFormButton := 'affiliationInfoForm-nextButton'.
	self updateField: 'organizationName' with: ''.
	self assert: (self textOfElementWithID: 'organizationName-error')
		equals: 'This field is required.'"
]

{ #category : #'configuration Group Manager Tests' }
ERLoggedPageAsAdminTest >> testEditGroupWithEmptyOrganizationPostal [

	self pressEditGroup.
	self selectGroupBillingInformationTab.
	acceptFormButton := 'affiliationInfoForm-nextButton'.
	self updateField: 'organizationPostal' with: ''.
	self assert: (self textOfElementWithID: 'organizationPostal-error')
		equals: 'This field is required.'
]

{ #category : #'configurationTicket Tests' }
ERLoggedPageAsAdminTest >> testEditTicketSuccesfull [
	| coupon |
	"coupon := self validCoupon.
	self moveToTicketsOption.
	self clickElementWithID: coupon id, '-modify'.
	self selectElementWithID: 'selectLimitStrategy' send: 'Unlimit strategy'.
	self selectElementWithID: 'selectStrategy' send: 'Fix Discount'.
	self fillAmount.
	self clickElementWithID: 'acceptAddTicket'.
	self assert: coupon strategyIsFixDiscount.
	self assert: coupon limitStrategyIsUnlimited"
]

{ #category : #'configuration Users Tests' }
ERLoggedPageAsAdminTest >> testEditUserWithAnEmailAlreadyRegistered [
	self pressEditUser .
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'email' with: 'admin@esug.org'.
	self assert: (self textOfElementWithID: 'formAlert') equals: 
		ERException emailAlreadyRegistered messageText 
]

{ #category : #'configuration Users Tests' }
ERLoggedPageAsAdminTest >> testEditUserWithEmptyEmail [
	self pressEditUser .
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'email' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'Email')
]

{ #category : #'configuration Users Tests' }
ERLoggedPageAsAdminTest >> testEditUserWithEmptyLastName [
	self pressEditUser .
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'lastName' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'Last Name')
]

{ #category : #'configuration Users Tests' }
ERLoggedPageAsAdminTest >> testEditUserWithEmptyName [
	self pressEditUser .
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'firstName' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'First Name')
]

{ #category : #'configuration Attendees Test' }
ERLoggedPageAsAdminTest >> testIsVolunterAttendee [
	| attendee|
	attendee := controller conference attends first.
	self moveToAttendeeOption .
	self clickElementWithID: attendee id, '-isVolunter'.
	self assert: (ERAttendee find: [ :ticket | ticket id =attendee id ]) userAccount isStudent 
]

{ #category : #'configurationTicket Tests' }
ERLoggedPageAsAdminTest >> testPressAddTicket [
	self moveToTicketsOption.
	self clickElementWithID: 'addTicket'.
	self assert: (self textOfTagName: 'h3') equals: 'Reduction Tickets'
]

{ #category : #'configuration Conference Tests' }
ERLoggedPageAsAdminTest >> testPressCancelAfterUpdateAFieldOfConference [
	| newValue|
	newValue := '10/10/dsfd'.
	self moveToConferenceOption.
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'dateTo' with: newValue .
	self assert: self getTextOfError equals: (self messageWrongDateFormatFor: 'To (Required)').
	self clickElementWithID: 'cancelUpdate'.
	self assert: ((driver findElementByID: 'closeConferenceConfiguration-dialog') getAttribute: 'open') equals: 'true'.
	((driver findElementByClassName: 'mdl-dialog__actions') findElementByTagName: 'a') click.
	self deny: controller conference configuration dateTo = newValue 
]

{ #category : #'configuration Users Tests' }
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

{ #category : #'configurationTicket Tests' }
ERLoggedPageAsAdminTest >> testPressDeleteATicketAcceptAlert [
	|coupon|
	coupon := self validCoupon id.
	self moveToTicketsOption.
	self clickElementWithID: coupon, '-delete'.
	driver acceptAlert .
	(Delay forSeconds: 2) wait.
	self assert: (ERReductionTicket find: [ :ticket | ticket id =coupon ]) equals: nil
]

{ #category : #'configurationTicket Tests' }
ERLoggedPageAsAdminTest >> testPressDeleteATicketDismissAlert [
	| coupon|
	coupon := self validCoupon id.
	self moveToTicketsOption.
	self clickElementWithID: coupon, '-delete'.
	driver dismissAlert .
	(Delay forSeconds: 2) wait.
	self assert: (ERReductionTicket find: [ :ticket | ticket id =coupon ]) equals: self validCoupon
]

{ #category : #'configuration Attendees Test' }
ERLoggedPageAsAdminTest >> testPressDeleteAttendeeAcceptAlert [
	| attendee|
	attendee := controller conference attends first.
	self moveToAttendeeOption .
	self clickElementWithID: attendee id, '-delete'.
	driver acceptAlert .
	(Delay forSeconds: 2) wait.
	self assert: (ERAttendee find: [ :ticket | ticket id =attendee id ]) equals: nil
]

{ #category : #'configuration Attendees Test' }
ERLoggedPageAsAdminTest >> testPressDeleteAttendeeDismissAlert [
	| attendee|
	attendee := controller conference attends first.
	self moveToAttendeeOption .
	self clickElementWithID: attendee id, '-delete'.
	driver dismissAlert .
	(Delay forSeconds: 2) wait.
	self assert: (ERAttendee find: [ :ticket | ticket id =attendee id ]) equals: attendee
]

{ #category : #'configuration Group Manager Tests' }
ERLoggedPageAsAdminTest >> testPressDeleteGroupAcceptAlert [
	| group|
	group := controller conference groups first.
	self moveToGroupManagerOption .
	self clickElementWithID: group id, '-delete'.
	driver acceptAlert .
	(Delay forSeconds: 2) wait.
	self assert: (ERGroup find: [ :ticket | ticket id =group id ]) equals: nil
]

{ #category : #'configuration Group Manager Tests' }
ERLoggedPageAsAdminTest >> testPressDeleteGroupDismissAlert [
	| group |
	group := controller conference groups first.
	self moveToGroupManagerOption.
	self clickElementWithID: group id, '-delete'.
	driver dismissAlert .
	(Delay forSeconds: 2) wait.
	self deny: (ERGroup find: [ :ticket | ticket id =group id ]) = nil
]

{ #category : #'configuration Invoices Tests' }
ERLoggedPageAsAdminTest >> testPressDownloadButtonOfInvoice [
	|invoice href|
	self createDownloadDirectory.
	invoice := controller conference invoices first.
	self moveToInvoicesOption.
	href := (driver findElementByID: invoice id, '-export') getAttribute: 'href'.
	self downloadFileOf: href to: ( 'Download' asFileReference ) / 'invoice.pdf'
]

{ #category : #'configurationTicket Tests' }
ERLoggedPageAsAdminTest >> testPressEditTicket [
	| coupon|
	coupon := self validCoupon.
	self moveToTicketsOption.
	self clickElementWithID: coupon id, '-modify'.
	self assert: (self textOfTagName: 'h3') equals: 'Reduction Tickets'.
	self assert: ((driver findElementByID: 'ticketId') getAttribute: 'value')
	equals: coupon ticketId .
]

{ #category : #'configuration Invoices Tests' }
ERLoggedPageAsAdminTest >> testPressExportAllInvoicesButtonOfInvoice [
	
	"| href |
	self moveToInvoicesOption.
	self selectElementWithID: 'exportAllInvoices'.
	(Delay forSeconds: 5) wait.
	href := (driver findElementByID: 'downloadAllInvoices') getAttribute: 'href'.
	self deny: (href = nil)"
]

{ #category : #'configuration Attendees Test' }
ERLoggedPageAsAdminTest >> testPressExportAttendeees [
	| href|
	self createDownloadDirectory.
	self moveToAttendeeOption.
	href := (driver findElementByID: 'exportAttends') getAttribute: 'href'.
	self downloadFileOf: href to: ( 'Download' asFileReference ) / 'attendees.csv'  
]

{ #category : #'configuration Proposals Tests' }
ERLoggedPageAsAdminTest >> testPressExportAwards [
	| href|
	self createDownloadDirectory .
	self moveToAwardsOption .
	href := (driver findElementByID: 'exportAwards') getAttribute: 'href'.
	self downloadFileOf: href to: ( 'Download' asFileReference ) / 'awards.csv'
]

{ #category : #'configuration Group Manager Tests' }
ERLoggedPageAsAdminTest >> testPressExportGroups [
	| href|
	self createDownloadDirectory .
	self moveToGroupManagerOption .
	href := (driver findElementByID: 'exportGroups') getAttribute: 'href'.
	self downloadFileOf: href to: ( 'Download' asFileReference ) / 'groups.csv'
]

{ #category : #'configuration Proposals Tests' }
ERLoggedPageAsAdminTest >> testPressExportTalks [
	| href|
	self createDownloadDirectory .
	self pressOptionProposals .
	href := (driver findElementByID: 'exportTalks') getAttribute: 'href'.
	self downloadFileOf: href to: ( 'Download' asFileReference ) / 'talks.csv'
]

{ #category : #'configuration Users Tests' }
ERLoggedPageAsAdminTest >> testPressExportUsers [
	| href|
	self createDownloadDirectory .
	self pressOptionUsers .
	href := (driver findElementByID: 'exportUsers') getAttribute: 'href'.
	self downloadFileOf: href to: ( 'Download' asFileReference ) / 'users.csv'
]

{ #category : #'configuration Users Tests' }
ERLoggedPageAsAdminTest >> testPressModifyUser [
	| user|
	user := controller conference findUserByEmail: 'ana@gmail.com'.
	self pressOptionUsers.
	self clickElementWithID: user id, '-modify'.
	self assert: (self textOfTagName: 'h3') equals: 'User'
]

{ #category : #'configuration Proposals Tests' }
ERLoggedPageAsAdminTest >> testPressProposalsOption [
	self pressOptionProposals .
	self assert: (self textOfTagName: 'h3') equals: 'Submitted Talks'
]

{ #category : #'configuration Statistics Tests' }
ERLoggedPageAsAdminTest >> testStatisticsView [
	self pressOptionStatistics .
	self assert: (self textOfTagName: 'h3') equals: 'Statistics'.
	self assert: (driver findElementsByTagName: 'table') size equals: 3
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdateAddressStringBankInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'addressStringBank' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'AddressString')
]

{ #category : #'configuration Conference Tests' }
ERLoggedPageAsAdminTest >> testUpdateApiKeyConferenceWithEmptyValue [

	self moveToConferenceOption.
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'apiKey' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Api key')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdateBankPayPalUrlFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'bankPayPalUrl' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'PayPal URL')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdateBicBankInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'bic' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'BIC')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdateCodeBankInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'code' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Code')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdateCounterCodeBankInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'counterCode' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Counter code')
]

{ #category : #'configuration Conference Tests' }
ERLoggedPageAsAdminTest >> testUpdateDateEarlyRegistrationDeadlineConferenceWithWrongFormat [
	
	self moveToConferenceOption.
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'earlyRegistrationDeadline' with: '10/10/dsfd' .
	self assert: self getTextOfError equals: (self messageWrongDateFormatFor: 'Early Registration Deadline (Required)')
]

{ #category : #'configuration Conference Tests' }
ERLoggedPageAsAdminTest >> testUpdateDateFromConference [
	self moveToConferenceOption.
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'dateFrom' with: '10/10/2019' .
	self assert: controller conference configuration dateFrom equals: '10/10/2019' 
]

{ #category : #'configuration Conference Tests' }
ERLoggedPageAsAdminTest >> testUpdateDateFromConferenceWithHigherDateThanDateTo [
	self moveToConferenceOption.
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'dateFrom' with: '12/05/2020'.
	self assert: (self textOfElementWithID: 'formConferenceConfigurationAlert' ) equals: ERException invalidEsugDates messageText
]

{ #category : #'configuration Conference Tests' }
ERLoggedPageAsAdminTest >> testUpdateDateFromConferenceWithWrongFormat [
	self moveToConferenceOption.
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'dateFrom' with: '10/10/dsfd'.
	self assert: self getTextOfError equals: ( self messageWrongDateFormatFor: 'From (Required)')
]

{ #category : #'configuration Conference Tests' }
ERLoggedPageAsAdminTest >> testUpdateDateSubmissionDeadlineConferenceWithWrongFormat [
	self moveToConferenceOption.
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'dateSubmissionDeadline' with: '10/10/dsfd'.
	self assert: self getTextOfError equals: (self messageWrongDateFormatFor:'Submission Deadline (Required)')
]

{ #category : #'configuration Conference Tests' }
ERLoggedPageAsAdminTest >> testUpdateDateToConferenceWithWrongFormat [
	
	self moveToConferenceOption.
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'dateTo' with: '10/10/dsfd' .
	self assert: self getTextOfError equals: (self messageWrongDateFormatFor: 'To (Required)')
]

{ #category : #'configuration Conference Tests' }
ERLoggedPageAsAdminTest >> testUpdateDescriptionConference [
	| newValue |
	newValue := 'The European Smalltalk User Group (ESUG) is a non-profit users organization that supports all kinds of Smalltalk initiatives, especially free-open source ones that benefit the whole Smalltalk community'.
	self moveToConferenceOption.
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'description' with: newValue .
	self assert: controller conference configuration description equals: newValue 
]

{ #category : #'configuration Conference Tests' }
ERLoggedPageAsAdminTest >> testUpdateHomePageUrlConference [
	| newValue |
	newValue := 'http://www.esug.org/wiki/'.
	self moveToConferenceOption.
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'homePageUrl' with: newValue .
	self assert: controller conference configuration homePageUrl equals: newValue 
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdateIbanBankAccountInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'iban' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Iban')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdateNameBankInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'nameBank' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Name')
]

{ #category : #'configuration Conference Tests' }
ERLoggedPageAsAdminTest >> testUpdateNameConferenceWithEmptyValue [
	
	self moveToConferenceOption.
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'name' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Name')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdateNumberBankAccountInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'number' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Number')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdateOwnerBankAccountInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'owner' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Owner')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdatePaypalCommisionFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'payPalCommissionPercentage' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Paypal Commission Percentage')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdatePaypalCommisionFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'payPalCommissionPercentage' with: 'One' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'Paypal Commission Percentage')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdatePriceForAddPersonFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'extraPersonSD' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Price for add person to the Social Dinner')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdatePriceForAddPersonFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'extraPersonSD' with: 'One' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'Price for add person to the Social Dinner')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdatePriceForEarlyAllDaysFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'erfAllDaysFee' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'All Days Fee')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdatePriceForEarlyAllDaysFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'erfAllDaysFee' with: 'asdf' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'All Days Fee')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdatePriceForEarlyOneDayFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'erfOneDayFee' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'One Day Fee')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdatePriceForEarlyOneDayFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'erfOneDayFee' with: 'One' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'One Day Fee')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdatePriceForLateAllDaysFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'lrfAllDaysFee' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'All Days Fee')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdatePriceForLateAllDaysFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'lrfAllDaysFee' with: 'One' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'All Days Fee')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdatePriceForLateOneDayFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'lrfOneDayFee' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'One Day Fee')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdatePriceForLateOneDayFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'lrfOneDayFee' with: 'One' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'One Day Fee')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdateRibKeyBankAccountInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'ribKey' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Rib Key')
]

{ #category : #'configuration Conference Tests' }
ERLoggedPageAsAdminTest >> testUpdateSenderEmailAddressConferenceWithEmptyValue [
	self moveToConferenceOption.
	acceptFormButton := 'acceptConferenceConfiguration'.
	self updateField: 'senderEmailAddress' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Sender email address')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdateStaticCommisionPaypalFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'staticCommissionPaypal' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Static Commission Paypal')
]

{ #category : #'configuration Fee Tests' }
ERLoggedPageAsAdminTest >> testUpdateStaticCommisionPaypalFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self updateField: 'staticCommissionPaypal' with: 'One' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'Static Commission Paypal')
]

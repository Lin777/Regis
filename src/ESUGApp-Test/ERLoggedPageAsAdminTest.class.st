Class {
	#name : #ERLoggedPageAsAdminTest,
	#superclass : #ERParasolTest,
	#instVars : [
		'acceptFormButton'
	],
	#category : #'ESUGApp-Test-Parasol'
}

{ #category : #tests }
ERLoggedPageAsAdminTest >> getNameOfConference [
	^ ERController new conference configuration name 
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

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> moveToFeeOption [
	self pressOptionConfiguration .
	self selectFeeTab .
]

{ #category : #configurationInvoicesTests }
ERLoggedPageAsAdminTest >> moveToTicketsOption [
	self pressOptionConfiguration .
	self selectTicketTab .
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> pressEditUser [
	| user|
	user := controller findUserByEmail: 'ana@gmail.com'.
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

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> selectFeeTab [
	(driver findElementByID: 'tab-Fee') click.
]

{ #category : #configurationInvoicesTests }
ERLoggedPageAsAdminTest >> selectInovicesTab [

	(driver findElementByID: 'tab-Invoices') click.
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

{ #category : #configurationInvoicesTests }
ERLoggedPageAsAdminTest >> testCheckHasPaidInvoice [
	|delete invoice|
	invoice := controller invoices first.
	self moveToTicketsOption.
	delete := driver findElementByID: invoice id, '-hasPaid'.
	delete click.
	self assert: (controller invoices first paymentInformation hasPaid)
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testDeleteUserAcceptAlert [
	|delete user|
	user := controller findUserByEmail: 'ana@gmail.com'.
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
	user := controller findUserByEmail: 'admin@esug.org'.
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
	user := controller findUserByEmail: 'ana@gmail.com'.
	self pressOptionUsers .
	delete := driver findElementByID: user id, '-delete'.
	delete click.
	driver dismissAlert .
	(Delay forSeconds: 2) wait.
	self assert: 
		(ERUserAccount find: [ :anUser | anUser id =user id ]) equals: user
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testEditUserWithAnEmailAlreadyRegistered [
	self pressEditUser .
	acceptFormButton := 'accept-change-affiliation'.
	self update: 'email' with: 'admin@esug.org'.
	self assert: (driver findElementByID: 'formAlert') getText equals: 
		ERException emailAlreadyRegistered messageText 
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testEditUserWithEmptyEmail [
	self pressEditUser .
	acceptFormButton := 'accept-change-affiliation'.
	self update: 'email' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'Email')
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testEditUserWithEmptyLastName [
	self pressEditUser .
	acceptFormButton := 'accept-change-affiliation'.
	self update: 'lastName' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'Last Name')
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testEditUserWithEmptyName [
	self pressEditUser .
	acceptFormButton := 'accept-change-affiliation'.
	self update: 'firstName' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'First Name')
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testPressCancelModifyUserAfterChange [
	|cancel user userUpdate|
	user := controller findUserByEmail: 'ana@gmail.com'.
	self pressOptionUsers.
	(driver findElementByID: user id, '-modify') click.
	acceptFormButton := 'accept-change-affiliation'.
	self update: 'email' with: ''.
	(driver findElementByID: 'cancelButton') click.
	self assert: ((driver findElementByID: 'buttonClose-dialog') getAttribute: 'open') equals: 'true'.
	cancel := (driver findElementByClassName: 'mdl-dialog__actions') findElementByTagName: 'a'.
	cancel click.
	userUpdate := ERUserAccount detect: [ :each | each id = user id].
	self deny: userUpdate email equals: ''
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

{ #category : #configurationInvoicesTests }
ERLoggedPageAsAdminTest >> testPressDownloadButtonOfInvoice [
	|delete invoice|
	invoice := controller invoices first.
	self moveToTicketsOption.
	delete := driver findElementByID: invoice id, '-export'.
	delete click.
	(Delay forSeconds: 2) wait.
	
	"self assert: (controller invoices first paymentInformation hasPaid)"
	
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
	|button |
	
	self moveToTicketsOption.
	button := driver findElementByID: 'exportAllInvoices'.
	button click.
	"(Delay forSeconds: 2) wait.
	self deny: 
	((driver findElementByID: 'downloadAllInvoices') isDisabled)"
]

{ #category : #configurationUsersTests }
ERLoggedPageAsAdminTest >> testPressModifyUser [
	|update user|
	user := controller findUserByEmail: 'ana@gmail.com'.
	self pressOptionUsers.
	update := driver findElementByID: user id, '-modify'.
	update click.
	self assert: (driver findElementByTagName: 'h3') getText equals: 
	'User'
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateAddressStringBankInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'addressStringBank' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'AddressString')
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateApiKeyConferenceWithEmptyValue [

	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self update: 'apiKey' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Api key')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateBankPayPalUrlFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'bankPayPalUrl' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'PayPal URL')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateBicBankInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'bic' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'BIC')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateCodeBankInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'code' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Code')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateCounterCodeBankInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'counterCode' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Counter code')
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateDateEarlyRegistrationDeadlineConferenceWithWrongFormat [
	
	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self update: 'earlyRegistrationDeadline' with: '10/10/dsfd' .
	self assert: self getTextOfError equals: (self messageWrongDateFormatFor: 'Early Registration Deadline (Required)')
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateDateFromConference [
	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self update: 'dateFrom' with: '10/10/2019' .
	self assert: ERController new conference configuration dateFrom equals: '10/10/2019' 
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateDateFromConferenceWithWrongFormat [
	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self update: 'dateFrom' with: '10/10/dsfd'.
	self assert: self getTextOfError equals: ( self messageWrongDateFormatFor: 'From (Required)')
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateDateSubmissionDeadlineConferenceWithWrongFormat [
	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self update: 'dateSubmissionDeadline' with: '10/10/dsfd'.
	self assert: self getTextOfError equals: (self messageWrongDateFormatFor:'Submission Deadline (Required)')
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateDateToConferenceWithWrongFormat [
	
	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self update: 'dateTo' with: '10/10/dsfd' .
	self assert: self getTextOfError equals: (self messageWrongDateFormatFor: 'To (Required)')
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateDescriptionConference [
	| newValue|
	newValue := 'The European Smalltalk User Group (ESUG) is a non-profit users organization that supports all kinds of Smalltalk initiatives, especially free-open source ones that benefit the whole Smalltalk community'.
	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self update: 'description' with: newValue .
	self assert: ERController new conference configuration description equals: newValue 
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateHomePageUrlConference [
	| newValue|
	newValue := 'http://www.esug.org/wiki/'.
	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self update: 'homePageUrl' with: newValue .
	self assert: ERController new conference configuration homePageUrl equals: newValue 
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateIbanBankAccountInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'iban' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Iban')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateNameBankInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'nameBank' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Name')
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateNameConferenceWithEmptyValue [
	
	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self update: 'name' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Name')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateNumberBankAccountInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'number' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Number')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateOwnerBankAccountInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'owner' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Owner')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePaypalCommisionFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'payPalCommissionPercentage' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Paypal Commission Percentage')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePaypalCommisionFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'payPalCommissionPercentage' with: 'One' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'Paypal Commission Percentage')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePriceForAddPersonFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'extraPersonSD' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Price for add person to the Social Dinner')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePriceForAddPersonFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'extraPersonSD' with: 'One' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'Price for add person to the Social Dinner')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePriceForEarlyAllDaysFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'erfAllDaysFee' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'All Days Fee')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePriceForEarlyAllDaysFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'erfAllDaysFee' with: 'asdf' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'All Days Fee')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePriceForEarlyOneDayFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'erfOneDayFee' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'One Day Fee')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePriceForEarlyOneDayFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'erfOneDayFee' with: 'One' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'One Day Fee')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePriceForLateAllDaysFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'lrfAllDaysFee' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'All Days Fee')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePriceForLateAllDaysFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'lrfAllDaysFee' with: 'One' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'All Days Fee')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePriceForLateOneDayFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'lrfOneDayFee' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'One Day Fee')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdatePriceForLateOneDayFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'lrfOneDayFee' with: 'One' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'One Day Fee')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateRibKeyBankAccountInfoFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'ribKey' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Rib Key')
]

{ #category : #configurationConferenceTests }
ERLoggedPageAsAdminTest >> testUpdateSenderEmailAddressConferenceWithEmptyValue [
	self pressOptionConfiguration .
	acceptFormButton := 'acceptConferenceConfiguration'.
	self update: 'senderEmailAddress' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Sender email address')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateStaticCommisionPaypalFeeWithEmptyValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'staticCommissionPaypal' with: '' .
	self assert: self getTextOfError equals: (self messageIsRequiredFor: 'Static Commission Paypal')
]

{ #category : #configurationFeeTests }
ERLoggedPageAsAdminTest >> testUpdateStaticCommisionPaypalFeeWithNoNumericValue [

	self moveToFeeOption.
	acceptFormButton := 'acceptTabFees'.
	self update: 'staticCommissionPaypal' with: 'One' .
	self assert: self getTextOfError equals: (self messageInvalidInputFor: 'Static Commission Paypal')
]

{ #category : #tests }
ERLoggedPageAsAdminTest >> update: anID with: aString [
	| confName acceptButton |
	confName := driver findElementByID: anID.
	confName clear.
	confName sendKeys: aString.
	acceptButton := driver findElementByID: acceptFormButton.
	acceptButton click.
]

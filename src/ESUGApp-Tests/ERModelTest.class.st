Class {
	#name : #ERModelTest,
	#superclass : #ERTest,
	#instVars : [
		'messageInputRequired'
	],
	#category : #'ESUGApp-Tests-UnitTest'
}

{ #category : #accessing }
ERModelTest class >> testBankAccountInfo [
	^ ERBankAccountInformation new
		owner: 'ESUG - EUROPEAN SMALLTALK USERS GROUP';
		number: 'W751167780';
		iban: 'FR76 1562 9027 0100 0433 0600 144';
		ribKey: '44';
		bankInformation: self testBankinfo;
		yourself
]

{ #category : #accessing }
ERModelTest class >> testBankinfo [
	^ ERBankInformation new
				name: 'Crédit Mutuel Nord Europe';
				code: '15629';
				counterCode: '02701';
				bic: 'CMCIFR2A';
				addressString:
					'CCM Douai
92 rue de Paris
59500 Douai';
yourself
]

{ #category : #accessing }
ERModelTest class >> testConference [
	
	self deprecated: 'Use conference instead'.
	
	^ ERConference new
		configuration: self class testConferenceConfigurationModel;
		yourself
]

{ #category : #accessing }
ERModelTest class >> testConferenceConfigurationModel [
	^ ERConferenceConfigurationModel new
		organizer: self testConferenceOrganizer;
		name: 'ESUG';
		description: 'ESUG International Smalltalk Conference';
		homePageUrl: 'http://www.esug.org/wiki/pier/Conferences/2018/';
		dateFrom: '09/10/2019';
		dateTo: '09/14/2019';
		dateSubmissionDeadline:  '09/14/2019';
		earlyRegistrationDeadline: '07/25/2019';
		emailConfiguration: self testConferenceEmailConfiguration ;
		yourself
]

{ #category : #accessing }
ERModelTest class >> testConferenceEmailConfiguration [
	^ ERConferenceEmailConfiguration new
		senderEmailAddress: 'registration@esug.org';
		apiKey: 'xxxxx';
		welcomeText: 'Welcome to this great conference';
		yourself
]

{ #category : #accessing }
ERModelTest class >> testConferenceOrganizer [
	^ ERConferenceOrganizer new
		name: 'ESUG';
		fiscalSituation: 'Association Loi 1901 n°W751167780 (not subjected to  V.A.T.)';
		webPageUrl: 'http://www.esug.org';
		addressString:
			'c/o Mr. Stéphane Ducasse - 1 rue Cesar Franck 59800 Lille - France';
		yourself
]

{ #category : #accessing }
ERModelTest class >> testFee [
	^ ERFee new
		erfAllDaysFee: 470;
		erfOneDayFee: 170;
		lrfAllDaysFee: 660;
		lrfOneDayFee: 210;
		extraPersonSD: 50;
		currency: 'Euro';
		payPalCommissionPercentage: 5.4;
		staticCommissionPaypal: 0.3;
		creditCardCommissionPercentage: 0.1;
		bankAccountInformation: self testBankAccountInfo;
		bankPayPalUrl:
			'https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=board%40esug.org&item_name=ESUG+Conference+Registration&item_number=[INVOICENUMBER]&amount=[AMOUNT]&no_shipping=1&no_note=1&currency_code=EUR&charset=UTF-8';
		yourself
]

{ #category : #accessing }
ERModelTest class >> testUserExampleAccount [

	^ ERUserAccount new
		email: 'example@gmail.com';
		firstName: 'Example';
		lastName: 'Example';
		password: (ERUserAccount hashPassword: '12345678') asString;
		yourself
]

{ #category : #assertions }
ERModelTest >> assertEmptyField: anObject [

	|errors|
	errors := anObject asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (self messageTextOf: errors)
]

{ #category : #assertions }
ERModelTest >> assertNonValidField: anObject [

	|errors|
	errors := anObject asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: self messageInvalidInput equals: (self messageTextOf: errors)
]

{ #category : #messages }
ERModelTest >> messageInvalidInput [
	^ 'Invalid input given'
]

{ #category : #messages }
ERModelTest >> messageTextField [
	^ 'This field only accept a text'
]

{ #category : #messages }
ERModelTest >> messageTextOf: errors [
	^ ((errors at:1) collection at:1) messageText
]

{ #category : #running }
ERModelTest >> setUp [
	super setUp.
	messageInputRequired := 'Input is required but no input given'
]

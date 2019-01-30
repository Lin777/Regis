Class {
	#name : #ERTestControllers,
	#superclass : #TestCase,
	#instVars : [
		'store'
	],
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestControllers class >> testAttendee [
	^ ERAttendee new
		userAccount: self testUserAccount;
		orgName: 'testOrgName';
		orgAddrees1: 'testAddress1';
		orgAddrees2: 'testAddress2';
		orgCity: 'testCity';
		orgCountry: 'Bolivia';
		orgProvince: 'testProvince';
		orgPostal: '0000';
		membershipType: 'Student';
		keywords: 'test test test';
		additionalText: 'test test test';
		address: 'testAddress';
		address2: 'testAddress2';
		city: 'testCity';
		country: 'Bolivia';
		postal: '0000';
		province: 'test';
		facebookURL: '';
		twitterURL: '';
		homePage: '';
		foodPreference: 'Normal';
		attendSocialEvent: true;
		addedToMainList: true;
		tshirtSize: 'XL';
		attendance:
			(Dictionary
				newFrom:
					{('monday' -> true).
					('tuesday' -> true).
					('wednesday' -> false).
					('thursday' -> false).
					('friday' -> true)});
		gender: 'Male';
		paymentType: 'Bank transfer';
		paymentCurrency: 'Euro';
		coupon: '';
		yourself
]

{ #category : #tests }
ERTestControllers class >> testExampleAttendee [
	^ ERAttendee new
		userAccount: self testUserExampleAccount;
		orgName: 'exampleOrgName';
		orgAddrees1: 'exampleAddress1';
		orgAddrees2: 'exampleAddress2';
		orgCity: 'exampleCity';
		orgCountry: 'Bolivia';
		orgProvince: 'exampleProvince';
		orgPostal: '0000';
		membershipType: 'Student';
		keywords: 'example example example';
		additionalText: 'example example example';
		address: 'exampleAddress';
		address2: 'exampleAddress2';
		city: 'exampletCity';
		country: 'Bolivia';
		postal: '0000';
		facebookURL: '';
		twitterURL: '';
		homePage: '';
		foodPreference: 'Normal';
		attendSocialEvent: true;
		addedToMainList: true;
		tshirtSize: 'XL';
		attendance:
			(Dictionary
				newFrom:
					{('monday' -> true).
					('tuesday' -> true).
					('wednesday' -> false).
					('thursday' -> false).
					('friday' -> true)});
		gender: 'Male';
		paymentType: 'Bank transfer';
		paymentCurrency: 'Dollar';
		coupon: '';
		yourself
]

{ #category : #tests }
ERTestControllers class >> testGroupManager [
	^ ERAttendee new
		userAccount: self testUserAccount;
		orgName: 'testOrgName';
		orgAddrees1: 'testAddress1';
		orgAddrees2: 'testAddress2';
		orgCity: 'testCity';
		orgCountry: 'Bolivia';
		orgProvince: 'testProvince';
		orgPostal: '0000';
		membershipType: 'Student';
		yourself
]

{ #category : #tests }
ERTestControllers class >> testModifyUser [
	^ ERUserAccount new
		firstName: 'userModify';
		lastName: 'usermodify';
		email: 'userModify@gmail.com';
		yourself 
]

{ #category : #tests }
ERTestControllers class >> testUserAccount [
	^ ERUserAccount new
		email: 'test@gmail.com';
		firstName: 'Test';
		lastName: 'Test';
		password: (ERUserAccount hashPassword: '12345678') asString;
		yourself
]

{ #category : #tests }
ERTestControllers class >> testUserExampleAccount [
	^ ERUserAccount new
		email: 'example@gmail.com';
		firstName: 'Example';
		lastName: 'Example';
		password: (ERUserAccount hashPassword: '12345678') asString;
		yourself
]

{ #category : #tests }
ERTestControllers >> defaultStore [
	^ SDMemoryStore new
]

{ #category : #rendering }
ERTestControllers >> registerAsGroupManager [
	^ (ERRegistrationController
		attendee: ERTestControllers testAttendee) saveAsGroupManager
]

{ #category : #rendering }
ERTestControllers >> registerAttendee [
	^ (ERRegistrationController
		attendee: ERTestControllers testAttendee) save
]

{ #category : #rendering }
ERTestControllers >> registerAttendee: anAttendee [
	^ (ERRegistrationController attendee: anAttendee)
		save
]

{ #category : #tests }
ERTestControllers >> setUp [
	store := self defaultStore.
	SDActiveRecord setStore: store.
	ERUserAccount warmUp.
	ERAttendee warmUp.
	ERUserAccount1 warmUp.
	ERAttendee1 warmUp.
	ERAward warmUp.
	ERBankInformation warmUp.
	ERBankAccountInformation warmUp.
	ERDiscountStrategy warmUp.
	ERFixDiscount warmUp.
	ERPercentageDiscount warmUp.
	ERLimitStrategy warmUp.
	ERLimitedReductionTicketUse warmUp.
	ERUnlimitedReductionTicketUse warmUp.
	ERReductionTicket warmUp.
	ERFee warmUp.
	ERGroup warmUp.
	ERTalk warmUp.
	ERConferenceOrganizer warmUp.
	ERConferenceEmailConfiguration warmUp.
	ERConferenceConfigurationModel warmUp.
	ERConference warmUp.
	ERSandstoneDatabase initialize.
	ESUGSetUp start
]

{ #category : #running }
ERTestControllers >> tearDown [
	ERAttendee
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERAttendee coolDown.
	ERAttendee1
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERAttendee1 coolDown.
	ERAward
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERAward coolDown.
	ERBankInformation
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERBankInformation coolDown.
	ERBankAccountInformation
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERBankAccountInformation coolDown.
	ERDiscountStrategy
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERDiscountStrategy coolDown.
	ERFixDiscount
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERFixDiscount coolDown.
	ERPercentageDiscount
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERPercentageDiscount coolDown.
	ERLimitStrategy
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERLimitStrategy coolDown.
	ERLimitedReductionTicketUse
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERLimitedReductionTicketUse coolDown.
	ERUnlimitedReductionTicketUse
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERUnlimitedReductionTicketUse coolDown.
	
	ERFee
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERFee coolDown.
	ERGroup
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERGroup coolDown.
	ERReductionTicket
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERReductionTicket coolDown.
	ERTalk
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERTalk coolDown.
	ERUserAccount
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERUserAccount coolDown.
	ERUserAccount1
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERUserAccount1 coolDown.
	ERConferenceOrganizer
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERConferenceOrganizer coolDown.
	ERConferenceEmailConfiguration
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERConferenceEmailConfiguration coolDown.
	ERConferenceConfigurationModel
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERConferenceConfigurationModel coolDown.
	ERConference
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERConference coolDown.
	ESUGSetUp stop.
	Smalltalk garbageCollectMost
]

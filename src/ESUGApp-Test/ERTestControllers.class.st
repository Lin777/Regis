Class {
	#name : #ERTestControllers,
	#superclass : #TestCase,
	#instVars : [
		'store'
	],
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestControllers class >> testAdditionalInformation [
	^ ERAdditionalInformation new
		keywords: 'test test test';
		additionalText: 'test test test';
		yourself
]

{ #category : #tests }
ERTestControllers class >> testAffiliationInformation [
	^ ERAffiliationInformation new
		organizationName: 'testOrgName';
		organizationAddrees1: 'testAddress1';
		organizationAddrees2: 'testAddress2';
		organizationCity: 'testCity';
		organizationCountry: 'Bolivia';
		organizationProvince: 'testProvince';
		organizationPostal: '0000';
		membershipType: 'Student';
		yourself
]

{ #category : #tests }
ERTestControllers class >> testAttendee [
	^ ERAttendee new
		userAccount: self testUserAccount;
		contactInformation: self testContactInformation ;
		conferenceInformation: self testRegisterConferenceInformation ;
		affiliationInformation: self testAffiliationInformation ;
		additionalInformation: self testAdditionalInformation ;
		paymentInformation: self testPaymentInformation ;
		yourself
]

{ #category : #tests }
ERTestControllers class >> testContactInformation [
	^ ERContactInformation new
		address: 'testAddress';
		address2: 'testAddress2';
		city: 'testCity';
		country: 'Bolivia';
		postal: '0000';
		province: 'test';
		facebookURL: 'https://es-la.facebook.com/login/example';
		twitterURL: 'https://es-la.twitter.com/login/example';
		homePageURL: 'https://medium.com/espanol/example';
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
ERTestControllers class >> testPaymentInformation [
	^ ERPaymentInformation new
		paymentType: 'Bank transfer';
		paymentCurrency: 'Euro';
		coupon: '';
		yourself
]

{ #category : #tests }
ERTestControllers class >> testRegisterConferenceInformation [
	^ ERRegisterConferenceInformation new
		attendSocialEvent: true;
		addedToMainList: true;
		foodPreference: 'Normal';
		addPersonToSocialDinner: false;
		personAddedFoodPreference: 'Normal';
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
		yourself
]

{ #category : #tests }
ERTestControllers class >> testUserAccount [
	^ ERUserAccount new
		email: 'test@gmail.com';
		firstName: 'Test';
		lastName: 'Test';
		password: '12345678';
		confirmPassword: '12345678';
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
		attendee: ERTestControllers testAttendee) saveGroupManager
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
	ERAward warmUp.
	ERReductionTicket warmUp.
	ERFee warmUp.
	ERGroup warmUp.
	ERTalk warmUp.
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
	ERAward
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERAward coolDown.	
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
	ERConference
		do: [ :each | 
			[ each delete ]
				on: Error
				do: [  ] ].
	ERConference coolDown.
	ESUGSetUp stop.
	Smalltalk garbageCollectMost
]

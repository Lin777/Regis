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
		contactInformation: self testContactInformation ;
		conferenceInformation: self testRegisterConferenceInformation ;
		affiliationInformation: self testAffiliationInformation ;
		additionalInformation: self testAdditionalInformation ;
		paymentInformation: self testPaymentInformation ;
		yourself
]

{ #category : #tests }
ERTestControllers class >> testGroupManager [
	^ ERGroupManager new
		userAccount: self testUserAccount asGroupManager;
		affiliationInformation: self testAffiliationInformation;
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
		password: '12345678';
		confirmPassword: '12345678';
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
	^ (ERRegistrationController new attendee: self class testAttendee) saveAttendee 
	
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

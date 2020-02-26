Class {
	#name : #ERTest,
	#superclass : #TestCase,
	#instVars : [
		'store',
		'controller'
	],
	#category : #'ESUGApp-Test-UnitTest'
}

{ #category : #tests }
ERTest class >> generateDataForTest [
	self new
	 registerAttendees:#('ana@gmail.com' 'juan@gmail.com' 'lucas@gmail.com' 'michael@gmail.com');
		registerGroupWithGroupManager: 'andrew@gmail.com' 
			listOfAttendees: #('milton@gmail.com' 'david@gmail.com' 'anne@gmail.com' 'jess@gmail.com' );
		registerGroupWithGroupManager: 'lesly@gmail.com' 
			listOfAttendees: #('mary@gmail.com' 'josh@gmail.com' 'mike@gmail.com' 'nil@gmail.com' 'jenny@gmail.com').

]

{ #category : #tests }
ERTest class >> testAdditionalInformation [
	^ ERAdditionalInformation new
		keywords: 'test test test';
		additionalText: 'test test test';
		yourself
]

{ #category : #tests }
ERTest class >> testAffiliationInformation [
	^ ERBillingInformation new
		organizationName: 'testOrgName';
		organizationAddrees1: 'testAddress1';
		organizationAddrees2: 'testAddress2';
		organizationCity: 'testCity';
		organizationCountry: 'Bolivia';
		organizationProvince: 'testProvince';
		organizationPostal: '0000';
		membershipType: 'Academic';
		yourself
]

{ #category : #tests }
ERTest class >> testAttendee [
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
ERTest class >> testAttendee: email [
	^ ERAttendee new
		userAccount: (self testUserAccount: email);
		contactInformation: self testContactInformation ;
		conferenceInformation: self testRegisterConferenceInformation ;
		affiliationInformation: self testAffiliationInformation ;
		additionalInformation: self testAdditionalInformation ;
		paymentInformation: self testPaymentInformation ;
		yourself
]

{ #category : #tests }
ERTest class >> testAward: anAttendee [
	^ (ERAward submitter: anAttendee) 
			nameAward: 'testAward';
			smalltalkDialect: 'English';
			affiliation: 'Test Org.';
			country: nil;
			downloadUrl: 'https://www.webpagetest.org/';
			demoUrl: 'https://www.webpagetest.org/';
			keywords: 'test, test, test, test';
			licence: 'MIT';
			otherDevelopers: 'Test Dev, Test1 Dev';
			submittionDate: Date today;
			yourself 
			
			
]

{ #category : #tests }
ERTest class >> testContactInformation [
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
ERTest class >> testExampleAttendee [
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
ERTest class >> testGroupManager [
	^ ERGroupManager new
		userAccount: (self testUserAccount: 'groupManager@gmail.com') asGroupManager;
		affiliationInformation: self testAffiliationInformation;
		yourself
]

{ #category : #tests }
ERTest class >> testGroupManager: aString [
	^ ERGroupManager new
		userAccount: (self testUserAccount: aString) asGroupManager;
		affiliationInformation: self testAffiliationInformation;
		yourself
]

{ #category : #tests }
ERTest class >> testPaymentInformation [
	^ ERPaymentInformation new
		paymentType: 'Bank transfer';
		paymentCurrency: 'Euro';
		coupon: nil;
		yourself
]

{ #category : #tests }
ERTest class >> testRegisterConferenceInformation [
	^ ERRegisterConferenceInformation new
		attendSocialEvent: true;
		addedToMainList: true;
		foodPreference: 'Normal';
		addPersonToSocialDinner: true;
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
ERTest class >> testTalk: anAttendee [
	^ (ERTalk submitter: anAttendee) 
			name: 'Talk test';
			description: 'Description test';
			presentation: 'https://www.google.com/';
			authorsWithoutSubmitter: nil;
			submittionDate: Date today;
			yourself 
			
			
]

{ #category : #tests }
ERTest class >> testUserAccount [
	^ ERUserAccount new
		email: 'test@gmail.com';
		firstName: 'Test';
		lastName: 'Test';
		password: '12345678';
		confirmPassword: '12345678';
		yourself
]

{ #category : #tests }
ERTest class >> testUserAccount: email [
	^ ERUserAccount new
		email: email;
		firstName: (email substrings: '@') first capitalized;
		lastName: (email substrings: '@') first capitalized;
		password: '12345678';
		confirmPassword: '12345678';
		yourself
]

{ #category : #tests }
ERTest class >> testUserExampleAccount [
	^ ERUserAccount new
		email: 'example@gmail.com';
		firstName: 'Example';
		lastName: 'Example';
		password: '12345678';
		confirmPassword: '12345678';
		yourself
]

{ #category : #tests }
ERTest >> defaultStore [
	^ SDMemoryStore new
]

{ #category : #modifying }
ERTest >> deleteAll [ 	
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
]

{ #category : #running }
ERTest >> deleteBackupFolderIfExist [
	self deleteFolder: 'Backup'
]

{ #category : #running }
ERTest >> deleteDownloadFolderIfExist [
	|path|
	path := ('Download' asFileReference ).
	path exists ifTrue:
		 [ path deleteAll ] 
]

{ #category : #running }
ERTest >> deleteFolder: aString [
	|path|
	path := (Smalltalk imageDirectory / aString).
	path exists ifTrue:
		 [ path deleteAll ] .
]

{ #category : #accesing }
ERTest >> groupOfUser: anUser [
	^ ERController new conference groupOfUser: anUser.
]

{ #category : #'test registration' }
ERTest >> registerAsGroupManager [
	^ (ERRegistrationController
		attendee: self class testGroupManager) saveGroupManager
]

{ #category : #'test registration' }
ERTest >> registerAsGroupManager: email [
	^ (ERRegistrationController
		attendee: (self class testGroupManager: email)) saveGroupManager
]

{ #category : #'test registration' }
ERTest >> registerAttendee [
	^ (ERRegistrationController attendee:
			 self class testAttendee) saveAttendee 
]

{ #category : #'test registration' }
ERTest >> registerAttendee: anAttendee [
	^ (ERRegistrationController attendee: anAttendee)
		saveAttendee
]

{ #category : #'test registration' }
ERTest >> registerAttendees: aList [
	aList do: [ :email | self registerAttendee: (self class testAttendee: email) ]
]

{ #category : #'test registration' }
ERTest >> registerGroup [
	|user group aController|
	user := self registerAsGroupManager .
	group := self groupOfUser: user.
	aController := ERGroupManagerController new group: group.
	aController addAttendee: (self class testAttendee: 'test1@gmail.com').
	aController addAttendee: (self class testAttendee: 'test2@gmail.com').
	aController addAttendee: (self class testAttendee: 'test3@gmail.com').
	^ group
]

{ #category : #'test registration' }
ERTest >> registerGroupWithGroupManager: aString listOfAttendees: aList [
	|user group aController|
	user := self registerAsGroupManager: aString.
	group := self groupOfUser: user.
	aController := ERGroupManagerController new group: group.
	aList do: [ :each | aController addAttendee: (self class testAttendee: each) ].
	^ group
]

{ #category : #tests }
ERTest >> setUp [
	store := self defaultStore.
	ESUGActiveRecord setStore: store.
	ERUserAccount warmUp.
	ERAttendee warmUp.
	ERAward warmUp.
	ERReductionTicket warmUp.
	ERFee warmUp.
	ERGroup warmUp.
	ERTalk warmUp.
	ERConference warmUp.
	ERDatabase initialize.
	ESUGSetUp start.
	controller := ERController new.
]

{ #category : #running }
ERTest >> tearDown [
	self deleteAll.
	ESUGSetUp stop.
	"Delete folder backup"
	self deleteBackupFolderIfExist.
	Smalltalk garbageCollectMost
]

{ #category : #accesing }
ERTest >> validCoupon [
	^ controller conference reductionTickets first 
]

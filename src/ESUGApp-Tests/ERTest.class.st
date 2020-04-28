Class {
	#name : #ERTest,
	#superclass : #TestCase,
	#instVars : [
		'store',
		'controller'
	],
	#category : #'ESUGApp-Tests-UnitTest'
}

{ #category : #tests }
ERTest class >> generateDataForTest [

	self new
	 registerAttendees:#('ana@gmail.com' 'juan@gmail.com' 'lucas@gmail.com' 'michael@gmail.com');
	registerGroupWithGroupManager: 'andrew@gmail.com' listOfAttendees: #('milton@gmail.com' 'david@gmail.com' 'anne@gmail.com' 'jess@gmail.com' );
	registerGroupWithGroupManager: 'lesly@gmail.com' listOfAttendees: #('mary@gmail.com' 'josh@gmail.com' 'mike@gmail.com' 'nil@gmail.com' 'jenny@gmail.com').

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
ERTest class >> testAffiliationInformationWith: anEmail [

	^ ERBillingInformation new
		organizationName: 'testOrgName', (anEmail substrings: '@') first capitalized;
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
		contactInformation: self testContactInformation;
		conferenceInformation: self testRegisterConferenceInformation;
		affiliationInformation: self testAffiliationInformation;
		additionalInformation: self testAdditionalInformation;
		paymentInformation: self testPaymentInformation;
		yourself
]

{ #category : #tests }
ERTest class >> testAttendee: email [

	^ ERAttendee new
		userAccount: (self testUserAccount: email);
		conferenceInformation: self testContactInformation;
		affiliationInformation: (self testAffiliationInformationWith: email);
		conferenceInformation: self testRegisterConferenceInformation;
		additionalInformation: self testAdditionalInformation;
		paymentInformation: self testPaymentInformation;
		yourself
]

{ #category : #tests }
ERTest class >> testAttendee: email withGroup: aGroup [

	^ ERAttendee new
		userAccount: (self testUserAccount: email);
		contactInformation: aGroup contactInformation copy;
		affiliationInformation: aGroup affiliationInformation copy;
		conferenceInformation: self testRegisterConferenceInformation;
		additionalInformation: self testAdditionalInformation;
		paymentInformation: aGroup paymentInformation copy;
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

	^ ERGroup new
		userAccount: (self testUserAccount: 'groupManager@gmail.com') asGroupManager;
		affiliationInformation: self testAffiliationInformation;
		contactInformation: self testContactInformation;
		paymentInformation: self testPaymentInformation;
		yourself
]

{ #category : #tests }
ERTest class >> testGroupManager: aString [

   | group |
	group := ERGroup new
		userAccount: (self testUserAccount: aString) asGroupManager;
		affiliationInformation: (self testAffiliationInformationWith: aString);
		contactInformation: self testContactInformation;
		paymentInformation: self testPaymentInformation;
		yourself.
	^ group
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
			title: 'Talk test';
			description: 'Description test';
			bio: 'Bio test';
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

{ #category : #'test registration' }
ERTest >> addAttendeesTo: aController ofList: aList [

	aList
		do: [ :each | aController addAttendee: (self class testAttendee: each) ]
]

{ #category : #'test registration' }
ERTest >> addAttendeesTo: aController ofList: aList withGroup: aGroup [

	aList
		do: [ :each | aController addAttendee: (self class testAttendee: each withGroup: aGroup) ]
]

{ #category : #'test registration' }
ERTest >> addGroupOfAttendees: aController [

	self groupOfAttendees
		do: [ :each | aController addAttendee: (self class testAttendee: each) ]
]

{ #category : #accesing }
ERTest >> allTestingClasses [
	"If you add a new class to test, you need to put it into this method"

	^ #(#ERAttendee #ERAward #ERFee #ERGroup #ERReductionTicket #ERTalk #ERUserAccount #ERConference)
]

{ #category : #accesing }
ERTest >> defaultStore [
	"Return a new memory store"

	^ ESUGMemoryStore new
]

{ #category : #modifying }
ERTest >> deleteAll [
	"delete all instances of all testing classes"

	self allTestingClasses
		do: [ :each | self deleteAllInstancesOf: each ]
]

{ #category : #modifying }
ERTest >> deleteAllInstancesOf: aClass [
	"Delete instances of the classes saved in memory store"

	(self class environment at: aClass) do: [ :each | each delete ].
	(self class environment at: aClass) coolDown
]

{ #category : #modifying }
ERTest >> deleteBackupFolderIfExist [

	self deleteFolder: 'Backup'
]

{ #category : #modifying }
ERTest >> deleteDownloadFolderIfExist [

	| path |
	path := ('Download' asFileReference ).
	path exists ifTrue:
		 [ path deleteAll ] 
]

{ #category : #modifying }
ERTest >> deleteFolder: aString [

	| path |
	path := self smalltalk imageDirectory / aString.
	path exists
		ifTrue: [ path deleteAll ]
]

{ #category : #'test registration' }
ERTest >> groupOfAttendees [
	"If you want to add another attendees, add an email like the others"
	
	^ #('test1@gmail.com' 'test2@gmail.com' 'test3@gmail.com')
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

	aList do: [ :email | 
		self registerAttendee: (self class testAttendee: email) ]
]

{ #category : #'test registration' }
ERTest >> registerGroup [

	| user group aController |
	user := self registerAsGroupManager.
	group := self groupOfUser: user.
	aController := ERGroupController new group: group.
	self addGroupOfAttendees: aController.
	^ group
]

{ #category : #'test registration' }
ERTest >> registerGroupWithGroupManager: aString listOfAttendees: aList [

	| user group aController |
	
	user := self registerAsGroupManager: aString.
	group := self groupOfUser: user.
	aController := ERGroupController new group: group.
	self addAttendeesTo: aController ofList: aList withGroup: group.
	^ group
]

{ #category : #running }
ERTest >> setUp [

	super setUp.
	ESUGSetUp start.
	controller := ERController new.
]

{ #category : #accesing }
ERTest >> smalltalk [

	^ Smalltalk
]

{ #category : #running }
ERTest >> tearDown [
	"Delete all instances and the folder backup"

	self deleteAll.
	ESUGSetUp stop.
	self deleteBackupFolderIfExist.
	self smalltalk garbageCollectMost.
	super tearDown.
]

{ #category : #accesing }
ERTest >> validCoupon [

	^ controller conference reductionTickets first 
]

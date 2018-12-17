Class {
	#name : #ERTestModels,
	#superclass : #TestCase,
	#instVars : [
		'database',
		'store',
		'user1',
		'user2',
		'invoiceWithCoupon',
		'invoiceWtihoutCoupon',
		'couponGold',
		'couponPlatinum',
		'conference',
		'daysAssist',
		'affiliation',
		'price1',
		'price2'
	],
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestModels class >> testAttendee [
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
ERTestModels class >> testUserAccount [
	^ ERUserAccount new
		email: 'test@gmail.com';
		firstName: 'Test';
		lastName: 'Test';
		password: (ERUserAccount hashPassword: '12345678') asString;
		yourself
]

{ #category : #tests }
ERTestModels >> defaultStore [
	^ SDMemoryStore new
]

{ #category : #tests }
ERTestModels >> setUp [
	store := self defaultStore.
	SDActiveRecord setStore: store.
	SDFooObject warmUp.
	database := ERSandstoneDatabase new.
	ERAttendee warmUp .
	ERUserAccount warmUp .
	
]

{ #category : #running }
ERTestModels >> tearDown [
	ERAttendee do: [ :each | [each delete] on: Error do: [] ].
	ERAttendee coolDown .
	
	ERUserAccount  do: [ :each | [each delete] on: Error do: [] ].
	ERUserAccount coolDown .
	
	Smalltalk garbageCollectMost 
]

{ #category : #tests }
ERTestModels >> testAddAttendee [
	|anAttende|
	
	anAttende := (ERAttendeeRegistrationController attendee: ERTestModels testAttendee) save.
	
	self deny: (ERUserAccount findUserByEmail: ERTestModels testAttendee email) isNil .
]

{ #category : #tests }
ERTestModels >> testAddExitentAttendee [
	|anAttende|
	
	anAttende := (ERAttendeeRegistrationController attendee: ERTestModels testAttendee) save.
	
	self assert: anAttende isNil .
]

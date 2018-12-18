Class {
	#name : #ERTestControllers,
	#superclass : #TestCase,
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
ERTestControllers class >> testUserAccount [
	^ ERUserAccount new
		email: 'test@gmail.com';
		firstName: 'Test';
		lastName: 'Test';
		password: (ERUserAccount hashPassword: '12345678') asString;
		yourself
]

{ #category : #tests }
ERTestControllers >> defaultStore [
	^ SDMemoryStore new
]

{ #category : #tests }
ERTestControllers >> setUp [
	store := self defaultStore.
	SDActiveRecord setStore: store.
	ERAttendee warmUp.
	ERUserAccount warmUp
]

{ #category : #running }
ERTestControllers >> tearDown [
	ERAttendee do: [ :each | [each delete] on: Error do: [] ].
	ERAttendee coolDown .
	
	ERUserAccount  do: [ :each | [each delete] on: Error do: [] ].
	ERUserAccount coolDown .
	
	Smalltalk garbageCollectMost 
]

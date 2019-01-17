Class {
	#name : #ERGroupManagerController,
	#superclass : #ERLoggedController,
	#category : #'ESUGApp-Controller'
}

{ #category : #adding }
ERGroupManagerController >> addAttendee: anAttendee [
	| group anAttendeeSaved |
	(ERUserAccount findUserByEmail: anAttendee email)
		ifNil: [ | userSaved |
			userSaved := anAttendee userAccount save.
			conference addUser: userSaved .
			anAttendeeSaved := (anAttendee userAccount: userSaved) save.
			conference addAttendee: anAttendeeSaved.
			group := self groupForGroupManager.
			group addAttendee: anAttendeeSaved.
			conference save.
			^ group save ].
	^ nil
]

{ #category : #adding }
ERGroupManagerController >> addMyselfToGroup [
	|group|
	group := self groupForGroupManager.
	group addAttendee: attendee.
	group save.
]

{ #category : #adding }
ERGroupManagerController >> createGroup: aGroupManager [
	|group|
	group := ERGroup groupManager: aGroupManager.
			group := group save.
			conference
				addGroup: group;
				save.
	^ group
]

{ #category : #accessing }
ERGroupManagerController >> deleteAllFieldsOfAttendeeExceptAffiliationInformation [
	attendee keywords: ''.
	attendee additionalText: ''.
	attendee address: ''.
	attendee address2: ''.
	attendee city: ''.
	attendee country: 'Select Country'.
	attendee province: ''.
	attendee postal: ''.
	attendee facebookURL: ''.
	attendee twitterURL: ''.
	attendee homePage: ''.
	attendee foodPreference: 'Normal'.
	attendee attendSocialEvent: true.
	attendee addedToMainList: true.
	attendee addPersonToSocialDinner: false.
	attendee tshirtSize: 'XS'.
	attendee
		attendance:
			(Dictionary
				newFrom:
					{('monday' -> true).
					('tuesday' -> true).
					('wednesday' -> true).
					('thursday' -> true).
					('friday' -> true)}).
	attendee gender: 'Male'.
	attendee paymentType: 'Bank transfer'.
	attendee paymentCurrency: 'Euro'.
	attendee coupon: ''.
	attendee userAccount deleteRole: 'attendee'.
	user save.
	attendee save.
]

{ #category : #accessing }
ERGroupManagerController >> deleteAttendee: anAttendee [
	self deleteAttendeeFromGroupAndConference: anAttendee.
	anAttendee userAccount = attendee userAccount
		ifFalse: [ self deleteAttendeeAndRemoveUserForConference: anAttendee ]
		ifTrue: [ self deleteAllFieldsOfAttendeeExceptAffiliationInformation ]
]

{ #category : #accessing }
ERGroupManagerController >> deleteAttendeeFromGroup: anAttendee [
	| group |
	group := self groupForGroupManager.
	group listAttends
		do: [ :each | 
			each userAccount email = anAttendee userAccount email
				ifTrue: [ 
					group listAttends remove: each ifAbsent: [  ].
					self deleteAttendee: each ] ].
	group save
]

{ #category : #accessing }
ERGroupManagerController >> deleteAttendeeFromGroupAndConference: anAttendee [
	(self groupForGroupManager listAttends)
		removeAllSuchThat: [ :each | anAttendee id = each id ].
	self groupForGroupManager save.
	(self conference attends)
		removeAllSuchThat: [ :each | anAttendee id = each id ].
	self conference save.
]

{ #category : #accessing }
ERGroupManagerController >> groupForGroupManager [
	^ self groupOfAttendee: attendee
]

{ #category : #adding }
ERGroupManagerController >> groupOfAttendee: aGroupManager [
	| group |
	group := ERGroup
		find: [ :each | each groupManager = aGroupManager ].
	group
		ifNil: [ 
			group := self createGroup: aGroupManager .
			 ].
	^ group
]

{ #category : #adding }
ERGroupManagerController >> registerAsAttendee [
	attendee userAccount
		roleAdd: 'attendee';
		save.
	attendee save.
	conference addAttendee: attendee.
	self addMyselfToGroup.
	conference save.
	^ attendee
]

{ #category : #adding }
ERGroupManagerController >> updateGroup: aGroup [
	aGroup save.
	self updatePaymentForAttendees: aGroup
]

{ #category : #adding }
ERGroupManagerController >> updatePaymentForAttendees: aGroup [
	aGroup listAttends do: [ :att | 
		att paymentType: aGroup paymentType .
		att paymentCurrency: aGroup paymentCurrency. 
		att save ]
]

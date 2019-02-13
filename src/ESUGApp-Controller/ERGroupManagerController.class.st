Class {
	#name : #ERGroupManagerController,
	#superclass : #ERLoggedController,
	#instVars : [
		'group'
	],
	#category : #'ESUGApp-Controller'
}

{ #category : #adding }
ERGroupManagerController >> addAttendee: anAttendee [
	| anAttendeeSaved userSaved groupAtt |
	self validateRegister: anAttendee.
	groupAtt := self group.
	anAttendee paymentInformation invoiceNumber: groupAtt paymentInformation invoiceNumber.
	anAttendee userAccount password: (ERUserAccount hashPassword: (anAttendee userAccount password )asString).
	userSaved := (anAttendee userAccount as: ERUserAccount) save.
	conference addUser: userSaved .
	anAttendeeSaved := (anAttendee userAccount: userSaved) save.
	conference addAttendee: anAttendeeSaved.
	groupAtt addAttendee: anAttendeeSaved.
	conference save.
	anAttendee idGroup: groupAtt id.
	anAttendee save.
	^ groupAtt save
]

{ #category : #adding }
ERGroupManagerController >> addGroupManagerAsAttendee: anAttendee [
	| anAttendeeSaved |
	anAttendee paymentInformation invoiceNumber: self group paymentInformation invoiceNumber.
	(anAttendee userAccount) roleAdd: 'attendee'; save.
	anAttendee idGroup: self group id.
	anAttendeeSaved := anAttendee save.
	conference addAttendee: anAttendeeSaved.
	self group addAttendee: anAttendeeSaved.
	conference save.
	^ self group save
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
ERGroupManagerController >> group [
	^ group
]

{ #category : #accessing }
ERGroupManagerController >> group: anObject [
	group := anObject
]

{ #category : #accessing }
ERGroupManagerController >> groupForGroupManager [
	^ self groupOfUser: attendee.
]

{ #category : #accessing }
ERGroupManagerController >> groupManager [ 
	^ group groupManager
]

{ #category : #adding }
ERGroupManagerController >> groupOfUser: aGroupManager [
	^ conference groups
		detect: [ :each | each groupManager userAccount = aGroupManager ].
	
]

{ #category : #adding }
ERGroupManagerController >> updateGroup: aGroup [
	aGroup save.
	self updatePaymentForAttendees: aGroup
]

{ #category : #adding }
ERGroupManagerController >> updateNumberInvoiceOn: anAttendee [
	^ anAttendee paymentInformation invoiceNumber: self group paymentInformation invoiceNumber
	
]

{ #category : #adding }
ERGroupManagerController >> updatePaymentForAttendees: aGroup [
	aGroup listAttends do: [ :att | 
		att paymentType: aGroup paymentType .
		att paymentCurrency: aGroup paymentCurrency. 
		att save ]
]

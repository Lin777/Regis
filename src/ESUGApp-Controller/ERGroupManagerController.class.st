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
	^ self updateGroup: self group
]

{ #category : #adding }
ERGroupManagerController >> addGroupManagerAsAttendee: anAttendee [
	| anAttendeeSaved |
	anAttendee paymentInformation invoiceNumber: self group paymentInformation invoiceNumber.
	(anAttendee userAccount) roleAdd: 'attendee'; save.
	anAttendee idGroup: self group id.
	"Prueba"
	self updatePaymentRate: anAttendee.
	anAttendeeSaved := anAttendee save.
	conference addAttendee: anAttendeeSaved.
	self group addAttendee: anAttendeeSaved.
	conference save.
	self notifyAllObservers .
	^ self updateGroup: self group
]

{ #category : #accessing }
ERGroupManagerController >> deleteAttendeeFromGroupAndConference: anAttendee [
	(self group listAttends)
		removeAllSuchThat: [ :each | anAttendee id = each id ].
	self group save.
	(self conference attends)
		removeAllSuchThat: [ :each | anAttendee id = each id ].
	self conference save.
	self notifyAllObservers .
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
	self updatePaymentForAttendees: aGroup.
	super updateGroup: aGroup 
]

{ #category : #adding }
ERGroupManagerController >> updateNumberInvoiceOn: anAttendee [
	^ anAttendee paymentInformation invoiceNumber: self group paymentInformation invoiceNumber
	
]

{ #category : #adding }
ERGroupManagerController >> updatePaymentForAttendees: aGroup [
	aGroup listAttends do: [ :att | 
		att paymentInformation paymentType: aGroup paymentInformation paymentType .
		att paymentInformation paymentCurrency: aGroup paymentInformation paymentCurrency. 
		att save ]
]

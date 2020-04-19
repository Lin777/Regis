"
Description
--------------------

I am a controller for Group Manager of Conference, this is only use for groupManager user.

I can:
 
- add attendees to group
- delete attendee from group
- add a group manager as attendee
- update billing information
"
Class {
	#name : #ERGroupManagerController,
	#superclass : #ERLoggedController,
	#instVars : [
		'group',
		'newAttendees'
	],
	#category : #'ESUGApp-Controller'
}

{ #category : #adding }
ERGroupManagerController >> addAttendee: anAttendee [
	"Add attendee to group"
	
	| anAttendeeSaved |
	self validateRegister: anAttendee.
	anAttendee paymentInformation invoiceNumber: self group paymentInformation invoiceNumber.
	anAttendee userAccount encryptMyPassword.
	anAttendee userAccount: (anAttendee userAccount as: ERUserAccount).
	anAttendeeSaved := conference addAttendee: anAttendee.
	self group addAttendee: anAttendeeSaved.
	conference save.
	anAttendee idGroup: self group id.
	anAttendee save.
	^ self updateGroup: self group
]

{ #category : #adding }
ERGroupManagerController >> addGroupManagerAsAttendee: anAttendee [
	| anAttendeeSaved |
	anAttendee updateValuesFor: self group.
	(anAttendee userAccount) convertAttendee; save.
	self updatePaymentRate: anAttendee.
	anAttendeeSaved := anAttendee save.
	self group addAttendee: anAttendeeSaved.
	(conference attends) add: anAttendeeSaved.
	conference save.
	self notifyAllObservers.
	^ self updateGroup: self group
]

{ #category : #'instance creation' }
ERGroupManagerController >> addNewAttendeeToRegister: anAttendee [

	self newAttendees add: anAttendee.
]

{ #category : #deleting }
ERGroupManagerController >> deleteAttendeeFromGroupAndConference: anAttendee [
	(self group listAttends)
		removeAllSuchThat: [ :each | anAttendee id = each id ].
	self group save.
	(self conference attends)
		removeAllSuchThat: [ :each | anAttendee id = each id ].
	self conference save.
	self updateGroup: self group.
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
ERGroupManagerController >> groupManager [ 
	^ group groupManager
]

{ #category : #'instance creation' }
ERGroupManagerController >> newAttendees [

	^ newAttendees ifNil: [ newAttendees := OrderedCollection new ]
]

{ #category : #'instance creation' }
ERGroupManagerController >> removeGroupMemberToRegisterWithIndex: anIndex [

	newAttendees removeAt: anIndex.
	newAttendees doWithIndex: [ :newAttendee :index |
		 newAttendee classId: index ]
]

{ #category : #'as yet unclassified' }
ERGroupManagerController >> updateAttendee: anAttendee inIndex: classId [

	newAttendees at: classId put: anAttendee
]

{ #category : #updating }
ERGroupManagerController >> updateBillingInfo: aff [
	self group affiliationInformation: aff.
	self group save.
	self notifyAllObservers  
]

{ #category : #updating }
ERGroupManagerController >> updateGroup: aGroup [
	aGroup updatePaymentForAttendees.
	aGroup listAttends do: [ :att | self updatePaymentRate: att ].
	super updateGroup: aGroup 
]

{ #category : #updating }
ERGroupManagerController >> updateGroupInformation: aGroup [

	self group affiliationInformation: aGroup affiliationInformation copy.
	self group paymentInformation: aGroup paymentInformation copy.
	self group contactInformation: aGroup contactInformation copy.
	aGroup updateGroupInformationForAttendees.
	aGroup listAttends do: [ :att | self updatePaymentRate: att ].
	self group save.
	self notifyAllObservers  
]

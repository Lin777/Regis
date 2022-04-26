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
	#name : #ERGroupController,
	#superclass : #ERLoggedController,
	#instVars : [
		'group',
		'newAttendees'
	],
	#category : #'ESUGApp-Controller'
}

{ #category : #adding }
ERGroupController >> addAttendee: anAttendee [
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
ERGroupController >> addGroupManagerAsAttendee: anAttendee [
	| anAttendeeSaved |
	self verifyIfAttendeeHasADaysOfConference: anAttendee.
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
ERGroupController >> addNewAttendeeToRegister: anAttendee [

	self newAttendees add: anAttendee.
]

{ #category : #deleting }
ERGroupController >> deleteAttendeeFromGroupAndConference: anAttendee [

	self conference deleteTalksCreatedByAttendee: anAttendee.
	self conference deleteAwardsCreatedByAttendee: anAttendee.
	(self group listAttends)
		removeAllSuchThat: [ :each | anAttendee id = each id ].
	self group save.
	(self conference attends)
		removeAllSuchThat: [ :each | anAttendee id = each id ].
	self conference save.
	self updateGroup: self group.
	self notifyAllObservers.
]

{ #category : #accessing }
ERGroupController >> group [
	^ group
]

{ #category : #accessing }
ERGroupController >> group: anObject [
	group := anObject
]

{ #category : #accessing }
ERGroupController >> groupManager [ 
	^ group groupManager
]

{ #category : #'instance creation' }
ERGroupController >> newAttendees [

	^ newAttendees ifNil: [ newAttendees := OrderedCollection new ]
]

{ #category : #'instance creation' }
ERGroupController >> removeGroupMemberToRegisterWithIndex: anIndex [

	newAttendees removeAt: anIndex.
	newAttendees doWithIndex: [ :newAttendee :index |
		 newAttendee classId: index ]
]

{ #category : #updating }
ERGroupController >> updateAttendee: anAttendee inIndex: classId [

	newAttendees at: classId put: anAttendee
]

{ #category : #updating }
ERGroupController >> updateBillingInfo: aff [
	self group affiliationInformation: aff.
	self group save.
	self notifyAllObservers  
]

{ #category : #updating }
ERGroupController >> updateGroup: aGroup [
	aGroup updatePaymentForAttendees.
	aGroup listAttends do: [ :att | self updatePaymentRate: att ].
	super updateGroup: aGroup 
]

{ #category : #updating }
ERGroupController >> updateGroupInformation: aGroup [

	self group affiliationInformation: aGroup affiliationInformation copy.
	self group paymentInformation: aGroup paymentInformation copy.
	self group contactInformation: aGroup contactInformation copy.
	aGroup updateGroupInformationForAttendees.
	aGroup listAttends do: [ :att | self updatePaymentRate: att ].
	self updateGroup: aGroup.
	self group save.
	self notifyAllObservers 
	
	
]

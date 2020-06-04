"
Description
--------------------

I am a controller for users
"
Class {
	#name : #ERUserOptionsController,
	#superclass : #ERLoggedController,
	#category : #'ESUGApp-Controller'
}

{ #category : #adding }
ERUserOptionsController >> addUser: anUser [

	(conference findUserByEmail: anUser email)
		ifNil: [ | userSaved |
			userSaved := anUser save.
			conference addNewUser: userSaved.
			self notifyAllObservers .
			^ userSaved ]
]

{ #category : #deleting }
ERUserOptionsController >> deleteDependencesOfAttendee: anUser [

	| att |
	anUser isAttendee ifFalse: [ ^ self ].
	att := conference attendeeFromUser: anUser.
	conference deleteAttendeeFromGroupAndConference: att
]

{ #category : #deleting }
ERUserOptionsController >> deleteDependencesOfGroupManager: anUser [

	| group |
	anUser isGroupManager
		ifFalse: [ ^ self ].
	group := conference groupOfUser: anUser.
	self deleteGroup: group
]

{ #category : #deleting }
ERUserOptionsController >> deleteGroup: aGroup [

	| attendees |
	attendees := aGroup listAttends deepCopy.
	attendees do: [ :each | self deleteAttendee: (ERAttendee find: [ :att | att = each ]) ].
	conference deleteUser: aGroup groupManager userAccount.
	(self conference groups)
		removeAllSuchThat: [ :each | aGroup id = each id ].
	aGroup delete.
	self notifyAllObservers
]

{ #category : #deleting }
ERUserOptionsController >> deleteUser: anUser [
	"The admin user can not be deleted"
	
	anUser isAdmin ifFalse: [ 
		self deleteDependencesOfAttendee: anUser.
		self deleteDependencesOfGroupManager: anUser.
		conference deleteUser: anUser.
		self notifyAllObservers ]
	ifTrue: [ ERException adminUserDoesNotDelete signal ]
]

{ #category : #updating }
ERUserOptionsController >> updateGroupInformation: aGroup [

	aGroup updateGroupInformationForAttendees.
	aGroup listAttends do: [ :att | self updatePaymentRate: att ].
	aGroup save.
	self notifyAllObservers.
]

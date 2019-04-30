"
Description
--------------------

I am a controller for configuration of conference, this is only use for admin user.
"
Class {
	#name : #ERConfigurationController,
	#superclass : #ERLoggedController,
	#category : #'ESUGApp-Controller'
}

{ #category : #adding }
ERConfigurationController >> addReductionTicketToConference: ticketRegistered [
	conference addReductionTicket: ticketRegistered.
	self notifyAllObservers 
]

{ #category : #adding }
ERConfigurationController >> addUser: anUser [
	(conference findUserByEmail: anUser email)
		ifNil: [ | userSaved |
			userSaved := anUser save.
			conference addUser: userSaved.
			^ userSaved ]
]

{ #category : #action }
ERConfigurationController >> closeRegistration [
	self conference closeRegistration.
	self notifyAllObservers
]

{ #category : #updating }
ERConfigurationController >> convertToStudentVolunterThis: anAttendee [
	anAttendee convertToStudentVolunter.
	self notifyAllObservers
]

{ #category : #deleting }
ERConfigurationController >> deleteDependencesOfAttendee: anUser [
	|att|
	anUser isAttendee ifFalse: [ ^ self ].
	att := conference attendeeFromUser: anUser.
	conference deleteAttendeeFromGroupAndConference: att
]

{ #category : #deleting }
ERConfigurationController >> deleteDependencesOfGroupManager: anUser [
	anUser isGroupManager ifTrue: [ |group|
		group := conference groupOfUser: anUser.
		self deleteGroup: group
		 ]
]

{ #category : #deleting }
ERConfigurationController >> deleteGroup: aGroup [
	|attendees|
	attendees := aGroup listAttends deepCopy.
	attendees do: [ :each | self deleteAttendee: (ERAttendee find: [:att | att = each]) ].
	conference deleteUser: aGroup groupManager userAccount.
	(self conference groups)
		removeAllSuchThat: [ :each | aGroup id = each id ].
	aGroup delete.
	self notifyAllObservers
]

{ #category : #deleting }
ERConfigurationController >> deleteReductionTicket: aReductionTicket [
	(conference attendeesForATicket: aReductionTicket ticketId) isNotEmpty
		ifTrue: [ ERException deletionOfTicketNotValid signal ].
	conference reductionTickets
		removeAllSuchThat: [ :each | each ticketId = aReductionTicket ticketId ].
	aReductionTicket delete.
	self notifyAllObservers 
]

{ #category : #deleting }
ERConfigurationController >> deleteStudentVolunterRoleFrom: anAttendee [
	anAttendee removeStudentVolunterRole.
	self notifyAllObservers
]

{ #category : #deleting }
ERConfigurationController >> deleteUser: anUser [
	"The admin user can not be deleted"
	anUser isAdmin ifFalse: [ 
		self deleteDependencesOfAttendee: anUser.
		self deleteDependencesOfGroupManager: anUser.
		conference deleteUser: anUser.
		self notifyAllObservers ]
	ifTrue: [ ERException adminUserDoesNotDelete signal ]
]

{ #category : #updating }
ERConfigurationController >> modifyTicket: aTicket [
	conference reductionTicketAlreadyExist: aTicket.
	aTicket save.
	self notifyAllObservers
]

{ #category : #action }
ERConfigurationController >> openRegistration [
	conference openRegistration.
	self notifyAllObservers
]

{ #category : #saving }
ERConfigurationController >> saveConferenceWithConfiguration: configuration emailConfiguration: emailConfig organizer: organizer [
	self conference configuration:configuration.
	self conference configuration emailConfiguration: emailConfig .
	self conference configuration organizer: organizer .
	self conference save.
	self notifyAllObservers 
]

{ #category : #saving }
ERConfigurationController >> saveFileOn: aFile withStream: stream [
	aFile
		ensureDelete;
		binaryWriteStreamDo: [ :outputStream | 
			(ZnCharacterWriteStream on: outputStream encoding: 'utf8')
				nextPutAll: stream contents ]
]

{ #category : #updating }
ERConfigurationController >> updateFee: aFee [
	aFee save.
	self notifyAllObservers.
	^ aFee
	
]

{ #category : #validations }
ERConfigurationController >> validateConferenceConfiguration: configuration [
	configuration dateFrom asDate < configuration dateTo asDate
	ifFalse: [ ^ ERException invalidEsugDates signal ]
	
]

{ #category : #validations }
ERConfigurationController >> validateEmailConfiguration: emailConfiguration [
	
]

{ #category : #validations }
ERConfigurationController >> validateOrganizerConfiguration: organizer [
]

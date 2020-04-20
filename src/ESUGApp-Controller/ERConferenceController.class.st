"
Description
--------------------

I am a controller for conference, this is only use for admin user.
"
Class {
	#name : #ERConferenceController,
	#superclass : #ERLoggedController,
	#category : #'ESUGApp-Controller'
}

{ #category : #adding }
ERConferenceController >> addReductionTicketToConference: ticketRegistered [
	"Add reduction ticker to conference and create a backup"

	conference addReductionTicket: ticketRegistered.
	self notifyAllObservers
]

{ #category : #updating }
ERConferenceController >> convertToStudentVolunterThis: anAttendee [
	"Convert student to volunteer and create a backup"

	anAttendee convertToStudentVolunter.
	self notifyAllObservers
]

{ #category : #deleting }
ERConferenceController >> deleteReductionTicket: aReductionTicket [
	"Remove a reduction ticket and create a backup"

	(conference attendeesForATicket: aReductionTicket ticketId) 
		isNotEmpty
			ifTrue: [ ERException deletionOfTicketNotValid signal ].
	conference reductionTickets
		removeAllSuchThat: [ :each | each ticketId = aReductionTicket ticketId ].
	aReductionTicket delete.
	self notifyAllObservers
]

{ #category : #deleting }
ERConferenceController >> deleteStudentVolunterRoleFrom: anAttendee [
	"Delete Student Volunter role of attendee and create backup"

	anAttendee removeStudentVolunterRole.
	self notifyAllObservers
]

{ #category : #updating }
ERConferenceController >> modifyTicket: aTicket [
	"Modify information of ticket and create a backup"

	conference reductionTicketAlreadyExist: aTicket.
	aTicket save.
	self notifyAllObservers
]

{ #category : #saving }
ERConferenceController >> saveConferenceWithConfiguration: configuration emailConfiguration: emailConfig organizer: organizer [
	"Save conference configuration and create backup"

	self conference configuration: configuration.
	self conference configuration emailConfiguration: emailConfig.
	self conference configuration organizer: organizer.
	self conference save.
	self notifyAllObservers 
]

{ #category : #updating }
ERConferenceController >> updateFee: aFee [
	"Update a fee and create a backup file"

	aFee save.
	self notifyAllObservers.
	^ aFee
]

{ #category : #validations }
ERConferenceController >> validateConferenceConfiguration: configuration [
	"validate conference information"
	
	configuration dateFrom asDate < configuration dateTo asDate
		ifFalse: [ ^ ERException invalidEsugDates signal ]
]

{ #category : #validations }
ERConferenceController >> validateEmailConfiguration: emailConfiguration [
	"Need implementation"
]

{ #category : #validations }
ERConferenceController >> validateOrganizerConfiguration: organizer [
	"Need implementation"
]

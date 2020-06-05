"
Description
--------------------

I am a controller for configuration of conference, this is only use for admin user.

I can:
 
	- configure the application
"
Class {
	#name : #ERConfigurationController,
	#superclass : #ERLoggedController,
	#category : #'ESUGApp-Controller'
}

{ #category : #adding }
ERConfigurationController >> addReductionTicketToConference: ticketRegistered [
	"Add reduction ticker to conference and create a backup"

	conference addReductionTicket: ticketRegistered.
	self notifyAllObservers
]

{ #category : #action }
ERConfigurationController >> closeRegistration [

	self conference closeRegistration.
	self notifyAllObservers
]

{ #category : #deleting }
ERConfigurationController >> deleteReductionTicket: aReductionTicket [
	"Remove a reduction ticket and create a backup"

	(conference attendeesForATicket: aReductionTicket ticketId) 
		isNotEmpty
			ifTrue: [ ERException deletionOfTicketNotValid signal ].
	conference reductionTickets
		removeAllSuchThat: [ :each | each ticketId = aReductionTicket ticketId ].
	aReductionTicket delete.
	self notifyAllObservers
]

{ #category : #updating }
ERConfigurationController >> modifyTicket: aTicket [
	"Modify information of ticket and create a backup"

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
	"Save conference configuration and create backup"

	self conference configuration: configuration.
	self conference configuration emailConfiguration: emailConfig.
	self conference configuration organizer: organizer.
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
	"Update a fee and create a backup file"

	aFee save.
	self notifyAllObservers.
	^ aFee
]

{ #category : #validations }
ERConfigurationController >> validateConferenceConfiguration: configuration [
	"validate conference information"
	
	configuration dateFrom asDate < configuration dateTo asDate
		ifFalse: [ ^ ERException invalidEsugDates signal ]
]

{ #category : #validations }
ERConfigurationController >> validateEmailConfiguration: emailConfiguration [
	"Need implementation"
]

{ #category : #validations }
ERConfigurationController >> validateOrganizerConfiguration: organizer [
	"Need implementation"
]

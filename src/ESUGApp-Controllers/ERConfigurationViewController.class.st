Class {
	#name : #ERConfigurationViewController,
	#superclass : #ERLoggedController,
	#category : #'ESUGApp-Controllers'
}

{ #category : #adding }
ERConfigurationViewController >> addAttendee: anAttendee [
	| anAttendeeSaved |
	(ERUserAccount findUserByEmail: anAttendee email)
		ifNil: [ | userSaved |
			userSaved := anAttendee userAccount save.
			conference addUser: userSaved.
			anAttendeeSaved := (anAttendee userAccount: userSaved) save.
			conference addAttendee: anAttendeeSaved.
			conference save.
			^ anAttendeeSaved ].
	^ nil
]

{ #category : #adding }
ERConfigurationViewController >> addUser: anAttendee [
	(ERUserAccount findUserByEmail: anAttendee email)
		ifNil: [ | userSaved |
			userSaved := anAttendee userAccount save.
			conference addUser: userSaved.
			^ userSaved ].
	^ nil
]

{ #category : #accessing }
ERConfigurationViewController >> attends [
	^ conference attends 
]

{ #category : #accessing }
ERConfigurationViewController >> fees [
	^ conference fees
]

{ #category : #accessing }
ERConfigurationViewController >> groups [
	^ conference groups 
]

{ #category : #accessing }
ERConfigurationViewController >> reductionTickets [
	^ conference reductionTickets
]

{ #category : #adding }
ERConfigurationViewController >> registerAsAttendee [
	attendee userAccount
		roleAdd: 'attendee';
		save.
	attendee save.
	conference addAttendee: attendee.
	conference save.
	^ attendee
]

{ #category : #adding }
ERConfigurationViewController >> registerAsGroupManager [
	attendee userAccount
		roleAdd: 'groupManager';
		save.
	attendee save.
	conference addAttendee: attendee.
	conference save.
	^ attendee
]

{ #category : #accessing }
ERConfigurationViewController >> submittedAwards [
	^ conference submittedAwards
]

{ #category : #accessing }
ERConfigurationViewController >> submittedTalks [
	^ conference submittedTalks
]

{ #category : #accessing }
ERConfigurationViewController >> users [
	^ conference users
]

"
Description
--------------------

I am a controller for conference, this is only use for admin user.
"
Class {
	#name : #ERAttendeeController,
	#superclass : #ERLoggedController,
	#category : #'ESUGApp-Controller'
}

{ #category : #updating }
ERAttendeeController >> convertToStudentVolunterThis: anAttendee [
	"Convert student to volunteer and create a backup"

	anAttendee convertToStudentVolunter.
	self notifyAllObservers
]

{ #category : #deleting }
ERAttendeeController >> deleteStudentVolunterRoleFrom: anAttendee [
	"Delete Student Volunter role of attendee and create backup"

	anAttendee removeStudentVolunterRole.
	self notifyAllObservers
]

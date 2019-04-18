"
Description
--------------------

I am an class for send emails with invoice of registration.

Instance Variables
--------------------
	attendee: an ERAttendee that will be send a mail
	conference: an ERConference (to find atributtes of ERConferenceEmailConfiguration)
"
Class {
	#name : #ERInvoiceMailSender,
	#superclass : #ERMailSender,
	#instVars : [
		'attendee',
		'conference'
	],
	#category : #'ESUGApp-Core'
}

{ #category : #'instance creation' }
ERInvoiceMailSender class >> on: anAttendee [
	^ self new attendee: anAttendee 
]

{ #category : #rendering }
ERInvoiceMailSender >> attendee: anAttendee [
	attendee := anAttendee 
]

{ #category : #rendering }
ERInvoiceMailSender >> getInvoiceAsStreamOf: user [
	|file stream|
	file := ERPDFInvoice pdfDocOf: user.
	stream := (RWBinaryOrTextStream on: String new) binary.
	file exportTo: stream.
	^ stream close.
]

{ #category : #rendering }
ERInvoiceMailSender >> subjectDescription [
	^ 'Registration Invoice of ', controller conference configuration name asString
]

{ #category : #rendering }
ERInvoiceMailSender >> textBody [
	^ 'The conference invoice is attached to this email'
]

{ #category : #rendering }
ERInvoiceMailSender >> titleBody [
	^ '<h3> Invoice </h3>'
]

{ #category : #rendering }
ERInvoiceMailSender >> toEmailString [
	^ attendee userAccount email
]

{ #category : #rendering }
ERInvoiceMailSender >> value [ 
	|value invoice|
	invoice := self getInvoiceAsStreamOf: attendee.	
	value := super value.
	^ value addAttachment: 'invoice.pdf' content: invoice contents contentType: 'application/pdf';yourself.
]

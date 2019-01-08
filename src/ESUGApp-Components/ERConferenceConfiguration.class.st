Class {
	#name : #ERConferenceConfiguration,
	#superclass : #ERConfiguration,
	#instVars : [
		'conference',
		'dialog'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERConferenceConfiguration class >> conference: aConference [
	^ self new conference: aConference ; yourself 
]

{ #category : #rendering }
ERConferenceConfiguration >> cancel [
	conference := conference abortChanges .
]

{ #category : #rendering }
ERConferenceConfiguration >> initialize [
	super initialize.
	self initializeController.
	conference := controller conference.
	dialog := ERDialog new
		title: 'Cancel Modify Conference';
		message: 'Are you sure you want to cancel?';
		idClose: 'buttonClose';
		idOpen: 'cancel-modify-conference';
		okCallback: [ self cancel ]
]

{ #category : #rendering }
ERConferenceConfiguration >> renderAcceptButtonOn: html [
	self
		createColoredButton: 'Accept'
		with: [ self updateOrCreateConference ]
		id: 'accept-modify-conference'
		on: html
]

{ #category : #rendering }
ERConferenceConfiguration >> renderButtons: html [
	self renderAcceptButtonOn: html.
	self renderCancelButtonOn: html
]

{ #category : #rendering }
ERConferenceConfiguration >> renderCancelButtonOn: html [
	self
		createColoredAnchorButton: 'Cancel'
		id: 'cancel-modify-conference'
		on: html
]

{ #category : #rendering }
ERConferenceConfiguration >> renderContainer: html [
	html horizontalRule.
]

{ #category : #rendering }
ERConferenceConfiguration >> renderContentOn: html [
	html form
		method: 'post';
		id: 'formConference';
		with: [ self renderFormConferenceConfiguration: html.
			self renderFormEmailConfiguration: html.
			self renderFormOrganizer: html.
			self renderButtons: html ].
	html render: dialog
]

{ #category : #rendering }
ERConferenceConfiguration >> renderFormConferenceConfiguration: html [
	html heading
		level3;
		with: self title.
	html horizontalRule.
	self
		createTextField: 'Name: '
		for: #name:
		with: #name1
		to: conference configuration
		on: html.
	self
		createTextField: 'Description: '
		for: #description:
		with: #description
		to: conference configuration
		on: html.
	self
		createTextField: 'Home Page: '
		for: #homePageUrl:
		with: #homePageUrl
		to: conference configuration
		on: html.
	self createStrongText: 'Dates: ' to: html.
	self
		createTextField: 'From: '
		for: #dateFrom:
		with: #dateFrom
		percent: 49
		to: conference configuration
		on: html.
	self
		createTextField: 'To: '
		for: #dateTo:
		with: #dateTo
		percent: 49
		to: conference configuration 
		on: html.
	self
		createTextField: 'Submission Deadline: '
		for: #dateSubmissionDeadline:
		with: #dateSubmissionDeadline
		percent: 49
		to: conference configuration 
		on: html.
	self
		createTextField: 'Early Registration Deadline: '
		for: #earlyRegistrationDeadline:
		with: #earlyRegistrationDeadline
		percent: 49
		to: conference configuration 
		on: html
]

{ #category : #rendering }
ERConferenceConfiguration >> renderFormEmailConfiguration: html [
	html heading
		level3;
		with: 'Email Configuration'.
	html horizontalRule.
	self
		createTextField: 'Sender Email Address: '
		for: #senderEmailAddress:
		with: #senderEmailAddress
		to: conference configuration emailConfiguration
		on: html.
	self
		createTextField: 'Smpt Server Address: '
		for: #smptServerAddress:
		with: #smptServerAddress
		to: conference configuration emailConfiguration
		on: html.
	self
		createSelectField: 'Smpt Client: '
		for: #smptClient:
		with: #smptClient
		list: #('PatSmtpToPPostMarkClientAdapter')
		to: conference configuration emailConfiguration
		on: html.
	self
		createTextAreaField: 'Welcome Text'
		for: #welcomeText:
		with: #welcomeText
		withRows: 5
		to: conference configuration emailConfiguration
		on: html
]

{ #category : #rendering }
ERConferenceConfiguration >> renderFormOrganizer: html [
	html heading
		level3;
		with: 'Organizer'.
	html horizontalRule.
	self
		createTextField: 'Name: '
		for: #name:
		with: #name1
		to: conference configuration organizer
		on: html.
	self
		createTextField: 'Fiscal Situacion: '
		for: #fiscalSituation:
		with: #fiscalSituation
		to: conference configuration organizer
		on: html.
	self
		createTextField: 'Web Page URL: '
		for: #webPageUrl:
		with: #webPageUrl
		to: conference configuration organizer
		on: html.
	self
		createTextAreaField: 'Address String: '
		for: #addressString:
		with: #addressString
		withRows: 5
		to: conference configuration organizer
		on: html
]

{ #category : #accessing }
ERConferenceConfiguration >> tabId [
	^ 'conferenceConfiguration'
]

{ #category : #accessing }
ERConferenceConfiguration >> tabName [
	^ 'Conference'
]

{ #category : #accessing }
ERConferenceConfiguration >> title [
	^ 'Conference Configuration'
]

{ #category : #rendering }
ERConferenceConfiguration >> updateOrCreateConference [
	conference := conference save.
]

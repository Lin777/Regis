Class {
	#name : #ERConferenceForm,
	#superclass : #ERConfigurationTab,
	#instVars : [
		'conference',
		'configuration',
		'emailConf',
		'organizer',
		'configurationForm',
		'emailConfigurationForm',
		'organizerForm'
	],
	#category : #'ESUGApp-Form'
}

{ #category : #rendering }
ERConferenceForm >> action [
	^ [ self updateConference
			on: ERException
				do: [ :exception | messageComponent 
					errorMessage: exception messageText ] ]
]

{ #category : #rendering }
ERConferenceForm >> cancel [
	configurationForm cancel.
	emailConfigurationForm cancel.
	organizerForm cancel.
	conference := conference abortChanges .
	self returnToThePreviousState .
]

{ #category : #rendering }
ERConferenceForm >> children [
	^ OrderedCollection new
		add: dialog;
		add: configurationForm ;
		add: emailConfigurationForm ;
		add: organizerForm ;
		add: messageComponent;
		yourself
]

{ #category : #rendering }
ERConferenceForm >> initialize [
	super initialize.
	self initializeController.
	messageComponent := ERAlert warningAlert id: 'formConferenceAlert'.
	conference := controller conference.
	self initializeForms.
	self initializeDialog
]

{ #category : #rendering }
ERConferenceForm >> initializeDialog [
	dialog := ERDialog cancelDialog
		idOpen: 'cancel-modify-conference';
		okCallback: [ self cancel ]
]

{ #category : #rendering }
ERConferenceForm >> initializeForms [
	configurationForm := self createFormOf: conference configuration .
	emailConfigurationForm := self createFormOf: conference configuration emailConfiguration .
	organizerForm := self createFormOf: conference configuration organizer 
]

{ #category : #rendering }
ERConferenceForm >> renderAcceptButtonOn: html [
	html mdlButton
		colored;
		id: 'accept-modify-conference' ;
		callback: self action;
		with: 'Accept'
]

{ #category : #rendering }
ERConferenceForm >> renderButtons: html [
	self renderCancelButtonOn: html.
	self renderAcceptButtonOn: html.
]

{ #category : #rendering }
ERConferenceForm >> renderCancelButtonOn: html [
	html mdlAnchorButton 
		openDialogWithId: 'cancel-modify-conference'; 
		colored;
		with: 'Cancel'.
]

{ #category : #rendering }
ERConferenceForm >> renderContentOn: html [
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
ERConferenceForm >> renderFormConferenceConfiguration: html [
	html heading
		level3;
		with: self title.
	html horizontalRule.
	html render: messageComponent .
	html render: configurationForm
]

{ #category : #rendering }
ERConferenceForm >> renderFormEmailConfiguration: html [
	html heading
		level3;
		with: 'Email Configuration'.
	html horizontalRule.
	html render: emailConfigurationForm 
]

{ #category : #rendering }
ERConferenceForm >> renderFormOrganizer: html [
	html heading
		level3;
		with: 'Organizer'.
	html horizontalRule.
	html render: organizerForm 
]

{ #category : #rendering }
ERConferenceForm >> saveForms [
	"Save all forms of conferece"
	configurationForm save.
	emailConfigurationForm save.
	organizerForm save.
]

{ #category : #accessing }
ERConferenceForm >> tabId [
	^ 'conferenceConfiguration'
]

{ #category : #accessing }
ERConferenceForm >> tabName [
	^ 'Conference'
]

{ #category : #accessing }
ERConferenceForm >> title [
	^ 'Conference Configuration'
]

{ #category : #rendering }
ERConferenceForm >> updateConference [
	^ [self saveForms.
	self validateForms.
	controller saveConferenceWithConfiguration: configurationForm model 
				 emailConfiguration: emailConfigurationForm model 
					organizer: organizerForm model.
	self updateStateTab: self tabName]
]

{ #category : #rendering }
ERConferenceForm >> validateForms [
	"Validate forms"
	controller validateConferenceConfiguration: configurationForm model.
	controller validateEmailConfiguration: emailConfigurationForm model.
	controller validateOrganizerConfiguration: organizerForm model.
]

Class {
	#name : #ERConferenceForm,
	#superclass : #ERConfigurationTab,
	#instVars : [
		'conference',
		'dialog',
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
ERConferenceForm >> cancel [
	conference := conference abortChanges .
]

{ #category : #rendering }
ERConferenceForm >> initialize [
	super initialize.
	self initializeController.
	conference := controller conference.
	configurationForm := conference configuration asComponent addDecoration: MAValidationDecoration new;
	 yourself.
	emailConfigurationForm := conference configuration emailConfiguration asComponent addDecoration: MAValidationDecoration new;
	 yourself.
	organizerForm := conference configuration organizer asComponent addDecoration: MAValidationDecoration new;
	 yourself.
	dialog := ERDialog new
		title: 'Cancel';
		message: 'Are you sure you want to cancel?';
		idClose: 'buttonClose';
		idOpen: 'cancel-modify-conference';
		okCallback: [ self cancel ]
]

{ #category : #rendering }
ERConferenceForm >> renderAcceptButtonOn: html [
	self
		createColoredButton: 'Accept'
		with: [ self updateOrCreateConference ]
		id: 'accept-modify-conference'
		on: html
]

{ #category : #rendering }
ERConferenceForm >> renderButtons: html [
	self renderAcceptButtonOn: html.
	self renderCancelButtonOn: html
]

{ #category : #rendering }
ERConferenceForm >> renderCancelButtonOn: html [
	self
		createColoredAnchorButton: 'Cancel'
		id: 'cancel-modify-conference'
		on: html
]

{ #category : #rendering }
ERConferenceForm >> renderContainer: html [
	html horizontalRule.
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
ERConferenceForm >> updateOrCreateConference [
	"Save all forms of conferece"
	configurationForm save.
	emailConfigurationForm save.
	organizerForm save.
	controller validateConferenceConfiguration: configurationForm model.
	controller validateEmailConfiguration: emailConfigurationForm model.
	controller validateOrganizerConfiguration: organizerForm model.
	controller saveConferenceWithConfiguration: configurationForm model 
				 emailConfiguration: emailConfigurationForm model 
					organizer: organizerForm model.
	self updateStateTab: self tabName.
]

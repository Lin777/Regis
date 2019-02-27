Class {
	#name : #ERConferenceForm,
	#superclass : #ERForm,
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
ERConferenceForm >> cancelForm [
	configurationForm cancel.
	emailConfigurationForm cancel.
	organizerForm cancel.
	conference := conference abortChanges 
]

{ #category : #rendering }
ERConferenceForm >> children [
	^ super children asOrderedCollection copyWithAll: (OrderedCollection new
		add: dialog;
		add: configurationForm ;
		add: emailConfigurationForm ;
		add: organizerForm ;
		add: messageComponent;
		yourself) yourself
]

{ #category : #rendering }
ERConferenceForm >> initialize [
	super initialize.
	conference := controller conference.
	self initializeForms.
]

{ #category : #rendering }
ERConferenceForm >> initializeForms [
	configurationForm := self createFormOf: conference configuration .
	emailConfigurationForm := self createFormOf: conference configuration emailConfiguration .
	organizerForm := self createFormOf: conference configuration organizer 
]

{ #category : #rendering }
ERConferenceForm >> renderFormConferenceConfigurationOn: html [
	html heading
		level3;
		with: self title.
	html horizontalRule.
	html render: messageComponent .
	html render: configurationForm
]

{ #category : #rendering }
ERConferenceForm >> renderFormEmailConfigurationOn: html [
	html heading
		level3;
		with: 'Email Configuration'.
	html horizontalRule.
	html render: emailConfigurationForm 
]

{ #category : #rendering }
ERConferenceForm >> renderFormOn: html [
	self renderFormConferenceConfigurationOn: html.
	self renderFormEmailConfigurationOn: html.
	self renderFormOrganizerOn: html.
	self renderButtonsOn: html
]

{ #category : #rendering }
ERConferenceForm >> renderFormOrganizerOn: html [
	html heading
		level3;
		with: 'Organizer'.
	html horizontalRule.
	html render: organizerForm 
]

{ #category : #rendering }
ERConferenceForm >> save [ 
	controller saveConferenceWithConfiguration: configurationForm model 
				 emailConfiguration: emailConfigurationForm model 
					organizer: organizerForm model.
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
ERConferenceForm >> validateForms [
	"Validate forms"
	controller validateConferenceConfiguration: configurationForm model.
	controller validateEmailConfiguration: emailConfigurationForm model.
	controller validateOrganizerConfiguration: organizerForm model.
]

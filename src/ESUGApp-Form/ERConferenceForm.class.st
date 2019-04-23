"
Description
--------------------

I am a form for edit options of conference.
"
Class {
	#name : #ERConferenceForm,
	#superclass : #ERForm,
	#instVars : [
		'configuration',
		'emailConf',
		'organizer',
		'configurationForm',
		'emailConfigurationForm',
		'organizerForm',
		'configurationOfHomeForm'
	],
	#category : #'ESUGApp-Form'
}

{ #category : #actions }
ERConferenceForm >> cancelForm [
	controller conference abortChanges .
	self initializeForms .
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

{ #category : #initialization }
ERConferenceForm >> initialize [
	super initialize.
	self initializeForms.
]

{ #category : #initialization }
ERConferenceForm >> initializeForms [
	configurationForm := self createFormOf: controller conference configuration .
	emailConfigurationForm := self createFormOf: controller conference configuration emailConfiguration .
	organizerForm := self createFormOf: controller conference configuration organizer .
	configurationOfHomeForm := self createFormOf: controller conference configurationOfHomePage 
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
ERConferenceForm >> renderFormConfigurationOfHomeOn: html [
	html heading
		level3;
		with: 'Configuration of Home Page'.
	html horizontalRule.
	html render: configurationOfHomeForm  
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
	self renderFormConfigurationOfHomeOn: html.
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

{ #category : #actions }
ERConferenceForm >> save [ 
	controller saveConferenceWithConfiguration: configurationForm model 
				 emailConfiguration: emailConfigurationForm model 
					organizer: organizerForm model.
]

{ #category : #actions }
ERConferenceForm >> saveForms [
	"Save all forms of conferece"
	configurationForm save.
	emailConfigurationForm save.
	organizerForm save.
	configurationOfHomeForm save.
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

{ #category : #actions }
ERConferenceForm >> validateForms [
	"Validate forms"
	controller validateConferenceConfiguration: configurationForm model.
	controller validateEmailConfiguration: emailConfigurationForm model.
	controller validateOrganizerConfiguration: organizerForm model.
]

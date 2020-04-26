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
		'configurationOfHomeForm',
		'configurationOfHelpForm'
	],
	#category : #'ESUGApp-Form'
}

{ #category : #actions }
ERConferenceForm >> cancelForm [
	"Cancel changes of conference form"

	controller conference abortChanges.
	self initializeForms.
]

{ #category : #hooks }
ERConferenceForm >> children [
	"Children elements in conference form"

	^ super children asOrderedCollection
		copyWithAll: (self sectionFormElements) yourself
]

{ #category : #accessing }
ERConferenceForm >> conferenceConfiguration [
	"Return conference configuration"

	^ controller conference configuration
]

{ #category : #accessing }
ERConferenceForm >> emailConfiguration [
	"Return email configuration"

	^ self conferenceConfiguration emailConfiguration
]

{ #category : #accessing }
ERConferenceForm >> homePageConfiguration [
	"Return home page configuration"

	^ controller conference configurationOfHomePage
]

{ #category : #initialization }
ERConferenceForm >> initialize [
	"Initialize conference form"

	super initialize.
	self initializeForms.
]

{ #category : #initialization }
ERConferenceForm >> initializeForms [
	"Initialize forms of conference configuration"

	configurationForm := self createFormOf: self conferenceConfiguration.
	emailConfigurationForm := self createFormOf: self emailConfiguration.
	organizerForm := self createFormOf: self organizerInformation.
	configurationOfHomeForm := self
		createFormOf: self homePageConfiguration.
]

{ #category : #accessing }
ERConferenceForm >> organizerInformation [
	"Return information of conference organizer"

	^ self conferenceConfiguration organizer
]

{ #category : #rendering }
ERConferenceForm >> renderFormConferenceConfigurationOn: html [
	"Render conference configuration heading and body"

	html heading
		level3;
		with: 'Conference Information'.
	html horizontalRule.
	html render: messageComponent .
	html render: configurationForm
]

{ #category : #rendering }
ERConferenceForm >> renderFormConfigurationOfHomeOn: html [
	"Render configuration of home page and body"

	html heading
		level3;
		with: 'Information Displayed on Home Page'.
	html horizontalRule.
	html render: configurationOfHomeForm  
]

{ #category : #rendering }
ERConferenceForm >> renderFormEmailConfigurationOn: html [
	"Render email configuration heading and body"

	html heading
		level3;
		with: 'Email Configuration'.
	html horizontalRule.
	html render: emailConfigurationForm 
]

{ #category : #rendering }
ERConferenceForm >> renderFormOn: html [
	"Render all conference sections in html"

	self renderFormTitleOn: html.
	self renderFormConferenceConfigurationOn: html.
	self renderFormEmailConfigurationOn: html.
	self renderFormOrganizerOn: html.
	self renderFormConfigurationOfHomeOn: html.
	self renderButtonsOn: html
]

{ #category : #rendering }
ERConferenceForm >> renderFormOrganizerOn: html [
	"Render Organizer heading and body"

	html heading
		level3;
		with: 'Organizer'.
	html horizontalRule.
	html render: organizerForm 
]

{ #category : #rendering }
ERConferenceForm >> renderFormTitleOn: html [
	"Render general title in conference configuration"

	html heading
		level2;
		with: self title
]

{ #category : #actions }
ERConferenceForm >> save [
	"Save conference with configuration of conference form"
	
	controller 
		saveConferenceWithConfiguration: configurationForm model
		emailConfiguration: emailConfigurationForm model
		organizer: organizerForm model.
]

{ #category : #actions }
ERConferenceForm >> saveForms [
	"Save all sections of conference"
	
	configurationForm save.
	emailConfigurationForm save.
	organizerForm save.
	configurationOfHomeForm save.
]

{ #category : #accessing }
ERConferenceForm >> sectionFormElements [
	"Return elements of conference form"

	^ OrderedCollection new
		add: dialog;
		add: configurationForm;
		add: emailConfigurationForm;
		add: organizerForm;
		add: messageComponent;
		yourself
]

{ #category : #accessing }
ERConferenceForm >> tabId [
	"Return tab id of conference"

	^ 'conferenceConfiguration'
]

{ #category : #accessing }
ERConferenceForm >> tabName [
	"Return tab name of conference"

	^ 'Conference'
]

{ #category : #accessing }
ERConferenceForm >> title [
	"Return title of conference form"

	^ 'Conference Configuration'
]

{ #category : #actions }
ERConferenceForm >> validateForms [
	"Validate all sections forms"
	
	controller validateConferenceConfiguration: configurationForm model.
	controller validateEmailConfiguration: emailConfigurationForm model.
	controller validateOrganizerConfiguration: organizerForm model.
]

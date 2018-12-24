Class {
	#name : #ERAdditionalInformation,
	#superclass : #ERForm,
	#category : #'ESUGApp-Form'
}

{ #category : #initialization }
ERAdditionalInformation class >> canBeRoot [
	^ true
]

{ #category : #initialization }
ERAdditionalInformation class >> initialize [
	"self initialize"

	(WAAdmin register: self asApplicationAt: 'Prueba')
		addLibrary: JQDeploymentLibrary;
		addLibrary: MDLLibrary;
		addLibrary: ERMaterialBlueRedMinCss;
		addLibrary: ERJQValidateForm;
		addLibrary: CssForLoginMDL;
		addLibrary: ERLibrary;
		preferenceAt: #sessionClass put: ERSession
]

{ #category : #'as yet unclassified' }
ERAdditionalInformation >> formId [
	^ 'additionalInfoForm'
]

{ #category : #'as yet unclassified' }
ERAdditionalInformation >> formName [
	^ 'Additional'
]

{ #category : #initialization }
ERAdditionalInformation >> initialize [
	super initialize.
	"attendee := ERAttendee
		find: [ :each | each email = 'cusi@gmail.com' ].
	attendee := ERAttendee new"
]

{ #category : #rendering }
ERAdditionalInformation >> renderContentOn: html [
	self
		createTextField: 'Keywords'
		for: #keywords:
		with: #keywords
		on: html.
	self
		createTextAreaField: 'Additional text'
		for: #additionalText:
		with: #additionalText
		on: html
]

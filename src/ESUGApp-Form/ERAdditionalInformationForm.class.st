Class {
	#name : #ERAdditionalInformationForm,
	#superclass : #ERForm,
	#category : #'ESUGApp-Form'
}

{ #category : #initialization }
ERAdditionalInformationForm class >> canBeRoot [
	^ true
]

{ #category : #initialization }
ERAdditionalInformationForm class >> initialize [
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
ERAdditionalInformationForm >> formId [
	^ 'additionalInfoForm'
]

{ #category : #'as yet unclassified' }
ERAdditionalInformationForm >> formName [
	^ 'Additional'
]

{ #category : #initialization }
ERAdditionalInformationForm >> initialize [
	super initialize
]

{ #category : #rendering }
ERAdditionalInformationForm >> renderContentOn: html [
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

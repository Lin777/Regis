Class {
	#name : #Example,
	#superclass : #WAComponent,
	#instVars : [
		'object'
	],
	#category : #'ESUGApp-View-Uncategorized'
}

{ #category : #'class initialization' }
Example class >> canBeRoot [
	^ true
]

{ #category : #'class initialization' }
Example class >> initialize [
	"self initialize"

	(WAAdmin register: self asApplicationAt: 'Example')
		addLibrary: JQDeploymentLibrary;
		addLibrary: JQUiDeploymentLibrary ;
		addLibrary: MDLLibrary;
		addLibrary: ERMaterialBlueRedMinCss;
		addLibrary: ERJQValidateForm;
		addLibrary: CssForLoginMDL;
		addLibrary: ERLibrary;
		preferenceAt: #sessionClass put: ERSession
]

{ #category : #rendering }
Example >> initialize [
	super initialize.
	object := ERConferenceConfigurationModel1 new asComponent  addDecoration: (MDLMAFormDecoration buttons:
	 (Array with: #cancel -> 'Cancel' with: #save -> 'Create a new form' ));
	addDecoration: MAValidationDecoration new;
	 yourself .
	
	"ERConferenceConfigurationModel1 new asComponent 
	addDecoration: (MDLMAFormDecoration buttons:
	 (Array with: #cancel -> 'Cancel' with: #save -> 'Create a new form' ));
	addDecoration: MAValidationDecoration new;
	 yourself .
		"
]

{ #category : #rendering }
Example >> renderContentOn: html [
	html render: object
]

{ #category : #hooks }
Example >> style [ 	

	^ '.half {width: 49%;
	display: inline-block;}'
]

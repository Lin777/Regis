Class {
	#name : #ERExample,
	#superclass : #ERPageView,
	#category : #'ESUGApp-Views'
}

{ #category : #testing }
ERExample class >> canBeRoot [
	^ true
]

{ #category : #initialization }
ERExample class >> initialize [
	"self initialize"

	(WAAdmin register: self asApplicationAt: 'Example')
		addLibrary: JQDeploymentLibrary;
		addLibrary: MDLLibrary;
		addLibrary: ERMaterialBlueRedMinCss;
		addLibrary: CssForLoginMDL;
		addLibrary: CssForRegisterFormsMDL;
		addLibrary: ERJQValidateForm;
		addLibrary: ERLibrary;
		preferenceAt: #sessionClass put: ERSession
]

{ #category : #initialization }
ERExample >> initialize [
	super initialize.
	title := 'User Login'.
	icon := 'person'.
	id := 'login'.
]

{ #category : #rendering }
ERExample >> renderPageOn: html [
	html paragraph: 'fsf'
]

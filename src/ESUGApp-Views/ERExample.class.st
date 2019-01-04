Class {
	#name : #ERExample,
	#superclass : #ERComponentFactory,
	#instVars : [
		'message'
	],
	#category : #'ESUGApp-Views'
}

{ #category : #initialization }
ERExample class >> canBeRoot [
	^ true
]

{ #category : #initialization }
ERExample class >> initialize [
	"self initialize"

	(WAAdmin register: self asApplicationAt: 'classVerify')
		addLibrary: JQDeploymentLibrary;
		addLibrary: MDLLibrary;
		addLibrary: JQUiDeploymentLibrary;
		addLibrary: ERMaterialBlueRedMinCss;
		addLibrary: CssForLoginMDL;
		addLibrary: ERJQValidateForm;
		addLibrary: ERLibrary;
		preferenceAt: #sessionClass put: ERSession
]

{ #category : #initialization }
ERExample >> initialize [
	super initialize.
	message := ERDialog new id: 'error'; title: 'Error'; message: 'asd sfgd'.
]

{ #category : #accessing }
ERExample >> message [
	^ message
]

{ #category : #accessing }
ERExample >> message: anObject [
	message := anObject
]

{ #category : #rendering }
ERExample >> renderContentOn: html [
	self
		createColoredAnchorButton: 'REGISTER MYSELF AS ATTENDEE'
		id: 'registerMyseflAsAttendee'
		dialogId: 'error'
		condition: true
		on: html.
	html render: message
]

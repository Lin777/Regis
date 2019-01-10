Class {
	#name : #EREsugWebApp,
	#superclass : #WATask,
	#category : #'ESUGApp-Views'
}

{ #category : #initialization }
EREsugWebApp class >> canBeRoot [ 
	^ true
]

{ #category : #initialization }
EREsugWebApp class >> initialize [
	"self initialize"

	(WAAdmin register: self asApplicationAt: 'ESUG')
	
		addLibrary: JQDeploymentLibrary;
		addLibrary: MDLLibrary;
		addLibrary: ERMaterialBlueRedMinCss;
		addLibrary: ERJQValidateForm;
		addLibrary: CssForLoginMDL;
		addLibrary: ERLibrary;
		preferenceAt: #sessionClass
		put: ERSession
]

{ #category : #running }
EREsugWebApp >> go [
	| loginAnswer user |
	loginAnswer := self call: ERLoginView new.
	loginAnswer = #registerUser
		ifTrue: [ user := self call: (ERRegisterView register: (ERAttendeeRegistrationView new)) ]
		ifFalse: [ loginAnswer = #registerUserAsGroupManager
				ifTrue: [ user := self call: (ERRegisterView register: (ERGroupManagerRegistrationView new))  ]
				ifFalse: [ user := loginAnswer ] ].
	user
		ifNotNil: [ self session login: user.
			self call: ERPageLoggedView new ]
]

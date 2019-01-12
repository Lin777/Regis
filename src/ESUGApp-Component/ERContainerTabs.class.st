Class {
	#name : #ERContainerTabs,
	#superclass : #ERContainer,
	#instVars : [
		'tabView',
		'dialog',
		'messageComponent',
		'callback',
		'tabs'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #accessing }
ERContainerTabs class >> formAdminToGMRegisterOn: anAttendee withCallback: aBlock content: aContent [
	| form |
	form := self new.
	form content: aContent.
	form callback: aBlock.
	form initializeTabsForConvertAdminToGroupManager: anAttendee.
	form tabView: (ERTabs tabs: form tabs).
	^ form
]

{ #category : #accessing }
ERContainerTabs class >> formGMRegisterOn: anAttendee withCallback: aBlock content: aContent [
	| form |
	form := self new.
	form content: aContent.
	form callback: aBlock.
	form initializeTabsForGroupManager: anAttendee.
	form tabView: (ERTabs tabs: form tabs).
	^ form
]

{ #category : #accessing }
ERContainerTabs class >> formRegisterOn: anAttendee withCallback: aBlock content: aContent [
	| form |
	form := self new.
	form content: aContent.
	form callback: aBlock.
	form initializeTabsRegisterFor: anAttendee.
	form tabView: (ERTabs tabs: form tabs).
	^ form
]

{ #category : #accessing }
ERContainerTabs class >> formWithoutBasicInfoOn: anAttendee withCallback: aBlock content: aContent [
	| form |
	form := self new.
	form content: aContent.
	form callback: aBlock.
	form initializeTabsWithoutBasicInformationFor: anAttendee.
	form tabView: (ERTabs tabs: form tabs).
	^ form
]

{ #category : #'as yet unclassified' }
ERContainerTabs class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form initializeForm.
	^ form
]

{ #category : #accessing }
ERContainerTabs >> callback: anObject [
	callback := anObject
]

{ #category : #rendering }
ERContainerTabs >> cancel [
	content state: content lastState
]

{ #category : #accessing }
ERContainerTabs >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERContainerTabs >> initialize [
	super initialize .
	messageComponent := ERComponentAlert warningAlert id: 'registerAlert'.
	
]

{ #category : #initialization }
ERContainerTabs >> initializeDialog [
	dialog := ERDialog new
		title: 'Cancel Register Attendee';
		message: 'Are you sure you want to cancel?';
		idClose: 'buttonClose';
		idOpen: 'cancel-register-attendee';
		okCallback: [ self cancel ]
]

{ #category : #accessing }
ERContainerTabs >> initializeTabsForConvertAdminToGroupManager: anAttendee [
	tabs := OrderedCollection new
				
		add:
			(ERTabForAForm
				form: (ERAffiliationInformationForm on: anAttendee))activate;
		add:
			(ERDoneButton
				on: anAttendee
				button: [ :html | self renderDoneButtonOn: html ]);
		yourself
]

{ #category : #accessing }
ERContainerTabs >> initializeTabsForGroupManager: anAttendee [
	tabs := OrderedCollection new
		add:
			(ERTabForAForm form: (ERBasicInformationForm on: anAttendee))
				activate;
		add: (ERTabForAForm form: (ERAffiliationInformationForm on: anAttendee));
		add:
			(ERDoneButton
				on: anAttendee
				button: [ :html | self renderDoneButtonOn: html ]);
		yourself
]

{ #category : #accessing }
ERContainerTabs >> initializeTabsRegisterFor: anAttendee [
	tabs := OrderedCollection new
	add:
			(ERTabForAForm form: (ERBasicInformationForm on: anAttendee))
				activate;
		add:
			(ERTabForAForm form: (ERContactInformationForm on: anAttendee));
		add: (ERTabForAForm form: (ERRegisterConferenceForm on: anAttendee));
		add:
			(ERTabForAForm form: (ERAffiliationInformationForm on: anAttendee));
		add: (ERTabForAForm form: (ERAdditionalInformationForm on: anAttendee));
		add: (ERTabForAForm form: (ERPaymentForm on: anAttendee));
		add:
			(ERDoneButton
				on: anAttendee
				button: [ :html | self renderDoneButtonOn: html ]);
		yourself
]

{ #category : #accessing }
ERContainerTabs >> initializeTabsWithoutBasicInformationFor: anAttendee [
	tabs := OrderedCollection new
		
		add: (ERTabForAForm form: (ERContactInformationForm on: anAttendee)) activate;
		add: (ERTabForAForm form: (ERRegisterConferenceForm on: anAttendee));
		add:
			(ERTabForAForm form: (ERAffiliationInformationForm on: anAttendee));
		add: (ERTabForAForm form: (ERAdditionalInformationForm on: anAttendee));
		add: (ERTabForAForm form: (ERPaymentForm on: anAttendee));
		add:
			(ERDoneButton
				on: anAttendee
				button: [ :html | self renderDoneButtonOn: html ]);
		yourself
]

{ #category : #rendering }
ERContainerTabs >> renderCancelButton: html [
	self initializeDialog .
	self
		createColoredAnchorButton: 'Cancel'
		id: 'cancel-register-attendee'
		on: html
]

{ #category : #rendering }
ERContainerTabs >> renderContentPage: html [
	html mdlTabs rippleEffect
		with: [ html div
				style: 'overflow-x:auto;';
				with: [ html mdlGrid noSpacing
						with: [ 
							html render: messageComponent .
							html form
								method: 'post';
								id: 'formRegisterInTabs';
								with: [ html render: tabView.
									self renderCancelButton: html ] ] ] ].
	html render: dialog
]

{ #category : #accessing }
ERContainerTabs >> renderDoneButtonOn: html [
	self
		createRaisedRippleEffectPrimaryButton: 'Save Information'
		with: [ callback 
				on: ERException
				do: [ :exception | messageComponent errorMessage: exception messageText ] ]
		id: 'registerButton'
		on: html
]

{ #category : #accessing }
ERContainerTabs >> tabView [
	^ tabView
]

{ #category : #accessing }
ERContainerTabs >> tabView: anObject [
	tabView := anObject
]

{ #category : #accessing }
ERContainerTabs >> tabs [
	^ tabs
]

{ #category : #accessing }
ERContainerTabs >> tabs: anObject [
	tabs := anObject
]

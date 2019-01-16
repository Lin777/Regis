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
	form attendee: anAttendee.
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
	
	form attendee: anAttendee.
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
	
	form attendee: anAttendee.
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
	form attendee: anAttendee.
	form initializeTabsWithoutBasicInformationFor: anAttendee.
	form tabView: (ERTabs tabs: form tabs).
	^ form
]

{ #category : #accessing }
ERContainerTabs class >> formWithoutBasicInfoOn: anAttendee withCallback: aBlock withDialog: aDialog content: aContent [
	| form |
	form := self new.
	form content: aContent.
	form callback: aBlock.
	form attendee: anAttendee .
	form initializeTabsWithoutBasicInformationFor: anAttendee.
	form tabView: (ERTabs tabs: form tabs).
	form dialog: aDialog.
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
	attendee version > 0
		ifTrue: [ attendee abortChanges ].

	content state: content lastState
]

{ #category : #accessing }
ERContainerTabs >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERContainerTabs >> dialog: aDialog [
	dialog := aDialog 
]

{ #category : #rendering }
ERContainerTabs >> initialize [
	super initialize.
	messageComponent := ERAlert warningAlert id: 'registerAlert'.
	dialog := ERDialog new
				title: 'Cancel';
				message: 'Are you sure you want to cancel?'
]

{ #category : #initialization }
ERContainerTabs >> initializeDialog [
	dialog idClose: 'buttonClose';
		idOpen: 'cancel-register-attendee';
		okCallback: [ self cancel ].
]

{ #category : #accessing }
ERContainerTabs >> initializeTabsForConvertAdminToGroupManager: anAttendee [
	tabs := OrderedCollection new
				
		add:
			(ERTabForAForm
				form: (ERAffiliationInformationForm on: anAttendee)
				withContainer: self) activate;
		add:
			(ERDoneButton
				on: anAttendee
				button: [ :html | self renderDoneButtonOn: html ]
				container: self);
		yourself
]

{ #category : #accessing }
ERContainerTabs >> initializeTabsForGroupManager: anAttendee [
	tabs := OrderedCollection new
		add:
			(ERTabForAForm form: (ERBasicInformationForm on: anAttendee)
			withContainer: self)
				activate;
		add: (ERTabForAForm form: (ERAffiliationInformationForm on: anAttendee)
			withContainer: self);
		add:
			(ERDoneButton
				on: anAttendee
				button: [ :html | self renderDoneButtonOn: html ]
				container: self);
		yourself
]

{ #category : #accessing }
ERContainerTabs >> initializeTabsRegisterFor: anAttendee [
	tabs := OrderedCollection new
	add:
			(ERTabForAForm form: (ERBasicInformationForm on: anAttendee) withContainer: self)
				activate;
		add:
			(ERTabForAForm form: (ERContactInformationForm on: anAttendee) withContainer: self);
		add: (ERTabForAForm form: (ERRegisterConferenceForm on: anAttendee) withContainer: self);
		add:
			(ERTabForAForm form: (ERAffiliationInformationForm on: anAttendee) withContainer: self);
		add: (ERTabForAForm form: (ERAdditionalInformationForm on: anAttendee) withContainer: self);
		add: (ERTabForAForm form: (ERPaymentForm on: anAttendee) withContainer: self);
		add:
			(ERDoneButton
				on: anAttendee
				button: [ :html | self renderDoneButtonOn: html ]
				container: self);
		yourself
]

{ #category : #accessing }
ERContainerTabs >> initializeTabsWithoutBasicInformationFor: anAttendee [
	tabs := OrderedCollection new
		
		add: (ERTabForAForm form: (ERContactInformationForm on: anAttendee) withContainer: self) activate;
		add: (ERTabForAForm form: (ERRegisterConferenceForm on: anAttendee) withContainer: self);
		add:
			(ERTabForAForm form: (ERAffiliationInformationForm on: anAttendee) withContainer: self);
		add: (ERTabForAForm form: (ERAdditionalInformationForm on: anAttendee) withContainer: self);
		add: (ERTabForAForm form: (ERPaymentForm on: anAttendee) withContainer: self);
		add:
			(ERDoneButton
				on: anAttendee
				button: [ :html | self renderDoneButtonOn: html ]
				container: self);
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
		with: [ 
			callback
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

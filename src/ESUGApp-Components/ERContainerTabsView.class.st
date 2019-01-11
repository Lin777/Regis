Class {
	#name : #ERContainerTabsView,
	#superclass : #ERContainerView,
	#instVars : [
		'tabView',
		'dialog',
		'messageComponent',
		'callback',
		'tabs'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #accessing }
ERContainerTabsView class >> formAdminToGMRegisterOn: anAttendee withCallback: aBlock content: aContent [
	| form |
	form := self new.
	form content: aContent.
	form callback: aBlock.
	form initializeTabsForConvertAdminToGroupManager: anAttendee.
	form tabView: (ERTabsView tabs: form tabs).
	^ form
]

{ #category : #accessing }
ERContainerTabsView class >> formGMRegisterOn: anAttendee withCallback: aBlock content: aContent [
	| form |
	form := self new.
	form content: aContent.
	form callback: aBlock.
	form initializeTabsForGroupManager: anAttendee.
	form tabView: (ERTabsView tabs: form tabs).
	^ form
]

{ #category : #accessing }
ERContainerTabsView class >> formRegisterOn: anAttendee withCallback: aBlock content: aContent [
	| form |
	form := self new.
	form content: aContent.
	form callback: aBlock.
	form initializeTabsRegisterFor: anAttendee.
	form tabView: (ERTabsView tabs: form tabs).
	^ form
]

{ #category : #accessing }
ERContainerTabsView class >> formWithoutBasicInfoOn: anAttendee withCallback: aBlock content: aContent [
	| form |
	form := self new.
	form content: aContent.
	form callback: aBlock.
	form initializeTabsWithoutBasicInformationFor: anAttendee.
	form tabView: (ERTabsView tabs: form tabs).
	^ form
]

{ #category : #'as yet unclassified' }
ERContainerTabsView class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form initializeForm.
	^ form
]

{ #category : #accessing }
ERContainerTabsView >> callback: anObject [
	callback := anObject
]

{ #category : #rendering }
ERContainerTabsView >> cancel [
	content state: content lastState
]

{ #category : #accessing }
ERContainerTabsView >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERContainerTabsView >> initialize [
	super initialize .
	messageComponent := ERComponentAlert warningAlert id: 'registerAlert'.
	
]

{ #category : #initialization }
ERContainerTabsView >> initializeDialog [
	dialog := ERDialog new
		title: 'Cancel Register Attendee';
		message: 'Are you sure you want to cancel?';
		idClose: 'buttonClose';
		idOpen: 'cancel-register-attendee';
		okCallback: [ self cancel ]
]

{ #category : #accessing }
ERContainerTabsView >> initializeTabsForConvertAdminToGroupManager: anAttendee [
	tabs := OrderedCollection new
				
		add:
			(ERTabForAForm
				form: (ERAffiliationInformation on: anAttendee))activate;
		add:
			(ERDoneForm
				on: anAttendee
				button: [ :html | self renderDoneButtonOn: html ]);
		yourself
]

{ #category : #accessing }
ERContainerTabsView >> initializeTabsForGroupManager: anAttendee [
	tabs := OrderedCollection new
		add:
			(ERTabForAForm form: (ERBasicInformation on: anAttendee))
				activate;
		add: (ERTabForAForm form: (ERAffiliationInformation on: anAttendee));
		add:
			(ERDoneForm
				on: anAttendee
				button: [ :html | self renderDoneButtonOn: html ]);
		yourself
]

{ #category : #accessing }
ERContainerTabsView >> initializeTabsRegisterFor: anAttendee [
	tabs := OrderedCollection new
	add:
			(ERTabForAForm form: (ERBasicInformation on: anAttendee))
				activate;
		add:
			(ERTabForAForm form: (ERContactInformation on: anAttendee));
		add: (ERTabForAForm form: (ERConferenceOptions on: anAttendee));
		add:
			(ERTabForAForm form: (ERAffiliationInformation on: anAttendee));
		add: (ERTabForAForm form: (ERAdditionalInformation on: anAttendee));
		add: (ERTabForAForm form: (ERPaymentInformation on: anAttendee));
		add:
			(ERDoneForm
				on: anAttendee
				button: [ :html | self renderDoneButtonOn: html ]);
		yourself
]

{ #category : #accessing }
ERContainerTabsView >> initializeTabsWithoutBasicInformationFor: anAttendee [
	tabs := OrderedCollection new
		
		add: (ERTabForAForm form: (ERContactInformation on: anAttendee)) activate;
		add: (ERTabForAForm form: (ERConferenceOptions on: anAttendee));
		add:
			(ERTabForAForm form: (ERAffiliationInformation on: anAttendee));
		add: (ERTabForAForm form: (ERAdditionalInformation on: anAttendee));
		add: (ERTabForAForm form: (ERPaymentInformation on: anAttendee));
		add:
			(ERDoneForm
				on: anAttendee
				button: [ :html | self renderDoneButtonOn: html ]);
		yourself
]

{ #category : #rendering }
ERContainerTabsView >> renderCancelButton: html [
	self initializeDialog .
	self
		createColoredAnchorButton: 'Cancel'
		id: 'cancel-register-attendee'
		on: html
]

{ #category : #rendering }
ERContainerTabsView >> renderContentPage: html [
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
ERContainerTabsView >> renderDoneButtonOn: html [
	self
		createRaisedRippleEffectPrimaryButton: 'Save Information'
		with: [ callback 
				on: ERException
				do: [ :exception | messageComponent errorMessage: exception messageText ] ]
		id: 'registerButton'
		on: html
]

{ #category : #accessing }
ERContainerTabsView >> tabView [
	^ tabView
]

{ #category : #accessing }
ERContainerTabsView >> tabView: anObject [
	tabView := anObject
]

{ #category : #accessing }
ERContainerTabsView >> tabs [
	^ tabs
]

{ #category : #accessing }
ERContainerTabsView >> tabs: anObject [
	tabs := anObject
]

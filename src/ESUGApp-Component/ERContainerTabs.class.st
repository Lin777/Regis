Class {
	#name : #ERContainerTabs,
	#superclass : #ERContainer,
	#instVars : [
		'tabView',
		'dialog',
		'messageComponent',
		'callback',
		'tabs',
		'saveTabs'
	],
	#category : #'ESUGApp-Component'
}

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
"	attendee version > 0
		ifTrue: [ attendee abortChanges ]."

	content state: content lastState.
	"self updateStateTab: self tabName."
]

{ #category : #rendering }
ERContainerTabs >> children [ 
	^ Array with: messageComponent with: tabView with: dialog
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
	dialog := ERDialog cancelDialog
]

{ #category : #initialization }
ERContainerTabs >> initializeDialog [
	dialog idClose: 'buttonClose';
		idOpen: 'cancel-register-attendee';
		okCallback: [ self cancel ].
]

{ #category : #accessing }
ERContainerTabs >> initializeTabsRegisterFor: anAttendee [
	tabs := OrderedCollection new
	add: (self createBasicInfoTab: anAttendee withContent: self) activate;
	add: (self createContactInfoTab: anAttendee withContent: self );
	add: (self createRegConferenceInfoTab: anAttendee withContent: self );
	add: (self createAffiliationInfoTab: anAttendee withContent: self);
	add: (self createAdditionalInfoTab: anAttendee withContent: self);
	add: (self createPaymentInfoTab: anAttendee withContent: self );
		add:
			(ERDoneButton
				on: anAttendee
				button: [ :html | self renderDoneButtonOn: html ]
				container: self);
		yourself.
	saveTabs := [ self saveAttendeeTabs ]
]

{ #category : #accessing }
ERContainerTabs >> initializeTabsWithoutBasicInformationFor: anAttendee [
	tabs := OrderedCollection new
	add: (self createContactInfoTab: anAttendee withContent: self ) activate;
	add: (self createRegConferenceInfoTab: anAttendee withContent: self );
	add: (self createAffiliationInfoTab: anAttendee withContent: self);
	add: (self createAdditionalInfoTab: anAttendee withContent: self);
	add: (self createPaymentInfoTab: anAttendee withContent: self );
		add:
			(ERDoneButton
				on: anAttendee
				button: [ :html | self renderDoneButtonOn: html ]
				container: self);
		yourself.
	saveTabs := [ self saveAttendeeToGroupManagerTabs ]
]

{ #category : #rendering }
ERContainerTabs >> renderBackButtonOn: html [
	html mdlAnchorButton
		colored;
		rippleEffect;
		id: 'previousButton';
		class: 'btnPrevious';
		with: 'Previous'
]

{ #category : #rendering }
ERContainerTabs >> renderButtonsOn: html [
	self renderCancelButtonOn: html.
	self renderBackButtonOn: html.
	self renderNextButtonOn: html
]

{ #category : #rendering }
ERContainerTabs >> renderCancelButtonOn: html [
	self initializeDialog .
	html mdlAnchorButton 
		openDialogWithId: 'cancel-register-attendee'; 
		colored;
		with: 'Cancel'.
]

{ #category : #rendering }
ERContainerTabs >> renderContentPageOn: html [
	html form
		method: 'post';
		id: 'formRegisterInTabs';
		with: [
	html mdlTabs rippleEffect
		with: [ html div
				style: 'overflow-x:auto;';
				with: [ html render: messageComponent .
							 html render: tabView.
									self renderButtonsOn: html] ]] .
	html render: dialog
]

{ #category : #accessing }
ERContainerTabs >> renderDoneButtonOn: html [
	html mdlButton
		beSubmit;
		raised;
		primaryColor;
		rippleEffect;
		id: 'registerButton';
		callback: [ 
			saveTabs
				on: ERException
				do: [ :exception | messageComponent errorMessage: exception messageText ] ];
		with: 'Save Information'
]

{ #category : #rendering }
ERContainerTabs >> renderNextButtonOn: html [
	html mdlAnchorButton
		colored;
		rippleEffect;
		id: 'nextButton';
		class: 'btnNext';
		with: 'Next'
]

{ #category : #accessing }
ERContainerTabs >> saveAdditionalInfoAt: index [
	(tabs at: index)contentTab save.
	attendee additionalInformation: (tabs at: index)contentTab model 
]

{ #category : #accessing }
ERContainerTabs >> saveAffiliationInfoAt: index [
	(tabs at: index)contentTab save.
	attendee affiliationInformation: (tabs at: index)contentTab model 
]

{ #category : #accessing }
ERContainerTabs >> saveAttendeeTabs [
	self saveUserAccountAt: 1.
	self saveContactInfoAt: 2.
	self saveRegConferenceInfoAt: 3.
	self saveAffiliationInfoAt: 4.
	self saveAdditionalInfoAt: 5.
	self savePaymentInfoAt: 6.
	callback cull: attendee
]

{ #category : #accessing }
ERContainerTabs >> saveAttendeeToGroupManagerTabs [
	self saveContactInfoAt: 1.
	self saveRegConferenceInfoAt: 2.
	self saveAffiliationInfoAt: 3.
	self saveAdditionalInfoAt: 4.
	self savePaymentInfoAt: 5.
	callback cull: attendee
]

{ #category : #accessing }
ERContainerTabs >> saveContactInfoAt: index [
	(tabs at: index) contentTab save.
	attendee contactInformation: (tabs at: index) contentTab model
]

{ #category : #accessing }
ERContainerTabs >> savePaymentInfoAt: index [
	(tabs at: index)contentTab save.
	attendee paymentInformation: (tabs at: index)contentTab model 
]

{ #category : #accessing }
ERContainerTabs >> saveRegConferenceInfoAt: index [
	(tabs at: index)contentTab save.
	attendee conferenceInformation: (tabs at: index)contentTab model 
]

{ #category : #accessing }
ERContainerTabs >> saveUserAccountAt: index [
	(tabs at: index) contentTab save.
	attendee userAccount: (tabs at: index) contentTab model
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

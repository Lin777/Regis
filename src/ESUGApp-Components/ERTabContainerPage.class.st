Class {
	#name : #ERTabContainerPage,
	#superclass : #ERTab,
	#instVars : [
		'messageComponent',
		'controller',
		'callback',
		'mofidyUserForm',
		'formWithoutBasicInfo',
		'formRegister',
		'attenteeRegisterForm'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERTabContainerPage class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	^ form
]

{ #category : #rendering }
ERTabContainerPage >> alreadyRegisteredAsAttendee [
	^ attendee userAccount isAttendee
]

{ #category : #accessing }
ERTabContainerPage >> callback [
	^ callback
]

{ #category : #accessing }
ERTabContainerPage >> callback: anObject [
	callback := anObject
]

{ #category : #accessing }
ERTabContainerPage >> content: anObject [
	content := anObject
]

{ #category : #accessing }
ERTabContainerPage >> controller [
	^ controller
]

{ #category : #accessing }
ERTabContainerPage >> controller: anObject [
	controller := anObject
]

{ #category : #'as yet unclassified' }
ERTabContainerPage >> formWithoutBasicInformationFor: anAttendee [
	^ OrderedCollection new
		add:
			(ERTabForAForm form: (ERContactInformation on: anAttendee))
				activate;
		add: (ERTabForAForm form: (ERConferenceOptions on: anAttendee));
		add:
			(ERTabForAForm form: (ERAffiliationInformation on: anAttendee));
		add: (ERTabForAForm form: (ERAdditionalInformation on: anAttendee));
		add: (ERTabForAForm form: (ERPaymentInformation on: anAttendee));
		add: (ERDoneForm on: anAttendee callback: callback);
		yourself
]

{ #category : #initialization }
ERTabContainerPage >> initialize [
	super initialize.
	messageComponent := ERComponentAlert warningAlert.
]

{ #category : #initialization }
ERTabContainerPage >> initializeFormRegister [
	formRegister := (ERContainerTabsView content: content)
		tabView: (ERTabsView tabs: self tabs)
]

{ #category : #accessing }
ERTabContainerPage >> initializeFormWithoutBasicInformationFor: anAttendee [
	formWithoutBasicInfo := (ERContainerTabsView content: content)
		tabView: (ERTabsView tabs: (self formWithoutBasicInformationFor: anAttendee)).
	content state: formWithoutBasicInfo
]

{ #category : #accessing }
ERTabContainerPage >> modifyRegistrationInformation: anAttendee [
	callback := [ self updateRegistrationInformation: anAttendee ].
	
	self initializeFormWithoutBasicInformationFor: anAttendee
]

{ #category : #accessing }
ERTabContainerPage >> modifyUserFormGroup: anAttendee [
	mofidyUserForm := ERContainerModifyUserView
		on: anAttendee
		withContent: content.
	content state: mofidyUserForm
]

{ #category : #rendering }
ERTabContainerPage >> registerAttendee [
	self initializeFormRegister.
	content state: formRegister
]

{ #category : #rendering }
ERTabContainerPage >> renderContainer: html [
	self subclassResponsibility 
]

{ #category : #rendering }
ERTabContainerPage >> renderContentOn: html [
	html heading level3; with: self title .
	self renderContainer: html
]

{ #category : #initialization }
ERTabContainerPage >> tabs [
	self subclassResponsibility 
]

{ #category : #accessing }
ERTabContainerPage >> title [
	self subclassResponsibility 
]

{ #category : #accessing }
ERTabContainerPage >> updateRegistrationInformation: anAttendee [
	anAttendee save.
	content state: content lastState
]

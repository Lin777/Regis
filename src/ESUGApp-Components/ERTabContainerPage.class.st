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
		'attenteeRegisterForm',
		'formApplyReductionTicket',
		'newAttendee'
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

{ #category : #initialization }
ERTabContainerPage >> initialize [
	super initialize.
	messageComponent := ERComponentAlert warningAlert id: 'tabAlert'.
]

{ #category : #initialization }
ERTabContainerPage >> initializeFormRegister [
	newAttendee := ERAttendee new.
	formRegister := ERContainerTabsView
		formRegisterOn: newAttendee
		withCallback: callback
		content: content
]

{ #category : #initialization }
ERTabContainerPage >> initializeFormWithoutBasicInformationFor: anAttendee [
	formWithoutBasicInfo := ERContainerTabsView
		formWithoutBasicInfoOn: anAttendee
		withCallback: callback
		content: content.
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
	(ERRegistrationController attendee: anAttendee ) validateRegister .
	anAttendee save.
	content state: content lastState
]

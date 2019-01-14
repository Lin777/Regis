Class {
	#name : #ERFinishRegisterPage,
	#superclass : #ERPage,
	#category : #'ESUGApp-View-Page'
}

{ #category : #'as yet unclassified' }
ERFinishRegisterPage class >> on: anAttendee withContent: content withController: aController [
	^ self new
		attendee: anAttendee;
		content: content;
		pageController: aController.
		
]

{ #category : #rendering }
ERFinishRegisterPage >> backAction [
	self subclassResponsibility
]

{ #category : #rendering }
ERFinishRegisterPage >> cancelAction [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
ERFinishRegisterPage >> colorIcon [
	^ 'mdl-color--green'
]

{ #category : #accessing }
ERFinishRegisterPage >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERFinishRegisterPage >> finishAction [
	self subclassResponsibility 
]

{ #category : #initialization }
ERFinishRegisterPage >> initialize [
	super initialize.
	title := 'Registration Summary'.
	icon := 'done'.
	id := 'login-conatiner'.
	classContainer := 'mdl-card-register'
]

{ #category : #rendering }
ERFinishRegisterPage >> nextAction [
	self subclassResponsibility
]

{ #category : #'tools registry' }
ERFinishRegisterPage >> register [
	| user |
	user := pageController save.
	self validateRegister: user
]

{ #category : #rendering }
ERFinishRegisterPage >> registerAsGroupManager [
	| user |
	user := pageController saveAsGroupManager.
	self validateRegister: user
]

{ #category : #rendering }
ERFinishRegisterPage >> renderActions: html [
	html mdlCardActions
		class: 'mdl-card--border';
		with: [ self
				createColoredAnchorButton: 'Back'
				with: [ self backAction ]
				id: 'back'
				on: html.
			self
				createColoredAnchorButton: 'Next'
				with: [ self nextAction ]
				id: 'next'
				on: html.
			self
				createColoredAnchorButton: 'Cancel'
				with: [ self cancelAction ]
				id: 'cancel'
				on: html.
			self
				createColoredAnchorButton: 'Finish'
				with: [ self finishAction ]
				id: 'finish'
				on: html ]
]

{ #category : #rendering }
ERFinishRegisterPage >> renderPageOn: html [
	self subclassResponsibility 
]

{ #category : #rendering }
ERFinishRegisterPage >> renderStrong: html with: aString1 and: aString2 [
	html strong: aString1.
	aString2
		ifNotNil: [ html text: aString2.
			html break ]
]

{ #category : #rendering }
ERFinishRegisterPage >> renderTitle: html with: aString [
	html heading level6
		with: [ self renderStrong: html with: aString and: nil ].
	html horizontalRule
]

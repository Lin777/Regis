Class {
	#name : #ERFinishRegister,
	#superclass : #ERPageView,
	#category : #'ESUGApp-Views'
}

{ #category : #'as yet unclassified' }
ERFinishRegister class >> on: anAttendee withContent: content withController: aController [
	^ self new
		attendee: anAttendee;
		content: content;
		pageController: aController.
		
]

{ #category : #rendering }
ERFinishRegister >> backAction [
	self subclassResponsibility
]

{ #category : #rendering }
ERFinishRegister >> cancelAction [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
ERFinishRegister >> colorIcon [
	^ 'mdl-color--green'
]

{ #category : #accessing }
ERFinishRegister >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERFinishRegister >> finishAction [
	self subclassResponsibility 
]

{ #category : #initialization }
ERFinishRegister >> initialize [
	super initialize.
	title := 'Registration Summary'.
	icon := 'done'.
	id := 'login-conatiner'.
	classContainer := 'mdl-card-register'
]

{ #category : #rendering }
ERFinishRegister >> nextAction [
	self subclassResponsibility
]

{ #category : #'tools registry' }
ERFinishRegister >> register [
	| user |
	user := pageController save.
	self validateRegister: user
]

{ #category : #rendering }
ERFinishRegister >> registerAsGroupManager [
	| user |
	user := pageController saveAsGroupManager.
	self validateRegister: user
]

{ #category : #rendering }
ERFinishRegister >> renderActions: html [
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
ERFinishRegister >> renderPageOn: html [
	self subclassResponsibility 
]

{ #category : #rendering }
ERFinishRegister >> renderStrong: html with: aString1 and: aString2 [
	html strong: aString1.
	aString2
		ifNotNil: [ html text: aString2.
			html break ]
]

{ #category : #rendering }
ERFinishRegister >> renderTitle: html with: aString [
	html heading level6
		with: [ self renderStrong: html with: aString and: nil ].
	html horizontalRule
]

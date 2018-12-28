Class {
	#name : #ERContainerView,
	#superclass : #ERStateContent,
	#category : #'ESUGApp-Components'
}

{ #category : #accessing }
ERContainerView class >> attendee: anAttendee [
	| instance |
	instance := self new.
	instance attendee: anAttendee.
	^ instance
]

{ #category : #accessing }
ERContainerView >> attendee [
	^ attendee
]

{ #category : #accessing }
ERContainerView >> attendee: anObject [
	attendee := anObject
]

{ #category : #rendering }
ERContainerView >> renderContentOn: html [
	html mdlLayoutContent 
		class: ' mdl-color--grey-100';
		with: [ html mdlCard
				class:
					'mdl-card__supporting-text mdl-color--white mdl-shadow--2dp mdl-cell mdl-cell--12-col';
				with: [ self renderContentPage: html ] ]
]

{ #category : #rendering }
ERContainerView >> renderContentPage: html [
	self subclassResponsibility 
]

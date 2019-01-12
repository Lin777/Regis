Class {
	#name : #ERContainer,
	#superclass : #ERStateContent,
	#category : #'ESUGApp-Component'
}

{ #category : #accessing }
ERContainer class >> attendee: anAttendee [
	| instance |
	instance := self new.
	instance attendee: anAttendee.
	^ instance
]

{ #category : #accessing }
ERContainer >> attendee [
	^ attendee
]

{ #category : #accessing }
ERContainer >> attendee: anObject [
	attendee := anObject
]

{ #category : #rendering }
ERContainer >> renderContentOn: html [
	html mdlLayoutContent 
		class: ' mdl-color--grey-100';
		with: [ html mdlCard
				class:
					'mdl-card__supporting-text mdl-color--white mdl-shadow--2dp mdl-cell mdl-cell--12-col';
				with: [ self renderContentPage: html ] ]
]

{ #category : #rendering }
ERContainer >> renderContentPage: html [
	self subclassResponsibility 
]

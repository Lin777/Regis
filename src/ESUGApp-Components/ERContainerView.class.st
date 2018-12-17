Class {
	#name : #ERContainerView,
	#superclass : #WAComponent,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #accessing }
ERContainerView class >> attendee: anAttendee [
	|instance|
	instance := self new.
	instance attendee: anAttendee .
	^ instance 
]

{ #category : #accessing }
ERContainerView >> attendee: anObject [
	attendee := anObject
]

{ #category : #rendering }
ERContainerView >> renderContentOn: html [
	html html: '<main class="mdl-layout__content mdl-color--grey-100">
          <div class="mdl-card mdl-card__supporting-text mdl-color--white mdl-shadow--2dp mdl-cell mdl-cell--12-col">'.
  self renderContentPage: html.
  html html: '</div>
      </main>'.
]

{ #category : #rendering }
ERContainerView >> renderContentPage: html [
	self subclassResponsibility 
]

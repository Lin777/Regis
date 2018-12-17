Class {
	#name : #ERCardView,
	#superclass : #ERComponent,
	#instVars : [
		'content',
		'title',
		'iconPage'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERCardView class >> title: aString icon: anIcon content: aBlock [
	| instance |
	instance := self new.
	instance title: aString.
	instance iconPage: anIcon .
	instance content: aBlock .
	^ instance
]

{ #category : #'as yet unclassified' }
ERCardView class >> title: aString icon: anIcon content: aBlock id: anId [
	| instance |
	instance := self new.
	instance title: aString.
	instance iconPage: anIcon .
	instance content: aBlock .
	instance id: anId .
	^ instance
]

{ #category : #accessing }
ERCardView >> content [
	^ content
]

{ #category : #accessing }
ERCardView >> content: anObject [
	content := anObject
]

{ #category : #accessing }
ERCardView >> iconPage [
	^ iconPage
]

{ #category : #accessing }
ERCardView >> iconPage: anObject [
	iconPage := anObject
]

{ #category : #rendering }
ERCardView >> renderContentOn: html [ 
	html html: '<br><br><br>      
<div id="', self id,'" class="mdl-card mdl-shadow--16dp">
  <div class="mdl-card__supporting-text">'.
     self renderIconCard: html.   
				html html: '<div id="card-heading">', self title ,'</div>'.
		self content value.
	html html: '</div>
	</div>'
]

{ #category : #rendering }
ERCardView >> renderIconCard: html [
	html html: '<div id="login-fab" class="mdl-color--red mdl-color-text--white">
					<i id="lock-icon" class="material-icons">', self iconPage,'</i>
				</div>'
]

{ #category : #accessing }
ERCardView >> title [
	^ title
]

{ #category : #accessing }
ERCardView >> title: anObject [
	title := anObject
]

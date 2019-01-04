Class {
	#name : #ERDialog,
	#superclass : #ERComponent,
	#instVars : [
		'message',
		'title',
		'callback'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #accessing }
ERDialog >> callback [
	^ callback
]

{ #category : #accessing }
ERDialog >> callback: anObject [
	callback := anObject
]

{ #category : #accessing }
ERDialog >> message: anObject [
	message := anObject
]

{ #category : #rendering }
ERDialog >> renderContentOn: html [
	"| idButtonClose |
	html mdlDialog
		id: self id;
		closeButtonId: (idButtonClose := html nextId);
		with: [ html mdlDialogTitle: title.
			html mdlDialogContent: [ html paragraph: message ].
			html
				mdlDialogActions: [ html mdlButton: 'Ok'.
					html mdlButton
						id: idButtonClose;
						bePush;
						with: 'Cancel' ] ]"
	html div
      id: self id;
      script: (html jQuery new dialog
         title: title;
         autoOpen: false;
         addButton: 'Close' do: html jQuery new dialog close);
      with: [ html paragraph: message ].
 
]

{ #category : #accessing }
ERDialog >> title: anObject [
	title := anObject
]

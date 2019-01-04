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
	| idButtonOpen idButtonClose |
	html mdlDialog
		id: self id;
		openButtonId: idButtonOpen;
		closeButtonId: (idButtonClose := html nextId);
		with: [ html mdlDialogTitle: title.
			html mdlDialogContent: [ html paragraph: message ].
			html
				mdlDialogActions: [ html mdlButton: 'Ok'.
					html mdlButton
						id: idButtonClose;
						bePush;
						with: 'Cancel' ] ]
]

{ #category : #accessing }
ERDialog >> title: anObject [
	title := anObject
]

Class {
	#name : #ERDialog,
	#superclass : #ERComponent,
	#instVars : [
		'message',
		'title',
		'callback',
		'idOpen',
		'idClose',
		'okCallback'
	],
	#category : #'ESUGApp-Component'
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
ERDialog >> idClose: anObject [
	idClose := anObject
]

{ #category : #accessing }
ERDialog >> idOpen: anObject [
	idOpen := anObject
]

{ #category : #accessing }
ERDialog >> message: anObject [
	message := anObject
]

{ #category : #accessing }
ERDialog >> okCallback: anObject [
	okCallback := anObject
]

{ #category : #rendering }
ERDialog >> renderContentOn: html [
	html mdlDialog
		closeButtonId: idClose;
		openButtonId: idOpen;
		with: [ html mdlDialogTitle: title.
			html mdlDialogContent: [ html paragraph: message ].
			html
				mdlDialogActions: [ html mdlAnchorButton
						callback: okCallback;
						with: 'Ok'.
					html mdlButton
						id: idClose;
						bePush;
						with: 'Cancel' ] ]
]

{ #category : #accessing }
ERDialog >> title: anObject [
	title := anObject
]

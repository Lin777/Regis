"
Description
--------------------

I am a container in tab
"
Class {
	#name : #ERContentTab,
	#superclass : #ERTab,
	#instVars : [
		'contentTab',
		'previousContentTab',
		'action',
		'nextTabName',
		'previousTabName',
		'cancelCallback'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #accessing }
ERContentTab >> action: anObject [
	action := anObject
]

{ #category : #accessing }
ERContentTab >> actionBackBlock [
	^ [self updateStateTab: previousTabName]
]

{ #category : #rendering }
ERContentTab >> actionNextBlock [
	^ [ [ |model|
		model := (self contentTab save) model.
		action value: model.
		self updateStateTab: nextTabName ]
	on: ERException 
	do: [:exception | 
			self updateStateTab: self tabName .
			messageComponent errorMessage: exception messageText ]]
]

{ #category : #accessing }
ERContentTab >> cancelCallback: anObject [
	cancelCallback := anObject
]

{ #category : #rendering }
ERContentTab >> children [
	^ super children asOrderedCollection copyWithAll: (OrderedCollection new
		add: contentTab;
		yourself); yourself
]

{ #category : #accessing }
ERContentTab >> contentTab [
	^ contentTab
]

{ #category : #accessing }
ERContentTab >> contentTab: anObject [
	contentTab := anObject
]

{ #category : #initialization }
ERContentTab >> initialize [
	super initialize.
	messageComponent := ERAlert warningAlert.
	cancelCallback := [ container content state: container content lastState ].
	action := [ :aValue |  ]
]

{ #category : #accessing }
ERContentTab >> nextTabName: anObject [
	nextTabName := anObject
]

{ #category : #accessing }
ERContentTab >> previousContentTab: anObject [
	previousContentTab := anObject
]

{ #category : #accessing }
ERContentTab >> previousTabName: anObject [
	previousTabName := anObject
]

{ #category : #rendering }
ERContentTab >> renderBackButtonOn: html [
	previousTabName ifNotNil: [
	html mdlAnchorButton
		colored;
		rippleEffect;
		id: self tabId ,'-previousButton';
		callback: self actionBackBlock;
		with: 'Previous']
]

{ #category : #rendering }
ERContentTab >> renderButtonsOn: html [
	html horizontalRule.
	self renderGoBackToLogin: html.
	self renderBackButtonOn: html.
	self renderNextButtonOn: html
]

{ #category : #rendering }
ERContentTab >> renderContentOn: html [
	html form
		method: 'post';
		id: self tabId,'-form';
		with: [ 
	html render: messageComponent.
	self renderPreviousContentOn: html.
	html render: contentTab.
	self renderButtonsOn: html]
	
]

{ #category : #rendering }
ERContentTab >> renderGoBackToLogin: html [
	html mdlButton
		colored;
		beSubmit;
		rippleEffect;
		onClick: 'return confirm(''You are sure to return? You will lose all your changes'');';
		id: self tabId ,'-goBackLoginButton';
		callback: cancelCallback "[self session logout.
    ^ self requestContext redirectTo: self application url]";
		with: 'Cancel'
]

{ #category : #rendering }
ERContentTab >> renderNextButtonOn: html [
	nextTabName ifNotNil: [
	html mdlButton
		colored;
		beSubmit;
		rippleEffect;
		id: self tabId ,'-nextButton';
		callback: self actionNextBlock;
		with: 'Next']
]

{ #category : #rendering }
ERContentTab >> renderPreviousContentOn: html [
	previousContentTab isNotNil 
		ifTrue: [ html html: previousContentTab ]
]

{ #category : #rendering }
ERContentTab >> tabId: aString [
	tabId := aString.
	messageComponent  id: self tabId ,'-tabAlert'.
]

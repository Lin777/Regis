Extension { #name : #MATableRenderer }

{ #category : #'*ESUGApp-MDLMagritte' }
MATableRenderer >> renderContainer: aDescription [ 
	"html div
		class: (self classFor: aDescription);
		with: [ "super renderContainer: aDescription "]"
]

{ #category : #'*ESUGApp-MDLMagritte' }
MATableRenderer >> renderControl: aDescription [
	html div
		class: (self classFor: aDescription);
		with: [ self basicRenderControl: aDescription ]
]

{ #category : #'*ESUGApp-MDLMagritte' }
MATableRenderer >> renderElement: aDescription [
	aDescription group = group
		ifFalse: [ self renderGroup: aDescription ].
	"html tableRow:  [" self renderElementRow: aDescription "]"
]

{ #category : #'*ESUGApp-MDLMagritte' }
MATableRenderer >> renderGroup: aDescription [
	super renderGroup: aDescription.
	group isNil ifTrue: [ ^ self ].
	html div class: 'group'; with: [ 
		html tableHeading
			colSpan: 2;
			with: group ]
]

{ #category : #'*ESUGApp-MDLMagritte' }
MATableRenderer >> renderLabel: aDescription [
	aDescription withoutLabel ifFalse: [
		html tableHeading
			title: aDescription comment;
			class: (self classFor: aDescription);
			with: [ super renderLabel: aDescription ] ]
]

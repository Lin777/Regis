Class {
	#name : #MADivRenderer,
	#superclass : #MAComponentRenderer,
	#category : #'ESUGApp-MDLMagritte'
}

{ #category : #rendering }
MADivRenderer >> renderContainer: aDescription [ 
	super renderContainer: aDescription
]

{ #category : #rendering }
MADivRenderer >> renderControl: aDescription [
	html div
		class: (self classFor: aDescription);
		with: [ self basicRenderControl: aDescription ]
]

{ #category : #rendering }
MADivRenderer >> renderElement: aDescription [
	aDescription group = group
		ifFalse: [ self renderGroup: aDescription ].
	self renderElementRow: aDescription
]

{ #category : #rendering }
MADivRenderer >> renderElementRow: aDescription [
	"Extracted this method to be better able to override behavior"

	self renderLabel: aDescription.
	self renderControl: aDescription
]

{ #category : #rendering }
MADivRenderer >> renderGroup: aDescription [
	super renderGroup: aDescription.
	group isNil ifTrue: [ ^ self ].
	html div class: 'group'; with: [ 
		html tableHeading
			colSpan: 2;
			with: group ]
]

{ #category : #rendering }
MADivRenderer >> renderLabel: aDescription [
	aDescription withoutLabel ifFalse: [
		html tableHeading
			title: aDescription comment;
			class: (self classFor: aDescription);
			with: [ super renderLabel: aDescription ] ]
]

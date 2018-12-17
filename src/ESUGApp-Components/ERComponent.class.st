Class {
	#name : #ERComponent,
	#superclass : #WAComponent,
	#instVars : [
		'id',
		'percent'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #accessing }
ERComponent >> id [
	^ id
]

{ #category : #accessing }
ERComponent >> id: anObject [
	id := anObject
]

{ #category : #initialization }
ERComponent >> initialize [
	super initialize.
	self percent: 100
]

{ #category : #accessing }
ERComponent >> percent [
	^ percent
]

{ #category : #accessing }
ERComponent >> percent: anObject [
	percent := ('width:',anObject asString ,'%')
]

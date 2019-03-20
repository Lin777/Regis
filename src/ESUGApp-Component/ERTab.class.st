Class {
	#name : #ERTab,
	#superclass : #ERStateContent,
	#instVars : [
		'active',
		'id',
		'container',
		'tabId',
		'messageComponent',
		'tabName',
		'disabled'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #activation }
ERTab >> activate [
	active := true.
]

{ #category : #activation }
ERTab >> attendee: anObject [
	attendee := anObject
]

{ #category : #activation }
ERTab >> children [ 	
	^ Array with: messageComponent  
]

{ #category : #activation }
ERTab >> container: aContainer [
	container := aContainer
]

{ #category : #activation }
ERTab >> deactivate [
	active := false.
]

{ #category : #accessing }
ERTab >> disabled [
	^ disabled 	
]

{ #category : #accessing }
ERTab >> disabled: anObject [
	disabled := anObject
]

{ #category : #activation }
ERTab >> initialize [
	super initialize.
	active := false.
	disabled := false.
	messageComponent := ERAlert warningAlert id: 'tabAlert'.
]

{ #category : #activation }
ERTab >> isActive [
	^ active.
]

{ #category : #activation }
ERTab >> renderContentOn: html [
	self subclassResponsibility 
]

{ #category : #activation }
ERTab >> tabId [
	^ tabId 
]

{ #category : #activation }
ERTab >> tabId: anObject [
	tabId := anObject
]

{ #category : #activation }
ERTab >> tabName [
	^ tabName 
]

{ #category : #activation }
ERTab >> tabName: anObject [
	tabName := anObject
]

{ #category : #activation }
ERTab >> updateStateTab: aString [
	container tabs detect: [ :tab | (tab tabName = aString) ]
	ifFound: [ :tab | tab activate.
		tab disabled: false.
		container tabs reject: [ :aTab | (aTab tabName = aString) ]
		thenDo: [ :aTab | aTab deactivate ]
	]
]
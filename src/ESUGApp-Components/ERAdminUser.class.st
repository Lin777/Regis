Class {
	#name : #ERAdminUser,
	#superclass : #ERTabContainerPage,
	#instVars : [
		'messageComponent'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERAdminUser >> acceptUser [
	
]

{ #category : #initialization }
ERAdminUser >> initialize [
	super initialize.
	messageComponent := (ERComponentAlert warningAlert id: 'adminUserAlert').
]

{ #category : #rendering }
ERAdminUser >> renderButtons: html [
	html render: (self createButtonField: 'Accept' with: [ self acceptUser ] id: 'accept-user') forAcceptButton .
	
	html render: (self createButtonField: 'Cancel' with: [ self cancel ] id: 'cancel-user') forAcceptButton .
]

{ #category : #rendering }
ERAdminUser >> renderContainer: html [
	html horizontalRule .
	self renderFormOn: html
	
]

{ #category : #rendering }
ERAdminUser >> renderFields: html [
	html render: (self createTextField: 'First Name: ' for: #firstName withValue: attendee firstName).
	html render: (self createTextField: 'Last Name: ' for: #lastName withValue: attendee lastName).
	html render: (self createTextField: 'Email: ' for: #email withValue: attendee email).
]

{ #category : #rendering }
ERAdminUser >> renderFormOn: html [
	html form
		method: 'post';
		id: 'groupManagerFunctions';
		with: [ html render: messageComponent .
			self renderFields: html.
			self renderButtons: html ]
]

{ #category : #accessing }
ERAdminUser >> tabId [
	^ 'id'
]

{ #category : #accessing }
ERAdminUser >> tabName [
	^ 'User'
]

{ #category : #accessing }
ERAdminUser >> title [
	^ 'User'
]

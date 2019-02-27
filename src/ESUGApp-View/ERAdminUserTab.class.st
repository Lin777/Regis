Class {
	#name : #ERAdminUserTab,
	#superclass : #ERContentAdminTab,
	#instVars : [
		'modifiedUser'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #'as yet unclassified' }
ERAdminUserTab class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form initializeController.
	
	^ form
]

{ #category : #rendering }
ERAdminUserTab >> acceptUser [
	[ controller updateUser: (modifiedUser save) model ]
		on: ERException
		do: [ :exception | 
			messageComponent errorMessage: exception messageText ].
	self updateStateTab: self tabName
]

{ #category : #rendering }
ERAdminUserTab >> cancel [
	"attendee abortChanges."
	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERAdminUserTab >> children [ 
	^ Array with: messageComponent with: modifiedUser
]

{ #category : #initialization }
ERAdminUserTab >> initialize [
	super initialize.
	messageComponent id: 'adminUserAlert'
]

{ #category : #rendering }
ERAdminUserTab >> initializeModifyUser [
	modifiedUser := attendee asComponent 
	addDecoration: MAValidationDecoration new;
	 yourself
]

{ #category : #rendering }
ERAdminUserTab >> renderAcceptButtonOn: html [
	html mdlButton
		colored;
		id: 'accept-user';
		callback: [ self acceptUser ];
		with: 'Accept'
]

{ #category : #rendering }
ERAdminUserTab >> renderButtonsOn: html [
	self renderAcceptButtonOn: html.
	self renderCancelButtonOn: html.
]

{ #category : #rendering }
ERAdminUserTab >> renderCancelButtonOn: html [
	html mdlButton
		colored;
		id: 'cancel-user';
		callback: [ self cancel ];
		with: 'Cancel'.
]

{ #category : #rendering }
ERAdminUserTab >> renderContainerOn: html [
	html horizontalRule .
	self renderFormOn: html
	
]

{ #category : #rendering }
ERAdminUserTab >> renderFormOn: html [
	self initializeModifyUser.
	html form
		method: 'post';
		id: 'groupManagerFunctionsUser';
		with: [ html render: messageComponent.
			html render: modifiedUser.
			self renderButtonsOn: html ]
]

{ #category : #accessing }
ERAdminUserTab >> tabId [
	^ 'adminUser'
]

{ #category : #accessing }
ERAdminUserTab >> tabName [
	^ 'User'
]

{ #category : #accessing }
ERAdminUserTab >> title [
	^ 'User'
]

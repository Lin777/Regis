Class {
	#name : #ERGroupRegistrationTab,
	#superclass : #ERContainerTab,
	#instVars : [
		'newAttendee',
		'group'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #'as yet unclassified' }
ERGroupRegistrationTab class >> on: anAttendee withContent: aContent container: aContainer [
	| form |
	form := self on: anAttendee withContent: aContent.
	form initializeController.
	form initializeFormRegister.
	form container: aContainer.
	^ form
]

{ #category : #rendering }
ERGroupRegistrationTab >> attendeeFrom: aGroupManager [
	^ ERAttendee new 
		userAccount: aGroupManager userAccount; 
		affiliationInformation: aGroupManager affiliationInformation 
]

{ #category : #accessing }
ERGroupRegistrationTab >> attends [
	^ (controller conference groupOfUser: attendee)
		listAttends
]

{ #category : #actions }
ERGroupRegistrationTab >> cancel [
	self returnToThePreviousState
]

{ #category : #accessing }
ERGroupRegistrationTab >> group [
	group ifNil: [ group := controller conference groupOfUser: attendee ].
	^ group
		
]

{ #category : #accessing }
ERGroupRegistrationTab >> groupManager [ 
	^ self group groupManager 
		
]

{ #category : #initialization }
ERGroupRegistrationTab >> initializeController [
	controller := ERGroupManagerController new.
	controller group: (controller conference groupOfUser: attendee)
]

{ #category : #rendering }
ERGroupRegistrationTab >> initializeFormRegister [
	self newAttendee.
	formRegister := ERContainerTabs
		formRegisterOn: newAttendee
		withCallback: callback
		content: content
]

{ #category : #accessing }
ERGroupRegistrationTab >> listAttendees [ 
	^ self group listAttends  
		
]

{ #category : #rendering }
ERGroupRegistrationTab >> newAttendee [
	newAttendee := ERAttendee new
		affiliationInformation: self groupManager affiliationInformation.
	newAttendee paymentInformation paymentType: group paymentInformation paymentType .
	newAttendee paymentInformation paymentCurrency: group paymentInformation paymentCurrency. 
	newAttendee
		paymentInformation: (newAttendee paymentInformation readOnly: true).
	newAttendee
		affiliationInformation: (newAttendee affiliationInformation readOnly: true)
]

{ #category : #accessing }
ERGroupRegistrationTab >> paymentInformation [ 
	^ self group paymentInformation   
		
]

{ #category : #rendering }
ERGroupRegistrationTab >> registerAttendee [
	callback := [ :att | self registerAttendeeToGroupManager: att ].
	self initializeFormRegister.
	content state: formRegister.
	self updateStateTab: self tabName
]

{ #category : #rendering }
ERGroupRegistrationTab >> registerAttendeeToGroupManager: anAttendee [
	controller addAttendee: newAttendee.
	content state: content lastState.
	self updateStateTab: self tabName
]

{ #category : #rendering }
ERGroupRegistrationTab >> registerMyselfAsAttendee [
	callback := [ :att | controller addGroupManagerAsAttendee: att.
								content state: content lastState ].
	self initializeFormWithoutBasicInformationFor:
	 (self attendeeFrom: self groupManager).
	self updateStateTab: self tabName
]

{ #category : #rendering }
ERGroupRegistrationTab >> returnToThePreviousState [
	content state: content lastState.
	self updateStateTab: self tabName.
]

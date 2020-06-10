"
I am the principal view of group registration
"
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

{ #category : #adding }
ERGroupRegistrationTab >> addNewAttendeeToRegister [
	"Add new attendee to register in group registration"
	| index |
	
	index := controller newAttendees size + 1.
	controller
		addNewAttendeeToRegister: (self newGroupAttendeeRowWithIndex: index).
]

{ #category : #rendering }
ERGroupRegistrationTab >> attendeeFrom: aGroup [
	"Return an attendee of a group"

	^ ERAttendee new 
		userAccount: aGroup userAccount; 
		affiliationInformation: aGroup affiliationInformation copy;
		contactInformation: aGroup contactInformation copy
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

{ #category : #initialization }
ERGroupRegistrationTab >> initializeController [
	controller := ERGroupController new.
	controller group: (controller conference groupOfUser: attendee)
]

{ #category : #rendering }
ERGroupRegistrationTab >> initializeFormRegister [
	self newAttendee.
	formRegister := ERContainerTabs
		formRegisterOn: newAttendee
		withCallback: callback
		content: content
		conference: controller conference.
]

{ #category : #rendering }
ERGroupRegistrationTab >> initializeGroupInformationForm: aGroup [

	callback := [ self updateGroupInformation: aGroup ].
	self initializeGroupInformationFormFor: aGroup.
	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERGroupRegistrationTab >> initializeGroupMemberFormRegister [
	self newGroupAttendee.
	formRegister := ERContainerTabs
		formGroupMemberRegisterOn: newAttendee
		withCallback: callback
		content: content
		conference: controller conference.
]

{ #category : #accessing }
ERGroupRegistrationTab >> listAttendees [ 
	^ self group listAttends  
		
]

{ #category : #rendering }
ERGroupRegistrationTab >> newAttendee [
	newAttendee := ERAttendee new
		affiliationInformation: self group affiliationInformation copy;
		contactInformation: self group contactInformation copy.
	newAttendee paymentInformation paymentType: group paymentInformation paymentType.
	newAttendee paymentInformation paymentCurrency: group paymentInformation paymentCurrency.
	newAttendee
		contactInformation: (newAttendee contactInformation readOnly: true).
	newAttendee
		paymentInformation: (newAttendee paymentInformation readOnly: true).
	newAttendee
		affiliationInformation: (newAttendee affiliationInformation readOnly: true)
]

{ #category : #rendering }
ERGroupRegistrationTab >> newGroupAttendee [
	newAttendee := ERAttendee new
		affiliationInformation: self group affiliationInformation copy;
		contactInformation: self group contactInformation copy.
	newAttendee paymentInformation paymentType: self group paymentInformation paymentType.
	newAttendee paymentInformation paymentCurrency: self group paymentInformation paymentCurrency.
	newAttendee
		contactInformation: (newAttendee contactInformation readOnly: true).
	newAttendee
		paymentInformation: (newAttendee paymentInformation readOnly: true).
	newAttendee
		affiliationInformation: (newAttendee affiliationInformation readOnly: true)
]

{ #category : #rendering }
ERGroupRegistrationTab >> newGroupAttendeeRowWithIndex: anIndex [
	| newAttendeeRow |
	newAttendeeRow := ERAttendee new
		affiliationInformation: self group affiliationInformation copy;
		contactInformation: self group contactInformation copy;
		classId: anIndex.
	newAttendeeRow paymentInformation paymentType: self group paymentInformation paymentType.
	newAttendeeRow paymentInformation paymentCurrency: self group paymentInformation paymentCurrency.
	newAttendeeRow
		contactInformation: (newAttendeeRow contactInformation readOnly: true).
	newAttendeeRow
		paymentInformation: (newAttendeeRow paymentInformation readOnly: true).
	newAttendeeRow
		affiliationInformation: (newAttendeeRow affiliationInformation readOnly: true).
	^ newAttendeeRow
]

{ #category : #'instance creation' }
ERGroupRegistrationTab >> newRegisterAttendees [

	^ controller newAttendees
]

{ #category : #accessing }
ERGroupRegistrationTab >> paymentInformation [ 
	^ self group paymentInformation   
		
]

{ #category : #rendering }
ERGroupRegistrationTab >> registerAttendee [
	callback := [ :att | self registerAttendeeToGroupManager: att ].
	self initializeGroupMemberFormRegister.
	content state: formRegister.
	self updateStateTab: self tabName
]

{ #category : #adding }
ERGroupRegistrationTab >> registerAttendeeToGroup: anAttendee withIndex: anIndex [
	
	controller addAttendee: anAttendee.
	self removeNewAttendeeToRegisterWithIndex: anIndex
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
	self initializeFormToGroupManagerFor: (self attendeeFrom: self group).
	self updateStateTab: self tabName
]

{ #category : #removing }
ERGroupRegistrationTab >> removeNewAttendeeToRegisterWithIndex: anIndex [

	controller removeGroupMemberToRegisterWithIndex: anIndex
]

{ #category : #rendering }
ERGroupRegistrationTab >> renderContainerOn: html [
	self subclassResponsibility
]

{ #category : #rendering }
ERGroupRegistrationTab >> returnToThePreviousState [
	content state: content lastState.
	self updateStateTab: self tabName.
]

{ #category : #removing }
ERGroupRegistrationTab >> saveNewAttendee: anAttendee [

	controller addNewAttendee: anAttendee
]

{ #category : #accessing }
ERGroupRegistrationTab >> title [
	self subclassResponsibility
]

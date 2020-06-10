"
I am the view to register members in group
"
Class {
	#name : #ERMembersRegistrationView,
	#superclass : #ERGroupRegistrationTab,
	#category : #'ESUGApp-View-View'
}

{ #category : #'instance creation' }
ERMembersRegistrationView >> newUserAttendees [

	^ controller newAttendees
]

{ #category : #rendering }
ERMembersRegistrationView >> register: att onIndex: anIndex [
	^ [ self registerAttendeeToGroup: att withIndex: anIndex ]
		on: ERException
		do: [ :exception | 
			messageComponent errorMessage: exception messageText.
			self updateStateTab: tabName ]
]

{ #category : #rendering }
ERMembersRegistrationView >> renderContainerOn: html [
	
	html render: messageComponent.
	self renderRegistrationSectionOn: html.
	self renderOptionRegisterBarOn: html
]

{ #category : #rendering }
ERMembersRegistrationView >> renderHeaderOn: html withIndex: index [
	"Render header of a user registration"

	html div
		class: 'register-member-option';
		with: [ html span
				class: 'option-text';
				with: 'New user ' , index printString ]
]

{ #category : #rendering }
ERMembersRegistrationView >> renderOptionRegisterBarOn: html [
	"render register member registration bar"

	html form
		class: 'register-member-bar';
		with: [ 
		html mdlTable
				with: [
				html tableHead: [ html mdlAnchorButton 
						raised;
						rippleEffect;
						id: 'newUserOptionBar';
						disabled: (self group isAbleToPay ifTrue: 'disabled');
						callback: [ self addNewAttendeeToRegister ];
						with: 'Register new group user' ] ] ]
]

{ #category : #rendering }
ERMembersRegistrationView >> renderRegisterTabsOn: html withUser: anUser andIndex: anIndex [
	| form |
	form := ERAccordionContainerTabs
		formGroupMemberRegisterOn: anUser
		withClassId: anIndex
		cancelCallback: [ self removeNewAttendeeToRegisterWithIndex: anIndex ]
		saveCallback: [ :att | self register: att onIndex: anIndex ].
	html render: form
]

{ #category : #rendering }
ERMembersRegistrationView >> renderRegistrationSectionOn: html [
	html div
		script: html jQuery new accordion;
		with: [
			self newUserAttendees
				doWithIndex: [ :newUser :index |
							self renderHeaderOn: html withIndex: index.
							self renderRegisterTabsOn: html withUser: newUser andIndex: index ] ]
]

{ #category : #accessing }
ERMembersRegistrationView >> title [
	
	^ ''
]

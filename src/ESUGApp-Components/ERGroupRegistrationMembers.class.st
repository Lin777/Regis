Class {
	#name : #ERGroupRegistrationMembers,
	#superclass : #ERGroupRegistration,
	#instVars : [
		'mofidyUserForm',
		'formWithoutBasicInfo'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #accessing }
ERGroupRegistrationMembers >> attends [
	^ (ERGroupManagerViewController new
		groupOfAttendee: attendee userAccount) listAttends
]

{ #category : #accessing }
ERGroupRegistrationMembers >> deleteAttendeeFromGroup: anAttendee [
	controller deleteAttendeeFromGroup: anAttendee 
]

{ #category : #'as yet unclassified' }
ERGroupRegistrationMembers >> formWithoutBasicInformationFor: anAttendee [
	^ OrderedCollection new
		add:
			(ERTabForAForm form: (ERContactInformation on: anAttendee))
				activate;
		add: (ERTabForAForm form: (ERConferenceOptions on: anAttendee));
		add:
			(ERTabForAForm form: (ERAffiliationInformation on: anAttendee));
		add:
			(ERTabForAForm form: (ERAdditionalInformation on: anAttendee));
		add: (ERTabForAForm form: (ERPaymentInformation on: anAttendee));
		add: (ERDoneForm on: anAttendee callback: [ nil ]);
			yourself
]

{ #category : #accessing }
ERGroupRegistrationMembers >> headers [
	^ #('Name(D)' 'Email' 'Fee' 'Has Paid?' '')
]

{ #category : #initialization }
ERGroupRegistrationMembers >> initializeModifyUserForm [
	mofidyUserForm := ERContainerModifyUserView
		on: attendee
		withContent: content.
	
	content state: mofidyUserForm
]

{ #category : #accessing }
ERGroupRegistrationMembers >> modifyRegistrationInformation: anAttendee [
	formWithoutBasicInfo := (ERContainerTabsView content: content)
		tabView:
			(ERTabsView
				tabs: (self formWithoutBasicInformationFor: anAttendee)).
	
	content state: formWithoutBasicInfo
]

{ #category : #accessing }
ERGroupRegistrationMembers >> modifyUserFormGroup: anAttendee [
	mofidyUserForm := ERContainerModifyUserView
		on: anAttendee
		withContent: content.
	content state: mofidyUserForm
]

{ #category : #accessing }
ERGroupRegistrationMembers >> registerMyselfAsAttendee [
	formWithoutBasicInfo := (ERContainerTabsView content: content)
		tabView:
			(ERTabsView
				tabs: (self formWithoutBasicInformationFor: attendee)).
	content state: formWithoutBasicInfo
]

{ #category : #accessing }
ERGroupRegistrationMembers >> renderAnAttendee: anAttendee at: html [
	html mdlTableHeading: anAttendee firstName.
	html mdlTableHeading: anAttendee userAccount email.
	html mdlTableHeading: '660.00 Euros'.
	html mdlTableHeading: 'No'.
	html
		mdlTableHeading: [ self renderButtonsOfAnAttendee: anAttendee at: html ]
]

{ #category : #accessing }
ERGroupRegistrationMembers >> renderBody: html [
	html
		tableBody: [ self attends
				do: [ :anAttendee | html tableRow: [ self renderAnAttendee: anAttendee at: html ] ]]
]

{ #category : #accessing }
ERGroupRegistrationMembers >> renderButtons: html [
	self renderRegisterAttendee: html.
	self renderRegisterMyselfAsAttendee: html
]

{ #category : #accessing }
ERGroupRegistrationMembers >> renderButtonsOfAnAttendee: anAttendee at: html [
	self
		createColoredButton: 'Modify'
		with: [ self modifyRegistrationInformation: anAttendee ]
		id: anAttendee id , '-modify'
		on: html.
	self
		createColoredButton: 'Delete'
		with: [ self deleteAttendeeFromGroup: anAttendee ]
		id: anAttendee id , '-delete'
		on: html.
	self
		createColoredButton: 'Modify User'
		with: [ self modifyUserFormGroup: anAttendee ]
		id: anAttendee id , '-modifyUser'
		on: html.
	self
		createColoredButton: 'Reset Password'
		with: [ nil ]
		id: anAttendee id , '-resetPassword'
		on: html.
	self
		createColoredButton: 'Apply Reduction'
		with: [ nil ]
		id: anAttendee id , '-applyReduction'
		on: html.
	self
		createColoredButton: 'Invoice'
		with: [ nil ]
		id: anAttendee id , '-invoice'
		on: html.
]

{ #category : #accessing }
ERGroupRegistrationMembers >> renderContainer: html [
	html form
		method: 'post';
		id: 'formMembers';
		with: [
	self renderButtons: html.
	html horizontalRule.
	self renderTableOfAttends: html]
]

{ #category : #accessing }
ERGroupRegistrationMembers >> renderHeaders: html [
	html
		tableHead: [ html
				tableRow: [ self headers do: [ :each | html mdlTableHeading: each ] ] ]
]

{ #category : #accessing }
ERGroupRegistrationMembers >> renderRegisterAttendee: html [
	self
		createColoredAnchorButton: 'Register Attendee'
		with: [ self registerAttendee ]
		id: 'registerAttendee'
		on: html
]

{ #category : #accessing }
ERGroupRegistrationMembers >> renderRegisterMyselfAsAttendee: html [
	self
		createColoredAnchorButton: 'Register Myself as Attendee'
		with: [ self registerMyselfAsAttendee ]
		id: 'registerMyselfAsAttendee'
		on: html
]

{ #category : #accessing }
ERGroupRegistrationMembers >> renderTableOfAttends: html [
	html div
		style: 'overflow-x:auto;';
		with: [ html mdlTable
				class: 'mdl-shadow--2dp';
				style: 'width:100%;';
				with: [ self renderHeaders: html.
						  self renderBody: html] ]
]

{ #category : #accessing }
ERGroupRegistrationMembers >> tabId [
	^ 'members'
]

{ #category : #accessing }
ERGroupRegistrationMembers >> tabName [
	^ 'Members'
]

{ #category : #rendering }
ERGroupRegistrationMembers >> title [
	^ 'Attends'
]

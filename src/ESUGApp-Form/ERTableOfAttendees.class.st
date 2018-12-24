Class {
	#name : #ERTableOfAttendees,
	#superclass : #ERTable,
	#instVars : [
		'callback',
		'formWithoutBasicInfo'
	],
	#category : #'ESUGApp-Form'
}

{ #category : #rendering }
ERTableOfAttendees >> deleteAttendeeFromGroup: anAttendee [
	"controller deleteAttendeeFromGroup: anAttendee"
]

{ #category : #rendering }
ERTableOfAttendees >> headers [
	^ #('Name(D)' 'Email' 'Fee' 'Has Paid?' '')
]

{ #category : #rendering }
ERTableOfAttendees >> modifyRegistrationInformation: anAttendee [
	callback := [ self updateRegistrationInformation: anAttendee ].
	formWithoutBasicInfo := (ERContainerTabsView content: content)
		tabView:
			(ERTabsView tabs: (self formWithoutBasicInformationFor: anAttendee)).
	content state: formWithoutBasicInfo
]

{ #category : #rendering }
ERTableOfAttendees >> renderAnItem: anItem at: html [
	html mdlTableHeading: anItem firstName.
	html mdlTableHeading: anItem userAccount email.
	html mdlTableHeading: '660.00 Euros'.
	html mdlTableHeading: 'No'.
	html
		mdlTableHeading: [ self renderButtonsOfAnAttendee: anItem at: html ]
]

{ #category : #rendering }
ERTableOfAttendees >> renderButtonsOfAnAttendee: anAttendee at: html [
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
		on: html
]

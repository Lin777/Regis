Class {
	#name : #ERGroupRegistrationMembers,
	#superclass : #ERTabContainerPage,
	#category : #'ESUGApp-Components'
}

{ #category : #accessing }
ERGroupRegistrationMembers >> attends [
	^ (ERGroupManagerViewController new
		groupOfAttendee: attendee userAccount) listAttends
]

{ #category : #accessing }
ERGroupRegistrationMembers >> headers [
	^ #('Name(D)' 'Email' 'Fee' 'Has Paid?' '')
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
	html html: '<button class="mdl-button mdl-js-button mdl-button--colored">
                    Register Attendee
                  </button>
                  <button class="mdl-button mdl-js-button mdl-button--colored">
                    Register Myself as Attendee
                  </button>'
]

{ #category : #accessing }
ERGroupRegistrationMembers >> renderButtonsOfAnAttendee: anAttendee at: html [
	html render: ((self createButtonField: 'Modify' with: [  ] id: (anAttendee id,'-modify') ) forTableButton).
	html render: ((self createButtonField: 'Delete' with: [  ] id: (anAttendee id,'-delete') ) forTableButton).
	html render: ((self createButtonField: 'Delete' with: [  ] id: (anAttendee id,'-delete') ) forTableButton).
	html render: ((self createButtonField: 'Modify User' with: [  ] id: (anAttendee id,'-modifyUser') ) forTableButton).
	html render: ((self createButtonField: 'Reset Password' with: [  ] id: (anAttendee id,'-resetPassword') ) forTableButton).
	html render: ((self createButtonField: 'Apply Reduction' with: [  ] id: (anAttendee id,'-applyReduction') ) forTableButton).
	html render: ((self createButtonField: 'Invoice' with: [  ] id: (anAttendee id,'-invoice') ) forTableButton).
]

{ #category : #accessing }
ERGroupRegistrationMembers >> renderContainer: html [
	self renderButtons: html.
	html horizontalRule .
	self renderTableOfAttends: html.
	
]

{ #category : #accessing }
ERGroupRegistrationMembers >> renderHeaders: html [
	html
		tableHead: [ html
				tableRow: [ self headers do: [ :each | html mdlTableHeading: each ] ] ]
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

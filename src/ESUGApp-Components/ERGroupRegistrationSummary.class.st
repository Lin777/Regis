Class {
	#name : #ERGroupRegistrationSummary,
	#superclass : #ERTabContainerPage,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERGroupRegistrationSummary >> generateInvoice [
	Transcript show: 'invoice...'
]

{ #category : #'as yet unclassified' }
ERGroupRegistrationSummary >> getRegisterAttendee [
	| tabs |
	tabs := ERAttendeeRegistrationView new tabs.
	tabs do: [ :each | each attendee: attendee  ]
]

{ #category : #rendering }
ERGroupRegistrationSummary >> modifyAffiliation [
	content := self
]

{ #category : #rendering }
ERGroupRegistrationSummary >> pay [
	Transcript show: 'pay.....'
]

{ #category : #rendering }
ERGroupRegistrationSummary >> registerAttendee [
	content
		state: (ERContainerTabsView new tabView: (ERTabsView tabs: ERAttendeeRegistrationView new tabs))
]

{ #category : #rendering }
ERGroupRegistrationSummary >> renderButtons: html [
	self renderModifyAffiliationButtonOn: html.
	self renderRegisterAttendeeButtonOn: html.
	self renderPayButtonOn: html.
	self renderGenerateInvoiceButtonOn: html.
]

{ #category : #rendering }
ERGroupRegistrationSummary >> renderContainer: html [
	html horizontalRule.
	self renderOrganizationName: html.
	self renderPaymentStatus: html.
	self renderFormButtons: html.
]

{ #category : #rendering }
ERGroupRegistrationSummary >> renderFormButtons: html [
html form
		method: 'post';
		id: 'groupManagerFunctions';
		with: [ self renderButtons: html]
]

{ #category : #rendering }
ERGroupRegistrationSummary >> renderGenerateInvoiceButtonOn: html [
		html
		render:
			(self
				createButtonField: 'GENERATE INVOICE'
				with: [ self generateInvoice ]
				id: 'generateInvoice') forContentButtonColored
]

{ #category : #rendering }
ERGroupRegistrationSummary >> renderModifyAffiliationButtonOn: html [
	html
		render:
			(self
				createButtonField: 'Modify Affiliation'
				with: [ self modifyAffiliation ]
				id: 'modifyAffiliation') forContentButton.
]

{ #category : #rendering }
ERGroupRegistrationSummary >> renderOrganizationName: html [
	html render: (self createTextStrong: 'Organization Name: ' text: attendee orgName)
]

{ #category : #rendering }
ERGroupRegistrationSummary >> renderPayButtonOn: html [
	html
		render:
			(self createButtonField: 'Pay' with: [ self pay ] id: 'pay')
				forContentButton.

]

{ #category : #rendering }
ERGroupRegistrationSummary >> renderPaymentStatus: html [
	html render: (self createTextStrong: 'Payment Status: ' text: 'No status avaliable. The group has no mmebers ').
]

{ #category : #rendering }
ERGroupRegistrationSummary >> renderRegisterAttendeeButtonOn: html. [
	html
		render:
			(self
				createButtonField: 'Register Attendee'
				with: [ self registerAttendee ]
				id: 'registerAttendee') forContentButton.

]

{ #category : #accessing }
ERGroupRegistrationSummary >> tabId [
	^ 'summary'
]

{ #category : #accessing }
ERGroupRegistrationSummary >> tabName [
	^ 'Summary'
]

{ #category : #accessing }
ERGroupRegistrationSummary >> title [
	^ 'Group Manager Short Description'
]

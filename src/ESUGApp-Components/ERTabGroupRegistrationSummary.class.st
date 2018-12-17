Class {
	#name : #ERTabGroupRegistrationSummary,
	#superclass : #ERTabContainerPage,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERTabGroupRegistrationSummary >> generateInvoice [
	Transcript show: 'invoice...'
]

{ #category : #rendering }
ERTabGroupRegistrationSummary >> modifyAffiliation [
	Transcript show: 'modify /......'
]

{ #category : #rendering }
ERTabGroupRegistrationSummary >> pay [
	Transcript show: 'pay.....'
]

{ #category : #rendering }
ERTabGroupRegistrationSummary >> registerAttendee [
	Transcript show: 'register attendee....'
]

{ #category : #rendering }
ERTabGroupRegistrationSummary >> renderButtons: html [
	html render: ( self createButtonField: 'Modify Affiliation' with: [ self modifyAffiliation ] id: 'modifyAffiliation') forContentButton.
	html render: (self createButtonField: 'Register Attendee' with: [ self registerAttendee ] id: 'registerAttendee') forContentButton.
	html render: (self createButtonField: 'Pay' with: [ self pay ] id: 'pay') forContentButton.
	html render: (self createButtonField:'GENERATE INVOICE'  with: [ self generateInvoice ]  id: 'generateInvoice') forContentButtonColored
]

{ #category : #rendering }
ERTabGroupRegistrationSummary >> renderContainer: html [
	html horizontalRule.
	self renderOrganizationName: html.
	self renderPaymentStatus: html.
	self renderFormButtons: html.
]

{ #category : #rendering }
ERTabGroupRegistrationSummary >> renderFormButtons: html [
html form
		method: 'post';
		id: 'groupManagerFunctions';
		with: [ self renderButtons: html]
]

{ #category : #rendering }
ERTabGroupRegistrationSummary >> renderOrganizationName: html [
	html render: (self createTextStrong: 'Organization Name: ' text: attendee orgName)
]

{ #category : #rendering }
ERTabGroupRegistrationSummary >> renderPaymentStatus: html [
	html render: (self createTextStrong: 'Payment Status: ' text: 'No status avaliable. The group has no mmebers ').
]

{ #category : #accessing }
ERTabGroupRegistrationSummary >> tabId [
	^ 'members'
]

{ #category : #accessing }
ERTabGroupRegistrationSummary >> tabName [
	^ 'Members'
]

{ #category : #accessing }
ERTabGroupRegistrationSummary >> title [
	^ 'Group Manager Short Description'
]

Class {
	#name : #ERContainerModifyAffiliationView,
	#superclass : #ERContainerView,
	#instVars : [
		'attendeModified',
		'form'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERContainerModifyAffiliationView class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	form attendeModified: anAttendee copy.
	form initializeForm.
	^ form
]

{ #category : #accessing }
ERContainerModifyAffiliationView >> attendeModified: anObject [
	attendeModified := anObject
]

{ #category : #rendering }
ERContainerModifyAffiliationView >> cancel [
	
]

{ #category : #initialization }
ERContainerModifyAffiliationView >> initializeForm [
	form := ERAffiliationInformationForm on: attendeModified
]

{ #category : #'as yet unclassified' }
ERContainerModifyAffiliationView >> intitialize [
	super initialize.
]

{ #category : #rendering }
ERContainerModifyAffiliationView >> renderAcceptButtonOn: html [
	html mdlButton
		colored;
		id: 'accept-change-affiliation';
		callback: [ self updateAffiliationInformation ];
		with: 'Accept'
]

{ #category : #rendering }
ERContainerModifyAffiliationView >> renderCancelButtonOn: html [
	html mdlButton
		colored;
		id: 'cancel-change-affiliation';
		callback: [ self cancel ];
		with: 'Cancel'
]

{ #category : #rendering }
ERContainerModifyAffiliationView >> renderContentPage: html [
	html heading
		level3;
		with: 'Affiliation Information'.
	html horizontalRule.
	self renderFormOn: html.
	self renderAcceptButtonOn: html.
	self renderCancelButtonOn: html.
]

{ #category : #rendering }
ERContainerModifyAffiliationView >> renderFormOn: html [
	html render: (ERAffiliationInformation on: attendee)
]

{ #category : #rendering }
ERContainerModifyAffiliationView >> updateAffiliationInformation [
]

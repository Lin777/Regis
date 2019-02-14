Class {
	#name : #ERComponentFactory,
	#superclass : #WAComponent,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #'instance creation' }
ERComponentFactory class >> on: anAttendee [
	| form |
	form := self new.
	form attendee: anAttendee.
	^ form
]

{ #category : #accessing }
ERComponentFactory >> attendee [
	^ attendee
]

{ #category : #accessing }
ERComponentFactory >> attendee: anObject [
	attendee := anObject
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createAdditionalInfoTab: anAttendee withContent: aContent [
	
	^ ERContentTab new 
	 contentTab: (self createAdditionalInformationComponent: anAttendee);
			 tabId: 'additionalInfoForm'; 
			 tabName: 'Additional';
			 container: aContent
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createAdditionalInformationComponent: anAttendee [
	
	^ anAttendee additionalInformation asComponent
	addDecoration: MAValidationDecoration new;
	 yourself
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createAffiliationInfoTab: anAttendee withContent: aContent [
	^ ERContentTab new 
		contentTab: (self createAffiliationInformationComponentOn: anAttendee);
			 tabId: 'affiliationInfoForm'; 
			 tabName: 'Affiliation';
			 container: aContent
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createAffiliationInformationComponentOn: anAttendee [
	^ anAttendee affiliationInformation asComponent 
	addDecoration: MAValidationDecoration new;
	 yourself
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createBasicInfoTab: anAttendee withContent: aContent [
	^ ERContentTab new 
		contentTab: (self createBasicInformationComponent: anAttendee);
			 tabId: 'basicInfoForm'; 
			 tabName: 'User';
			 container: aContent
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createBasicInformationComponent: anAttendee [
	^ ((anAttendee userAccount) 
	as: ERUserAccountForRegister) asComponent 
	addDecoration: MAValidationDecoration new;
	 yourself
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createContactInfoTab: anAttendee withContent: aContent [
	^ ERContentTab new 
		contentTab: (self createContactInformationComponent: anAttendee);
			 tabId: 'contactInfoForm'; 
			 tabName: 'Contact';
			 container: aContent
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createContactInformationComponent: anAttendee [
	^ anAttendee contactInformation asComponent 
	addDecoration: MAValidationDecoration new;
	 yourself
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createFormOf: anObject [
	^ anObject asComponent 
	addDecoration: MAValidationDecoration new;
	 yourself.
]

{ #category : #building }
ERComponentFactory >> createPasswordField: aName id: aId with: aBlock on: html [
	html mdlTextFieldContainer
		floatingLabel;
		with: [
			| mdlTxtInput |
			html mdlTextFieldLabel for: aId; with: aName.
			mdlTxtInput := html mdlTextFieldInput id: aId; type: 'password';
			pattern: '[A-Za-z0-9._]{8,}'.
			aBlock ifNotNil: [ aBlock cull: mdlTxtInput ].
		].
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createPaymentInfoTab: anAttendee withContent: aContent [
	^ ERContentTab new 
			contentTab: (self createPaymentInformationComponent: anAttendee );
			previousContentTab: '<br><p>Pay by transfer or pay/card. Pay in euros</p>
                    <p><strong>IMPORTANT: Bank transfer should mention "ESUG" & the registrant name(s) as comment (e.g "Esug John Johnson")</strong></p>
                    <p>Use the inter-country IBAN / BIC data (may need to ask your bank to process he payment)</p>';
			 tabId: 'paymentInformationForm'; 
			 tabName: 'Payment';
			 container: aContent
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createPaymentInformationComponent: anAttendee [
	^ anAttendee paymentInformation asComponent 
	addDecoration: MAValidationDecoration new;
	 yourself
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createRegConferenceInfoTab: anAttendee withContent: aContent [
	^ ERContentTab new 
			contentTab: (self createRegConferenceInformationComponent: anAttendee);
			 tabId: 'conferenceOptionsForm'; 
			 tabName: 'Conference';
			 container: aContent
]

{ #category : #'as yet unclassified' }
ERComponentFactory >> createRegConferenceInformationComponent: anAttendee [
	^ anAttendee conferenceInformation asComponent 
	addDecoration: MAValidationDecoration new;
	 yourself 
]

Class {
	#name : #ERAffiliationInformationTabForm,
	#superclass : #ERAttendeeRegistrationTabForm,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERAffiliationInformationTabForm >> renderFormOn: html [
	html render: (self createTextField: 'Organization Name:' for: #orgName:).
	html render: (self createTextField: 'Address1' for: #orgAddrees1: percent: 49).
	html render: (self createTextField: 'Address2' for: #orgAddrees2: percent: 49).
	html render: (self createTextField: 'City' for: #orgCity: percent:49).
	html render: (self createSelectField: 'Country' for: #orgCountry: list: ERAttendee countries percent: 49).
	html render: (self createTextField: 'Province/State' for: #orgProvince: percent: 49).
	html render: (self createTextField: 'Postal/Zipcode' for: #orgPostal: percent: 49).
	html render: (self createSelectField: 'Membership Type' for: #membershipType: list: ERAttendee membershipTypes).
]

{ #category : #accessing }
ERAffiliationInformationTabForm >> tabId [
	^ 'affiliationInfoForm'
]

{ #category : #accessing }
ERAffiliationInformationTabForm >> tabName [
	^ 'Affiliation Information'
]

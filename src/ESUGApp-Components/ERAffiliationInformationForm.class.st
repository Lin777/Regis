Class {
	#name : #ERAffiliationInformationForm,
	#superclass : #ERAttendeeRegistrationForm,
	#category : #'ESUGApp-Components'
}

{ #category : #initialization }
ERAffiliationInformationForm >> initialize [
	super initialize.
]

{ #category : #rendering }
ERAffiliationInformationForm >> renderFormOn: html [
	html
		render: (self createTextField: 'Organization Name:' for: #orgName:).
	html
		render:
			(self
				createTextField: 'Address1'
				for: #orgAddrees1:
				percent: 49).
	html
		render:
			(self
				createTextField: 'Address2'
				for: #orgAddrees2:
				percent: 49).
	html
		render: (self createTextField: 'City' for: #orgCity: percent: 49).
	html
		render:
			(self
				createSelectField: 'Country'
				for: #orgCountry:
				list: ERAttendee countries
				percent: 49).
	html
		render:
			(self
				createTextField: 'Province/State'
				for: #orgProvince:
				percent: 49).
	html
		render:
			(self
				createTextField: 'Postal/Zipcode'
				for: #orgPostal:
				percent: 49).
	html
		render:
			(self
				createSelectField: 'Membership Type'
				for: #membershipType:
				list: ERAttendee membershipTypes).
	self renderPreviousTabFromOn: html.
	self renderNextTabFromOn: html
]

{ #category : #accessing }
ERAffiliationInformationForm >> tabId [
	^ 'affiliationInfoForm'
]

{ #category : #accessing }
ERAffiliationInformationForm >> tabName [
	^ 'Affiliation'
]

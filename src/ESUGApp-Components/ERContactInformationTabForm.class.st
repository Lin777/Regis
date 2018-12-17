Class {
	#name : #ERContactInformationTabForm,
	#superclass : #ERAttendeeRegistrationTabForm,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERContactInformationTabForm >> renderFormOn: html [
	html render: (self createTextField: 'Address1' for: #address: percent: 49).
	html render: (self createTextField: 'Address2' for: #address2: percent: 49).
	html render: (self createTextField: 'City' for: #city: percent: 49).
	html render: (self createSelectField: 'Country' for: #country: list: ERAttendee countries percent: 49).
	html render: (self createTextField: 'Province/State' for: #province: percent:49) .
	html render: (self createTextField: 'Postal/Zipcode' for: #postal: percent:49).
	html render: (self createTextField: 'Facebook URL' for: #facebookURL: percent:49).
	html render: (self createTextField: 'Twitter URL' for: #twitterURL: percent:49).
	html render: (self createTextField: 'Home Page URL' for: #homePage:).
]

{ #category : #accessing }
ERContactInformationTabForm >> tabId [
	^ 'contactInfoForm'
]

{ #category : #accessing }
ERContactInformationTabForm >> tabName [
	^ 'Personal Information'
]

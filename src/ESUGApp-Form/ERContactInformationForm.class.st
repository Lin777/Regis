Class {
	#name : #ERContactInformationForm,
	#superclass : #ERForm,
	#category : #'ESUGApp-Form'
}

{ #category : #'as yet unclassified' }
ERContactInformationForm >> formId [
	^ 'contactInfoForm'
]

{ #category : #'as yet unclassified' }
ERContactInformationForm >> formName [
	^ 'Contact'
]

{ #category : #initialization }
ERContactInformationForm >> initializeForm [
	form := attendee contactInformation asComponent
]

{ #category : #rendering }
ERContactInformationForm >> renderContentOn: html [
	"self
		createTextField: 'Address1 (*):'
		for: #address:
		with: #address
		percent: 49
		on: html.
	self
		createTextField: 'Address2 (*):'
		for: #address2:
		with: #address2
		percent: 49
		on: html.
	self
		createTextField: 'City (*):'
		for: #city:
		with: #city
		percent: 49
		on: html.
	self
		createSelectField: 'Country (*):'
		for: #country:
		with: #country
		list: ERAttendee countries
		percent: 49
		on: html.
	self
		createTextField: 'Province/State (*):'
		for: #province:
		with: #province
		percent: 49
		on: html.
	self
		createTextField: 'Postal/Zipcode (*):'
		for: #postal:
		with: #postal
		percent: 49
		on: html.
	self
		createTextField: 'Facebook URL'
		for: #facebookURL:
		with: #facebookURL
		percent: 49
		on: html.
	self
		createTextField: 'Twitter URL'
		for: #twitterURL:
		with: #twitterURL
		percent: 49
		on: html.
	self
		createTextField: 'Home Page URL'
		for: #homePage:
		with: #homePage
		on: html"html render: form.
]

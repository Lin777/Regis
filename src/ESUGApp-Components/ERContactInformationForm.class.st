Class {
	#name : #ERContactInformationForm,
	#superclass : #ERAttendeeRegistrationForm,
	#category : #'ESUGApp-Components'
}

{ #category : #initialization }
ERContactInformationForm >> initialize [
	super initialize.
	nextTabFrom := 'conferenceOptionsForm'.
	previousTabFrom := 'basicInfoForm'
]

{ #category : #rendering }
ERContactInformationForm >> renderFormOn: html [
	html
		render: (self createTextField: 'Address1' for: #address: percent: 49).
	html
		render: (self createTextField: 'Address2' for: #address2: percent: 49).
	html
		render: (self createTextField: 'City' for: #city: percent: 49).
	html
		render:
			(self
				createSelectField: 'Country'
				for: #country:
				list: ERAttendee countries
				percent: 49).
	html
		render:
			(self
				createTextField: 'Province/State'
				for: #province:
				percent: 49).
	html
		render:
			(self
				createTextField: 'Postal/Zipcode'
				for: #postal:
				percent: 49).
	html
		render:
			(self
				createTextField: 'Facebook URL'
				for: #facebookURL:
				percent: 49).
	html
		render:
			(self
				createTextField: 'Twitter URL'
				for: #twitterURL:
				percent: 49).
	html
		render: (self createTextField: 'Home Page URL' for: #homePage:).
	self renderPreviousTabFromOn: html.
	self renderNextTabFromOn: html
]

{ #category : #accessing }
ERContactInformationForm >> tabId [
	^ 'contactInfoForm'
]

{ #category : #accessing }
ERContactInformationForm >> tabName [
	^ 'Contact'
]

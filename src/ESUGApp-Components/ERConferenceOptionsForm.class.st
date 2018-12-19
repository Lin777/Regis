Class {
	#name : #ERConferenceOptionsForm,
	#superclass : #ERAttendeeRegistrationForm,
	#category : #'ESUGApp-Components'
}

{ #category : #initialization }
ERConferenceOptionsForm >> initialize [
	super initialize.
]

{ #category : #rendering }
ERConferenceOptionsForm >> renderFormOn: html [
	html html: '<br> <label>Days:</label> <br>'.
	html
		render: (self createCheckboxField: 'Monday (dd/mm/aa)' for: #monday:).
	html
		render: (self createCheckboxField: 'Tuesday (dd/mm/aa)' for: #tuesday:).
	html
		render:
			(self
				createCheckboxField: 'Wednesday (dd/mm/aa)'
				for: #wednesday:).
	html
		render:
			(self
				createCheckboxField: 'Thursday (dd/mm/aa)'
				for: #thursday:).
	html
		render: (self createCheckboxField: 'Friday (dd/mm/aa)' for: #friday:).
	html html: '<br><br>'.
	html
		render:
			(self
				createSelectField: 'Gender:'
				for: #gender:
				list: ERAttendee genders).
	html
		render:
			(self
				createSelectField: 'Tshirt Size'
				for: #tshirtSize:
				list: ERAttendee tShirtSizes).
	html
		render:
			(self
				createSelectField: 'Food:'
				for: #foodPreference:
				list: ERAttendee foodPreferences).
	html
		render:
			(self
				createCheckboxField: 'Check if you will you go to the social Event'
				for: #attendSocialEvent:).
	html
		render:
			(self
				createCheckboxField: 'Check if you want to be added to the Mailling List'
				for: #addedToMainList:).
	self renderPreviousTabFromOn: html.
	self renderNextTabFromOn: html
]

{ #category : #accessing }
ERConferenceOptionsForm >> tabId [
	^ 'conferenceOptionsForm'
]

{ #category : #accessing }
ERConferenceOptionsForm >> tabName [
	^ 'Conference'
]

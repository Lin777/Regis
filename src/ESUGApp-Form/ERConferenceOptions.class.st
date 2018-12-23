Class {
	#name : #ERConferenceOptions,
	#superclass : #ERForm,
	#category : #'ESUGApp-Form'
}

{ #category : #'as yet unclassified' }
ERConferenceOptions >> formId [
	^ 'conferenceOptionsForm'
]

{ #category : #'as yet unclassified' }
ERConferenceOptions >> formName [
	^ 'Conference'
]

{ #category : #rendering }
ERConferenceOptions >> renderContentOn: html [
	html html: '<br> <label>Days:</label> <br>'.
	self
		createCheckboxField: 'Monday (dd/mm/aa)'
		for: #monday:
		on: html.
	self
		createCheckboxField: 'Tuesday (dd/mm/aa)'
		for: #tuesday:
		on: html.
	self
		createCheckboxField: 'Wednesday (dd/mm/aa)'
		for: #wednesday:
		on: html.
	self
		createCheckboxField: 'Thursday (dd/mm/aa)'
		for: #thursday:
		on: html.
	self
		createCheckboxField: 'Friday (dd/mm/aa)'
		for: #friday:
		on: html.
	html html: '<br><br>'.
	self
		createSelectField: 'Gender:'
		for: #gender:
		with: #gender
		list: ERAttendee genders
		on: html.
	self
		createSelectField: 'Tshirt Size'
		for: #tshirtSize:
		with: #tshirtSize
		list: ERAttendee tShirtSizes
		on: html.
	self
		createSelectField: 'Food:'
		for: #foodPreference:
		with: #foodPreference
		list: ERAttendee foodPreferences
		on: html.
	self
		createCheckboxField: 'Check if you will you go to the social Event'
		for: #attendSocialEvent:
		on: html.
	self
		createCheckboxField: 'Check if you want to be added to the Mailling List'
		for: #addedToMainList:
		on: html
]

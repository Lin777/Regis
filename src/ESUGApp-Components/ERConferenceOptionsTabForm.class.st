Class {
	#name : #ERConferenceOptionsTabForm,
	#superclass : #ERAttendeeRegistrationTabForm,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERConferenceOptionsTabForm >> renderFormOn: html [
	html html: '<br> <label>Days:</label> <br>'.
	html render: (self createCheckboxField: 'Monday (dd/mm/aa)' for: #monday: ).
	html render: (self createCheckboxField: 'Tuesday (dd/mm/aa)' for: #tuesday: ).
	html render: (self createCheckboxField: 'Wednesday (dd/mm/aa)' for: #wednesday: ).
	html render: (self createCheckboxField: 'Thursday (dd/mm/aa)' for: #thursday: ).
	html render: (self createCheckboxField: 'Friday (dd/mm/aa)' for: #friday: ).
	html html: '<br><br>Gender:'.
	html render:( self createRadioField: 'Gender' for: #gender: list: ERAttendee genders listValues: #(true false) ).
	html render: (self createSelectField: 'Tshirt Size' for: #tshirtSize: list: ERAttendee tShirtSizes ).
	html html: 'Food:'.
	html render: (self createRadioField: 'Food: ' for: #foodPreference: list: ERAttendee foodPreferences listValues: #(false false true) ).
	html render: (self createCheckboxField: 'Check if you will you go to the social Event' for: #attendSocialEvent:).
	html render: (self createCheckboxField: 'Check if you want to be added to the Mailling List' for: #addedToMainList:)
]

{ #category : #accessing }
ERConferenceOptionsTabForm >> tabId [
	^ 'conferenceOptionsForm'
]

{ #category : #accessing }
ERConferenceOptionsTabForm >> tabName [
	^ 'Conference Options'
]

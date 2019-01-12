Class {
	#name : #ERStatisticsTab,
	#superclass : #ERConfigurationTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERStatisticsTab >> renderAttendeesRolesStatisticsOn: html [
]

{ #category : #rendering }
ERStatisticsTab >> renderContainer: html [
	html horizontalRule.
	self renderParticipantsToLunchesStatisticsOn: html.
	self renderShirtsStatisticsOn: html.
	self renderParticipantsToSocialDinnerStatisticsOn: html
]

{ #category : #rendering }
ERStatisticsTab >> renderParticipantsToLunchesStatisticsOn: html [
	| table |
	table := ERDictionaryTable new
		headers: controller headersParticipantsToLunches;
		levelTotal: 6;
		listObject: controller participantsToLunches.
	html render: table
]

{ #category : #rendering }
ERStatisticsTab >> renderParticipantsToSocialDinnerStatisticsOn: html [
	|table|
	html heading
		level3;
		with: 'Participants To Social Dinner'.
	html horizontalRule.
	table := ERDictionaryTable new
		headers: controller headersParticipantsToSocialDinner;
		levelTotal: 6;
		listObject: controller participantsToSocialDinner.
	html render: table
]

{ #category : #rendering }
ERStatisticsTab >> renderShirtsStatisticsOn: html [
	| table |
	html heading
		level3;
		with: 'Shirts'.
	html horizontalRule.
	table := ERDictionaryTable new
		headers: controller headersShirtsStatistics;
		levelTotal: 6;
		listObject: controller shirtsStatistics.
	html render: table
]

{ #category : #accessing }
ERStatisticsTab >> tabId [
	^ 'statistics'
]

{ #category : #accessing }
ERStatisticsTab >> tabName [
	^ 'statistics'
]

{ #category : #accessing }
ERStatisticsTab >> title [
	^ 'Participants to lunches per day'
]

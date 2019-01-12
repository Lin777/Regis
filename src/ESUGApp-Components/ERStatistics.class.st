Class {
	#name : #ERStatistics,
	#superclass : #ERConfiguration,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERStatistics >> renderAttendeesRolesStatisticsOn: html [
]

{ #category : #rendering }
ERStatistics >> renderContainer: html [
	html horizontalRule.
	self renderParticipantsToLunchesStatisticsOn: html.
	self renderShirtsStatisticsOn: html.
	self renderParticipantsToSocialDinnerStatisticsOn: html
]

{ #category : #rendering }
ERStatistics >> renderParticipantsToLunchesStatisticsOn: html [
	| table |
	table := ERTableWithDictionary new
		headers: controller headersParticipantsToLunches;
		levelTotal: 6;
		listObject: controller participantsToLunches.
	html render: table
]

{ #category : #rendering }
ERStatistics >> renderParticipantsToSocialDinnerStatisticsOn: html [
	|table|
	html heading
		level3;
		with: 'Participants To Social Dinner'.
	html horizontalRule.
	table := ERTableWithDictionary new
		headers: controller headersParticipantsToSocialDinner;
		levelTotal: 6;
		listObject: controller participantsToSocialDinner.
	html render: table
]

{ #category : #rendering }
ERStatistics >> renderShirtsStatisticsOn: html [
	| table |
	html heading
		level3;
		with: 'Shirts'.
	html horizontalRule.
	table := ERTableWithDictionary new
		headers: controller headersShirtsStatistics;
		levelTotal: 6;
		listObject: controller shirtsStatistics.
	html render: table
]

{ #category : #accessing }
ERStatistics >> tabId [
	^ 'statistics'
]

{ #category : #accessing }
ERStatistics >> tabName [
	^ 'statistics'
]

{ #category : #accessing }
ERStatistics >> title [
	^ 'Participants to lunches per day'
]

Class {
	#name : #ERConferenceOrganizer,
	#superclass : #SDActiveRecord,
	#instVars : [
		'name',
		'fiscalSituation',
		'webPageUrl',
		'addressString'
	],
	#category : #'ESUGApp-Model'
}

{ #category : #accessing }
ERConferenceOrganizer >> addressString [
	^ addressString
]

{ #category : #accessing }
ERConferenceOrganizer >> addressString: anObject [
	addressString := anObject
]

{ #category : #accessing }
ERConferenceOrganizer >> fiscalSituation [
	^ fiscalSituation
]

{ #category : #accessing }
ERConferenceOrganizer >> fiscalSituation: anObject [
	fiscalSituation := anObject
]

{ #category : #accessing }
ERConferenceOrganizer >> name1 [
	^ name
]

{ #category : #accessing }
ERConferenceOrganizer >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ERConferenceOrganizer >> webPageUrl [
	^ webPageUrl
]

{ #category : #accessing }
ERConferenceOrganizer >> webPageUrl: anObject [
	webPageUrl := anObject
]

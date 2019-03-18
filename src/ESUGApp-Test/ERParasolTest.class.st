Class {
	#name : #ERParasolTest,
	#superclass : #ERTest,
	#instVars : [
		'driver'
	],
	#category : #'ESUGApp-Test-Parasol'
}

{ #category : #accessing }
ERParasolTest >> baseURL [
	^ 'http://localhost:8000/ESUG/'
]

{ #category : #accessing }
ERParasolTest >> setUp [
	super setUp.
	driver := BPRemoteWebDriver withCapabilities: BPDesiredCapabilities chrome.
	driver get: self baseURL 
]

{ #category : #accessing }
ERParasolTest >> tearDown [
	super tearDown .
	driver quit
]

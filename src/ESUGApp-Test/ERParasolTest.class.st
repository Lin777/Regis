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

{ #category : #'as yet unclassified' }
ERParasolTest >> createDownloadDirectory [
	(FileSystem workingDirectory asFileReference / 'Download')
		 ensureCreateDirectory
]

{ #category : #'as yet unclassified' }
ERParasolTest >> downloadFileOf: href to: directory [
	[ZnClient new
   url: href;
   downloadTo: directory.
	(Delay forSeconds: 2) wait]
	on: Exception 
	do: [ self assert: false ]
]

{ #category : #'as yet unclassified' }
ERParasolTest >> getTextOfError [
	^ (((((driver findElementByClassName: 'errors')findElementByTagName: 'ul')findElementByTagName: 'li')findElementByTagName: 'ul')findElementByTagName: 'li') getText
]

{ #category : #'as yet unclassified' }
ERParasolTest >> messageIsRequiredFor: aString [
	^  aString ,' (Required): Input is required but no input given'
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
	self deleteDownloadFolderIfExist.
	driver quit
]

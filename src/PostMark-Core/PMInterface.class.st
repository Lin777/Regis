"
| file email interface |

file := (FSLocator imageDirectory / 'image.jpg') resolve.
	
email := PMEmail new
	from: 'francois@wapict.be'
	to: 'francois@yopmail.com';
	subject: 'Test Application';
	textBody: 'Yeah baby';
	addAttachment: 'image.jpg' content: file readStream contents contentType: 'image/jpeg';
	attachFile: (FSLocator imageDirectory / 'pigeon.jpg');
	yourself.

interface := PMInterface new.
interface apiKey: 'blopblop'.

interface send: email.
"
Class {
	#name : #PMInterface,
	#superclass : #Object,
	#instVars : [
		'apiKey',
		'apiUrl',
		'debugStream'
	],
	#category : #'PostMark-Core'
}

{ #category : #defaults }
PMInterface class >> defaultApiKey [
	"put the API in Test mode by default."

	^ 'POSTMARK_API_TEST'
]

{ #category : #defaults }
PMInterface class >> defaultApiUrl [
	"can also use https, which you probably should"

	^ 'https://api.postmarkapp.com/'	"	^ 'http://api.postmarkapp.com/'"
]

{ #category : #example }
PMInterface class >> example [ 
	|email|
email := (PMEmail new from: 'dev@esug.org'; to: 'cusi.evelyn@gmail.com'; subject: 'ESUG Conference Invoice'; htmlBody: '<strong>Hello Evelyn</strong> This is your invoice.') toJsonString.
self new apiKey: '4ca013fd-fd02-4fd4-ac97-f401ca3af723'; ssend: email asString
]

{ #category : #accessing }
PMInterface >> apiKey [
	^ apiKey ifNil: [ apiKey := self defaultApiKey ]
]

{ #category : #accessing }
PMInterface >> apiKey: aByteString [ 
	apiKey := aByteString
]

{ #category : #accessing }
PMInterface >> apiUrl [
	^apiUrl ifNil: [ apiUrl  := self defaultApiUrl ].
]

{ #category : #private }
PMInterface >> buildZnClientForContent: aString [
	| body |
	body := ZnEntity with: aString type: ZnMimeType applicationJson.
	^ ZnClient new
		headerAt: 'X-Postmark-Server-Token' put: self apiKey;
		beOneShot;
		url: self apiUrl , '/email';
		entity: body;
		yourself 
]

{ #category : #accessing }
PMInterface >> debugStream [
	^ debugStream
]

{ #category : #accessing }
PMInterface >> debugStream: aStream [
	debugStream := aStream
]

{ #category : #'default values' }
PMInterface >> defaultApiKey [
	^ self class defaultApiKey
]

{ #category : #'default values' }
PMInterface >> defaultApiUrl [
	^ self class defaultApiUrl
]

{ #category : #testing }
PMInterface >> developmentMode [
	^debugStream isNil not.
]

{ #category : #private }
PMInterface >> handleError: aZnResponse [
	aZnResponse isAuthenticationRequired
		ifTrue: [ ^PMException signal: 'Incorrect API Key.' ] .
	aZnResponse status =  422
		ifTrue: [ ^self processIncorrectFields: aZnResponse contents].
		
	PMException signal: 'Unkown error: ' , aZnResponse status printString.
]

{ #category : #private }
PMInterface >> handleResponse: aZnResponse [
	aZnResponse isSuccess
		ifTrue: [ ^ true ].
	self handleError: aZnResponse.
	^ false
]

{ #category : #private }
PMInterface >> processIncorrectFields: aString [
	| json |
	json := NeoJSONReader fromString: aString readStream.
	PMException signal: 'Error : ' , (json at: 'ErrorCode') printString , ' - ' , (json at: 'Message').
]

{ #category : #'public API' }
PMInterface >> send: email [
	"throws PMException if something goes wrong. returns true (success)/false (failure)"
	| client |
	client := self buildZnClientForContent: email.
	client post.
	
	^ self handleResponse: client response.
]

{ #category : #private }
PMInterface >> simulateSendOf: aPMEmail [
	aPMEmail jsonWriteOn: self debugStream.
	self debugStream cr.
	self debugStream flush.
]

{ #category : #'public API' }
PMInterface >> ssend: email [
	|body client|
	body := ZnEntity with: email type: ZnMimeType applicationJson .
	client := ZnClient new 
	headerAt: 'X-Postmark-Server-Token' put: self apiKey;
	beOneShot ;
	url: self apiUrl, '/email';
	entity: body.
	client post.
	^ client response 
]

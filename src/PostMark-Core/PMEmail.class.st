"
See PMInterface comment for an overview.



I act like a Dictionary. According to PostMark documentation, I accept the following values:

{
  ""From"" : ""sender@example.com"",
  ""To"" : ""receiver@example.com,receiver2@example.com"",
  ""Cc"" : ""copied@example.com"",
  ""Bcc"": ""blank-copied@example.com"",
  ""Subject"" : ""Test"",
  ""Tag"" : ""Invitation"",
  ""HtmlBody"" : ""<b>Hello</b>"",
  ""TextBody"" : ""Hello"",
  ""ReplyTo"" : ""reply@example.com"",
  ""Headers"" : [{ ""Name"" : ""CUSTOM-HEADER"", ""Value"" : ""value"" }]
}
"
Class {
	#name : #PMEmail,
	#superclass : #Object,
	#instVars : [
		'from',
		'to',
		'subject',
		'htmlBody'
	],
	#category : #'PostMark-Core'
}

{ #category : #accessing }
PMEmail >> from [
	^ from
]

{ #category : #accessing }
PMEmail >> from: anObject [
	from := anObject
]

{ #category : #accessing }
PMEmail >> htmlBody [
	^ htmlBody
]

{ #category : #accessing }
PMEmail >> htmlBody: anObject [
	htmlBody := anObject
]

{ #category : #attachments }
PMEmail >> send [
	"want to make sure it gets sent.  This may be bad if there are lots of emails and lots of errors.  "

	| success interface |
	interface := PMInterface new.
	success := interface send: self.
	[ success ]
		whileFalse: [ 
			(Delay forMilliseconds: 5000) wait.
			success := interface send: self ]
]

{ #category : #accessing }
PMEmail >> subject [
	^ subject ifNil: [ subject := '' ]
]

{ #category : #accessing }
PMEmail >> subject: anObject [
	subject := anObject
]

{ #category : #accessing }
PMEmail >> to [
	^ to
]

{ #category : #accessing }
PMEmail >> to: anObject [
	to := anObject
]

{ #category : #'as yet unclassified' }
PMEmail >> toJsonString [
	^ NeoJSONWriter toString: 
		{ 'From' -> self from .
		 'To' -> self to . 
		'Subject' -> self subject . 
		'HtmlBody' -> self htmlBody } asDictionary.
]

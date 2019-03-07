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
	#superclass : #NeoJSONObject,
	#category : #'PostMark-Core'
}

{ #category : #attachments }
PMEmail >> addAttachment: name content: contentString contentType: aContentType [
	| attachment encodedStream |
	encodedStream := Base64MimeConverter mimeEncode: contentString readStream.
	attachment := NeoJSONObject new.
	attachment at: 'Name' put: name.
	attachment at: 'ContentType' put: aContentType asString.
	attachment at: 'Content' put: encodedStream contents.
	
	(self at: #Attachments) ifNil: [ self at: #Attachments put: OrderedCollection new ].
	(self at: #Attachments) add: attachment.
]

{ #category : #attachments }
PMEmail >> addAttachmentAndCompress: contentString archiveName: aString [
	| baseStream  gzwStream |
	baseStream := RWBinaryOrTextStream on: String new.
	gzwStream := GZipWriteStream on: baseStream.
	gzwStream nextPutAll: contentString.
	gzwStream close.
	baseStream reset.
	
	^self addAttachment: aString content:  baseStream contents contentType: 'application/x-gzip'.
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

"
Description
--------------------

A ERTestController is a test class for testing the behavior of Controller
"
Class {
	#name : #ERControllerTest,
	#superclass : #ERTest,
	#category : #'ESUGApp-Tests-UnitTest'
}

{ #category : #running }
ERControllerTest >> setUp [

	| user |
	super setUp.
	user := self registerAttendee.
	controller := ERLoggedController attendee: user
]

{ #category : #tests }
ERControllerTest >> testCleanZipFile [

	| zip nameFile zipFile subDir |
	zip := ZipArchive new.
	nameFile := 'testFiles_zip'.
	subDir := nameFile asFileReference.
	subDir ensureCreateDirectory.
	zip addDirectory: subDir.
	zipFile := nameFile asFileReference, 'zip'.
	controller cleanZip: zip with: zipFile subDir: subDir. 
	self deny: zipFile exists.
	self deny: subDir exists.
]

{ #category : #tests }
ERControllerTest >> testCompressFilesToZip [

	| nameSubDir nameZipFile subDir file1 file2 codingResult |
	nameZipFile := 'test_zip'.
	nameSubDir := 'test_subDir'.
	subDir := nameSubDir asFileReference.
	subDir ensureCreateDirectory.
	file1 := subDir / 'testFile1.txt'.
	file2 := subDir / 'testFile2.txt'.
	file1 writeStreamDo: [ :stream | stream nextPutAll: 'content of File 1' ].
	file2 writeStreamDo: [ :stream | stream nextPutAll: 'content of File 2' ].
	codingResult := controller codingZipFile: nameZipFile with: nameSubDir.
	self assert: (codingResult isString and: [codingResult isNotEmpty]).
	"After to get the Base64 coding of zipFile, the files created are cleaned"
	self deny: (nameZipFile, '.zip') asFileReference exists.
	self deny: file1 exists.
	self deny: file2 exists.
	
]

{ #category : #tests }
ERControllerTest >> testConferenceIsOpenRegistration [

	controller conference configuration openRegistration: false.
	self deny: controller conference conferenceIsOpenRegistration.

	controller conference configuration openRegistration: true.
	self assert: controller conference conferenceIsOpenRegistration. 
	

]

{ #category : #tests }
ERControllerTest >> testEncodeFileToBase64 [

	| testFile codingFile encoder output |
	testFile := 'testFile' asFileReference.
	encoder := ZnBase64Encoder new.
	testFile writeStreamDo: [ :stream | stream nextPutAll: 'content of File 1' ].
	codingFile := controller encodeFiletoBase64: testFile.
	output := encoder decode: codingFile.
	self assert: (encoder encode: output) equals: codingFile.
	testFile ensureDelete.
	
]

{ #category : #tests }
ERControllerTest >> testEncodeFileToUTF8 [

	| testFile codingFile encoder |
	testFile := 'testFile' asFileReference.
	encoder := ZnUTF8Encoder new.
	testFile writeStreamDo: [ :stream | stream nextPutAll: 'content of File 1' ].
	codingFile := controller encodeFileToUTF8: testFile.
	self assert: (codingFile asByteArray decodeWith: encoder) equals: (encoder decodeBytes: codingFile asByteArray).
	testFile ensureDelete.
	
]

{ #category : #tests }
ERControllerTest >> testExistReductionTicketWithName [

	self assert: (controller conference existReductionTicketWithName: self validCoupon ticketId).
	self deny: (controller conference existReductionTicketWithName: 'NonValidCoupon')
]

{ #category : #tests }
ERControllerTest >> testGroupOfAttendee [

	| group attendee |
	group := self registerGroup.
	attendee := group listAttends first.
	self assert: (controller conference getGroupOfAttendee: attendee) isNotNil.
	"The attendee does not belong to the group"
	attendee := controller conference attendeeFromUser: self registerAttendee.
	self assert: (controller conference getGroupOfAttendee: attendee) isNil.
]

"
Description
--------------------

A ERTestController is a test class for testing the behavior of Controller
"
Class {
	#name : #ERTestController,
	#superclass : #ERTest,
	#category : #'ESUGApp-Test-UnitTest'
}

{ #category : #initialization }
ERTestController >> setUp [
	| user |
	super setUp.
	user := self registerAttendee.
	controller := ERLoggedController attendee: user
]

{ #category : #tests }
ERTestController >> testAmountToPay [
]

{ #category : #tests }
ERTestController >> testCleanZipFile [
	| zip nameFile zipFile subDir |
	zip := ZipArchive new.
	nameFile := 'testFiles_zip'.
	subDir := nameFile asFileReference.
	subDir ensureCreateDirectory.
	zip addDirectory: subDir fullName.
	zipFile := nameFile asFileReference, 'zip'.
	controller cleanZip: zip with: zipFile subDir: subDir. 
	self deny: zipFile exists.
	self deny: subDir exists.
]

{ #category : #tests }
ERTestController >> testCompressFilesToZip [
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

{ #category : #initialization }
ERTestController >> testConferenceIsOpenRegistration [
	controller conference configuration openRegistration: true.
	self assert: controller conference conferenceIsOpenRegistration . 
	
	controller conference configuration openRegistration: false.
	self deny: controller conference conferenceIsOpenRegistration .
]

{ #category : #tests }
ERTestController >> testEncodeFileToBase64 [
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
ERTestController >> testEncodeFileToUTF8 [
	| testFile codingFile encoder |
	testFile := 'testFile' asFileReference.
	encoder := ZnUTF8Encoder new.
	testFile writeStreamDo: [ :stream | stream nextPutAll: 'content of File 1' ].
	codingFile := controller encodeFileToUTF8: testFile.
	self assert: (codingFile asByteArray decodeWith: encoder) equals: (encoder decodeBytes: codingFile asByteArray).
	testFile ensureDelete.
	
]

{ #category : #tests }
ERTestController >> testExistReductionTicketWithName [
	self assert: (controller conference existReductionTicketWithName: self validCoupon ticketId).
	self deny: (controller conference existReductionTicketWithName: 'NonValidCoupon')
]

{ #category : #tests }
ERTestController >> testGroupOfAttendee [ 
	| group attendee |
	group := self registerGroup.
	attendee := group listAttends first.
	self assert: (controller conference getGroupOfAttendee: attendee) isNotNil.
	"the attendee does not belong to the group"
	attendee := controller conference attendeeFromUser: self registerAttendee.
	self assert: (controller conference getGroupOfAttendee: attendee) isNil.
]

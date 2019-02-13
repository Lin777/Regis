Class {
	#name : #ERTestController,
	#superclass : #ERTest,
	#category : #'ESUGApp-Test'
}

{ #category : #initialization }
ERTestController >> setUp [
	super setUp.
	controller := ERController new.
	
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
	self assert: controller conferenceIsOpenRegistration . 
	
	controller conference configuration openRegistration: false.
	self deny: controller conferenceIsOpenRegistration .
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
ERTestController >> testGroupOfAttendee [ 
	| group attendee |
	self registerAttendee: (ERAttendee new userAccount: (ERUserAccount new firstName: 'Mary')).
	attendee := controller attendee.
	group := ERGroup new listAttends: (OrderedCollection new 
	add: attendee;
	add: (ERAttendee new userAccount: (ERUserAccount new firstName: 'Peter'));
	yourself);
	id: '123'.
	attendee idGroup: '123'.
	controller conference: (ERConference new groups: (OrderedCollection new 
	add: group; yourself)).
	
	self assert: (controller getGroupOfAttendee: attendee) isNotNil.
]

{ #category : #tests }
ERTestController >> testExistReductionTicketWithName [
	self assert: (controller existReductionTicketWithName: self validCoupon).
	self deny: (controller existReductionTicketWithName: 'NonValidCoupon')
]

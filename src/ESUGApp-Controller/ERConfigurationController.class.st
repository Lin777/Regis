Class {
	#name : #ERConfigurationController,
	#superclass : #ERLoggedController,
	#category : #'ESUGApp-Controller'
}

{ #category : #adding }
ERConfigurationController >> addAttendee: anAttendee [
	| anAttendeeSaved userSaved |
	
	self validateIfEmailIsAlreadyRegistered: anAttendee userAccount.
	userSaved := anAttendee userAccount save.
	conference addUser: userSaved.
	anAttendeeSaved := (anAttendee userAccount: userSaved) save.
	conference addAttendee: anAttendeeSaved.
	conference save.
	self notifyAllObservers .
	^ anAttendeeSaved
]

{ #category : #adding }
ERConfigurationController >> addReductionTicketToConference: ticketRegistered [
	conference addReductionTicket: ticketRegistered .
	conference save.
	self notifyAllObservers 
]

{ #category : #adding }
ERConfigurationController >> addTicket: aReductionTicket [
	| ticketRegistered |
	self reductionTicketAlreadyExist: aReductionTicket.
	ticketRegistered := self saveTicket: aReductionTicket .
	self addReductionTicketToConference: ticketRegistered
]

{ #category : #adding }
ERConfigurationController >> addUser: anAttendee [
	(self findUserByEmail: anAttendee email)
		ifNil: [ | userSaved |
			userSaved := anAttendee userAccount save.
			conference addUser: userSaved.
			^ userSaved ]
]

{ #category : #accessing }
ERConfigurationController >> attends [
	^ conference attends 
]

{ #category : #initialization }
ERConfigurationController >> closeRegistration [
	self conference closeRegistration.
	self notifyAllObservers
]

{ #category : #rendering }
ERConfigurationController >> convertToStudentVolunterThis: anAttendee [
	anAttendee userAccount isStudent ifFalse:[
	(anAttendee userAccount) roleAdd: 'studentVolunter'; save.
	self notifyAllObservers]
]

{ #category : #rendering }
ERConfigurationController >> deleteDependencesOfAttendee: anUser [
	|att|
	anUser isAttendee ifFalse: [ ^ self ].
	att := self attendeeFromUser: anUser.
	self deleteAttendeeFromGroupAndConference: att
]

{ #category : #rendering }
ERConfigurationController >> deleteDependencesOfGroupManager: anUser [
	anUser isGroupManager ifTrue: [ |group|
		group := self groupOfUser: anUser.
		self deleteGroup: group
		 ]
]

{ #category : #rendering }
ERConfigurationController >> deleteGroup: aGroup [
	|attendees|
	attendees := aGroup listAttends deepCopy.
	attendees do: [ :each | self deleteAttendee: (ERAttendee find: [:att | att = each]) ].
	self deleteUserForConference: aGroup groupManager userAccount.
	(self conference groups)
		removeAllSuchThat: [ :each | aGroup id = each id ].
	aGroup delete.
	self notifyAllObservers
]

{ #category : #'as yet unclassified' }
ERConfigurationController >> deleteReductionTicket: aReductionTicket [
	(self attendeesForATicket: aReductionTicket ticketId) isNotEmpty
		ifTrue: [ ERException deletionOfTicketNotValid signal ].
	conference reductionTickets
		removeAllSuchThat: [ :each | each ticketId = aReductionTicket ticketId ].
	aReductionTicket delete.
	self notifyAllObservers 
]

{ #category : #rendering }
ERConfigurationController >> deleteStudentVolunterRoleFrom: anAttendee [
	anAttendee userAccount isStudent ifTrue: [
	(anAttendee userAccount) deleteRole: 'studentVolunter'; save. 
	self notifyAllObservers]
]

{ #category : #rendering }
ERConfigurationController >> deleteUser: anUser [
	"The admin user can not be deleted"
	anUser isAdmin ifFalse: [ 
		self deleteDependencesOfAttendee: anUser.
		self deleteDependencesOfGroupManager: anUser.
		self deleteUserForConference: anUser]
	ifTrue: [ ERException adminUserDoesNotDelete signal ]
]

{ #category : #'as yet unclassified' }
ERConfigurationController >> dictionaryForLunch [
	|dic|
	dic := OrderedDictionary new.
	#(#monday #tuesday #wednesday #thursday #friday) do: [ :each |
		dic at: each put: self dictionaryOfFoodPreference ].
	^ dic
]

{ #category : #'as yet unclassified' }
ERConfigurationController >> dictionaryOfFoodPreference [
	^ Dictionary new 	
		at: 'Vegan' put: 0;
		at: 'Normal' put: 0;
		at: 'Vegetarian' put: 0;
		yourself 
]

{ #category : #'as yet unclassified' }
ERConfigurationController >> dictionaryOfShirts [
	|dict|
	dict := OrderedDictionary new.
	ERAttendee tShirtSizes do: [ :each | dict at: each put: 
		(Dictionary new at: 'Male' put: 0; 
		at: 'Female' put: 0; yourself) ].
	^ dict
]

{ #category : #rendering }
ERConfigurationController >> exportAttends: fileName [
	| cvs |
	cvs := String
		streamContents: [ :out | 
			| neoWriter |
			neoWriter := NeoCSVWriter on: out.
			neoWriter writeHeader: self headerAttendee.
			self attends 
				do: [ :each | 
					neoWriter
						nextPut:
							{ each paymentInformation invoiceNumber.
							each userAccount firstName.
							each userAccount lastName.
							each userAccount email.
							each contactInformation country.
							each affiliationInformation organizationName} ].
			neoWriter close ].
	^ cvs
]

{ #category : #rendering }
ERConfigurationController >> exportAwards: fileName [
	|  cvs |
	cvs := String
		streamContents: [ :out | 
			| neoWriter |
			neoWriter := NeoCSVWriter on: out.
			neoWriter writeHeader: self hearderAwards.
			self submittedAwards
				do: [ :each | 
					neoWriter
						nextPut:
					{each nameAward.
					each submitter userAccount email}].

			neoWriter close ].
	^ cvs
]

{ #category : #rendering }
ERConfigurationController >> exportGroupManagers: fileName [
	|  cvs |
	cvs := String
		streamContents: [ :out | 
			| neoWriter |
			neoWriter := NeoCSVWriter on: out.
			neoWriter writeHeader: self headerGroups.
			self groups
				do: [ :each | 
					neoWriter
						nextPut:
							{each paymentInformation invoiceNumber.
							each groupManager userAccount firstName.
							each groupManager userAccount lastName.
							each groupManager userAccount email.
							each groupManager affiliationInformation organizationName.
							each groupManager affiliationInformation organizationAddrees1.
							each groupManager affiliationInformation organizationCity.
							each groupManager affiliationInformation organizationCountry.
							each groupManager affiliationInformation organizationPostal.
							each groupManager affiliationInformation membershipType} ].
				neoWriter close ].
	^ cvs
]

{ #category : #rendering }
ERConfigurationController >> exportTalks: fileName [
	| cvs |
	cvs := String
		streamContents: [ :out | 
			| neoWriter |
			neoWriter := NeoCSVWriter on: out.
			neoWriter writeHeader: self headerTalks.
			self submittedTalks
				do: [ :each | neoWriter 
				nextPut:
					{each name.
					each submitter userAccount email.
					each presentation} ].
			neoWriter close ].
	^ cvs
]

{ #category : #rendering }
ERConfigurationController >> exportUsers: fileName [
	| cvs |
	cvs := String
		streamContents: [ :out | 
			| neoWriter |
			neoWriter := NeoCSVWriter on: out.
			neoWriter writeHeader: self headerUser.
			self users
				do: [ :each | 
					neoWriter
						nextPut:
							{each id.
							each firstName.
							each lastName.
							each email.
							each password.
							each rolesAsString} ].
				neoWriter close ].
	^ cvs
]

{ #category : #'as yet unclassified' }
ERConfigurationController >> flat: dictionary with: aString [
	|list|
	list := OrderedCollection new.
	dictionary keysDo: [:key ||value|
		value := dictionary at: key.
		value at: aString put: key asString capitalized.
		list add: value].
	^ list
]

{ #category : #accessing }
ERConfigurationController >> groups [
	^ conference groups 
]

{ #category : #'accessing-headers' }
ERConfigurationController >> headerAttendee [
	^ #('InvoiceNumber' 'FirstName' 'LastName' 'Email' 'Country' 'Org. Name')
]

{ #category : #'accessing-headers' }
ERConfigurationController >> headerGroups [
	^ #('Invoice Number' 'First Name' 'Last Name' 'Email' 'Org. Name' 'Org. Address1' 
	'Org. City' 'Org. Country' 'Org. Postal' 'Org. Membership')
]

{ #category : #'accessing-headers' }
ERConfigurationController >> headerTalks [
	^ #('Name' 'Submitted By' 'Uploaded File')
]

{ #category : #'accessing-headers' }
ERConfigurationController >> headerUser [
	^ #('id' 'firstName' 'lastName' 'email' 'password' 'role')
]

{ #category : #'accessing-headers' }
ERConfigurationController >> headersParticipantsToLunches [
	^ #('Day' 'Normal' 'Vegetarian' 'Vegan')	
]

{ #category : #'accessing-headers' }
ERConfigurationController >> headersParticipantsToSocialDinner [
	^ #( 'Normal' 'Vegetarian' 'Vegan')	
]

{ #category : #'accessing-headers' }
ERConfigurationController >> headersShirtsStatistics [
	^ #('Size of the shirt' 'Female' 'Male')
]

{ #category : #'accessing-headers' }
ERConfigurationController >> hearderAwards [
	^ #('Name' 'Submitted by')
]

{ #category : #rendering }
ERConfigurationController >> invoices [
	^ (conference groups), 
	(conference attends 
		select: [ :each | each idGroup isNil ])
]

{ #category : #adding }
ERConfigurationController >> modifyTicket: aTicket [
	"Add validator for not accept use a ticket id name it was already exist"
	self saveTicket: aTicket.
	self notifyAllObservers 
]

{ #category : #initialization }
ERConfigurationController >> openRegistration [
	self conference configuration
		openRegistration: true.
	self conference	save.
	self notifyAllObservers
]

{ #category : #adding }
ERConfigurationController >> reductionTicketAlreadyExist: aReductionTicket [
	conference reductionTickets
		do: [ :each | 
			aReductionTicket ticketId = each ticketId
				ifTrue: [ ERException ticketWithIdAlreadyExist signal ] ]
]

{ #category : #accessing }
ERConfigurationController >> reductionTickets [
	^ conference reductionTickets
]

{ #category : #'as yet unclassified' }
ERConfigurationController >> saveConferenceWithConfiguration: configuration emailConfiguration: emailConfig organizer: organizer [
	self conference configuration:configuration.
	self conference configuration emailConfiguration: emailConfig .
	self conference configuration organizer: organizer .
	self conference save.
	self notifyAllObservers 
]

{ #category : #'as yet unclassified' }
ERConfigurationController >> saveFileOn: aFile withStream: stream [
	aFile
		ensureDelete;
		binaryWriteStreamDo: [ :outputStream | 
			(ZnCharacterWriteStream on: outputStream encoding: 'utf8')
				nextPutAll: stream contents ]
]

{ #category : #adding }
ERConfigurationController >> saveTicket: aReductionTicket [
	^ aReductionTicket save.
]

{ #category : #'as yet unclassified' }
ERConfigurationController >> statisticsOfLuch [
	|dict|
	dict := self dictionaryForLunch.
	conference attends do: [ :att |
		dict := att conferenceInformation addMyPreferenceForLuchTo: dict ].
	dict := self flat: dict with: 'Day'. 
	^ dict
]

{ #category : #'as yet unclassified' }
ERConfigurationController >> statisticsOfSocialDinner [
	|dict|
	dict := self dictionaryOfFoodPreference.
	conference attends do: [ :att |
		dict := att conferenceInformation addMyPreferenceForSocialDinnerTo: dict ].
	dict := OrderedCollection with: dict.
	^ dict
]

{ #category : #'as yet unclassified' }
ERConfigurationController >> statisticsOfTShirts [
	|dict|
	dict := self dictionaryOfShirts.
	conference attends do: [ :att |
		dict := att conferenceInformation addMytShirtTo: dict ].
	dict := self flat: dict with: 'Size of the shirt'.
	^ dict
]

{ #category : #accessing }
ERConfigurationController >> submittedAwards [
	^ conference submittedAwards
]

{ #category : #accessing }
ERConfigurationController >> submittedTalks [
	^ conference submittedTalks
]

{ #category : #rendering }
ERConfigurationController >> updateAffiliation: aff on: aGroup [
	aGroup groupManager affiliationInformation: aff.
	aGroup save.
	self notifyAllObservers 
]

{ #category : #adding }
ERConfigurationController >> updateFee: aFee [
	aFee save.
	self notifyAllObservers.
	^ aFee
	
]

{ #category : #accessing }
ERConfigurationController >> users [
	^ conference users
]

{ #category : #validations }
ERConfigurationController >> validateConferenceConfiguration: configuration [
	configuration dateFrom asDate < configuration dateTo asDate
	ifFalse: [ ^ ERException invalidEsugDates signal ]
	
]

{ #category : #validations }
ERConfigurationController >> validateEmailConfiguration: emailConfiguration [
	
]

{ #category : #validations }
ERConfigurationController >> validateOrganizerConfiguration: organizer [
]

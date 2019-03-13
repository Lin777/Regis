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
ERConfigurationController >> addAttendsToLunchPer: day to: list [
	| normal vegetarian vegan |
	normal :=((self attends select: [:each | each conferenceInformation isNormal]) select: [:each | each conferenceInformation perform: (day asSymbol)]) size.
	vegan :=((self attends select: [:each | each conferenceInformation isVegan]) select: [:each | each conferenceInformation perform: (day asSymbol)]) size.
	vegetarian :=((self attends select: [:each | each conferenceInformation isVegetarian]) select: [:each | each conferenceInformation perform: (day asSymbol)]) size.
	
	self addNormal: normal vegan: vegan vegetarian: vegetarian per: day to: list.
	
]

{ #category : #adding }
ERConfigurationController >> addItemTo: aList of: each [
	| man women |
	man := 0.
	women := 0.
	self attends
		do: [ :anAttendee | 
			anAttendee conferenceInformation tshirtSize = each
				ifTrue: [ anAttendee conferenceInformation isMale
						ifTrue: [ man := man + 1 ].
					anAttendee conferenceInformation isFemale
						ifTrue: [ women := women + 1 ] ]].
			aList
				add:
					(Dictionary new
						at: 'Size of the shirt' put: each;
						at: 'Man' put: man;
						at: 'Women' put: women;
						at: 'Total' put: man + women;
						yourself)
]

{ #category : #adding }
ERConfigurationController >> addNormal: normal vegan: vegan vegetarian: vegetarian per: day to: list [
	list
		add:
			(Dictionary new
				at: 'Day' put: day capitalized;
				at: 'Normal' put: normal;
				at: 'Vegetarian' put: vegetarian;
				at: 'Vegan' put: vegan;
				yourself)
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
	(ERController new findUserByEmail: anAttendee email)
		ifNil: [ | userSaved |
			userSaved := anAttendee userAccount save.
			conference addUser: userSaved.
			^ userSaved ].
	^ nil
]

{ #category : #accessing }
ERConfigurationController >> attends [
	^ conference attends 
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
	self deleteUserForConference: aGroup groupManager.
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
ERConfigurationController >> deleteUser: anUser [
	"The admin user can not be deleted"
	anUser isAdmin ifFalse: [ 
		"Fix ToDo"
		"self deleteDependencesOfAttendee: anUser.
		self deleteDependencesOfGroupManager: anUser.
		self deleteUserForConference: anUser"]
	ifTrue: [ ERException adminUserDoesNotDelete signal ]
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
	^ #( 'Normal' 'Vegetarian' 'Vegan' 'Total')	
]

{ #category : #'accessing-headers' }
ERConfigurationController >> headersShirtsStatistics [
	^ #('Size of the shirt' 'Man' 'Women' 'Total')
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

{ #category : #'as yet unclassified' }
ERConfigurationController >> listFoodPreferenceOfList: list symbolList: symbolList with: aSymbol [
	|result|
	result := OrderedCollection new.
	symbolList 
		do: [:symbol | result add:
			 (list select: [:each | each conferenceInformation perform: symbol 
				with: (each conferenceInformation perform: aSymbol)]) size ].
	^ result
]

{ #category : #'as yet unclassified' }
ERConfigurationController >> listWithNormal: normal vegan: vegan vegetarian: vegetarian [ 
	^ OrderedCollection new add: (Dictionary new at: 'Normal' put: normal; at: 'Vegetarian' put: vegetarian ; at: 'Vegan' put: vegan; at: 'Total' put: normal +vegan +vegetarian ; yourself );yourself 
]

{ #category : #adding }
ERConfigurationController >> modifyTicket: aTicket [
	"Add validator for not accept use a ticket id name it was already exist"
	self saveTicket: aTicket.
	self notifyAllObservers 
]

{ #category : #'as yet unclassified' }
ERConfigurationController >> participantsToLunches [
	| list |
	list := OrderedCollection new.
	ERAttendee days
		do: [ :day | self addAttendsToLunchPer: day to: list ].
	^ list
]

{ #category : #'as yet unclassified' }
ERConfigurationController >> participantsToSocialDinner [
	|attendees addedPeople list symbolList|
	
	symbolList := #(#isNormal: #isVegan: #isVegetarian:).
	
	attendees := (self listFoodPreferenceOfList: (self attends select: [:each | each conferenceInformation attendSocialEvent])
 		symbolList: symbolList 
		with: #foodPreference).
		
   addedPeople := (self listFoodPreferenceOfList: (self attends select: [:each | each conferenceInformation addPersonToSocialDinner ])
 		symbolList: symbolList 
		with: #personAddedFoodPreference).
	list := attendees + addedPeople .
	
	^ self listWithNormal: (list at:1) vegan: (list at:2) vegetarian: (list at:3) 
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
ERConfigurationController >> shirtsStatistics [
	| list |
	list := OrderedCollection new.
	ERAttendee tShirtSizes do: [ :each | self addItemTo: list of: each ].
	^ list
]

{ #category : #accessing }
ERConfigurationController >> submittedAwards [
	^ conference submittedAwards
]

{ #category : #accessing }
ERConfigurationController >> submittedTalks [
	^ conference submittedTalks
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
	ifFalse: [ ERException invalidEsugDates signal ]
	
]

{ #category : #validations }
ERConfigurationController >> validateEmailConfiguration: emailConfiguration [
]

{ #category : #validations }
ERConfigurationController >> validateOrganizerConfiguration: organizer [
]

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
ERConfigurationController >> addFee: aFee [
	|savedFee|
	aFee bankAccountInformation bankInformation save.
	aFee bankAccountInformation save.
	savedFee := aFee save.
	 conference addFee: savedFee.
	 conference save.
	^ savedFee
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
ERConfigurationController >> deleteFee: aFee [
	conference fees removeAllSuchThat: [ :each | each id = aFee id ].
	^ aFee delete.
]

{ #category : #'as yet unclassified' }
ERConfigurationController >> deleteReductionTicket: aReductionTicket [
	aReductionTicket usersOfTickets size > 0
		ifTrue: [ ^ nil ]
		ifFalse: [ conference reductionTickets
				removeAllSuchThat: [ :each | each ticketId = aReductionTicket ticketId ].
				aReductionTicket delete ]
]

{ #category : #rendering }
ERConfigurationController >> deleteUser: anUser [
	"The admin user can not be deleted"
	anUser isAdmin ifFalse: [  ]
	ifTrue: [ ^ nil ]
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
							{each userAccount firstName.
							each userAccount lastName.
							each userAccount email.
							each contactInformation country.
							each affiliationInformation organizationName} ] ].
	self
		saveFileOn: FileLocator imageDirectory / fileName asFileName , 'cvs'
		withStream: cvs
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
					each submitter userAccount email} ]].
				self
		saveFileOn: FileLocator imageDirectory / fileName asFileName , 'cvs'
		withStream: cvs
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
							{each groupManager userAccount firstName.
							each groupManager userAccount lastName.
							each groupManager userAccount email.
							each groupManager userAccount password.
							each groupManager userAccount rolesAsString.
							each groupManager affiliationInformation organizationName.
							each groupManager affiliationInformation organizationAddrees1.
							each groupManager affiliationInformation organizationAddrees2.
							each groupManager affiliationInformation organizationCity.
							each groupManager affiliationInformation organizationCountry.
							each groupManager affiliationInformation organizationProvince.
							each groupManager affiliationInformation organizationPostal.
							each groupManager affiliationInformation membershipType} ] ].
	self
		saveFileOn: FileLocator imageDirectory / fileName asFileName , 'cvs'
		withStream: cvs
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
					each presentation} ]].
	self
		saveFileOn: FileLocator imageDirectory / fileName asFileName , 'cvs'
		withStream: cvs
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
							each rolesAsString} ] ].
	self
		saveFileOn: FileLocator imageDirectory / fileName asFileName , 'cvs'
		withStream: cvs
]

{ #category : #accessing }
ERConfigurationController >> fees [
	^ conference fees
]

{ #category : #accessing }
ERConfigurationController >> groups [
	^ conference groups 
]

{ #category : #rendering }
ERConfigurationController >> headerAttendee [
	^ #('FirstName' 'LastName' 'Email' 'Country' 'Org. Name')
]

{ #category : #rendering }
ERConfigurationController >> headerGroups [
	^ #('First Name' 'Last Name' 'Email' 'Password' 'Org. Name' 'Org. Address1' 'Org. Address2' 'Org. City' 'Org. Country' 'Org. Province' 'Org. Postal' 'Org. Membership')
]

{ #category : #rendering }
ERConfigurationController >> headerTalks [
	^ #('Name' 'Submitted By' 'Uploaded File')
]

{ #category : #rendering }
ERConfigurationController >> headerUser [
	^ #('id' 'firstName' 'lastName' 'email' 'password' 'role')
]

{ #category : #'as yet unclassified' }
ERConfigurationController >> headersParticipantsToLunches [
	^ #('Day' 'Normal' 'Vegetarian' 'Vegan')	
]

{ #category : #'as yet unclassified' }
ERConfigurationController >> headersParticipantsToSocialDinner [
	^ #( 'Normal' 'Vegetarian' 'Vegan' 'Total')	
]

{ #category : #'as yet unclassified' }
ERConfigurationController >> headersShirtsStatistics [
	^ #('Size of the shirt' 'Man' 'Women' 'Total')
]

{ #category : #rendering }
ERConfigurationController >> hearderAwards [
	^ #('Name' 'Submitted by')
]

{ #category : #'as yet unclassified' }
ERConfigurationController >> listWithNormal: normal vegan: vegan vegetarian: vegetarian [ 
	^ OrderedCollection new add: (Dictionary new at: 'Normal' put: normal; at: 'Vegetarian' put: vegetarian ; at: 'Vegan' put: vegan; at: 'Total' put: normal +vegan +vegetarian ; yourself );yourself 
]

{ #category : #adding }
ERConfigurationController >> modifyTicket: aTicket [
	"Add validator for not accept use a ticket id name it was already exist"
	self saveTicket: aTicket
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
	| normal vegetarian vegan list|
	list := (self attends select: [:each | each conferenceInformation attendSocialEvent]).
	normal :=(list select: [:each | each conferenceInformation isNormal]) size.
	vegan :=(list select:  [:each | each conferenceInformation isVegan]) size.
	vegetarian :=(list select:  [:each | each conferenceInformation isVegetarian]) size.
	^ self listWithNormal: normal vegan: vegan vegetarian: vegetarian 
]

{ #category : #adding }
ERConfigurationController >> reductionTicketAlreadyExist: aReductionTicket [
	conference reductionTickets
		do: [ :each | 
			aReductionTicket ticketId = each ticketId
				ifTrue: [ ERException new
						messageText:
							'There is already a previously registered ticket with this ticket ID'; signal ] ]
]

{ #category : #accessing }
ERConfigurationController >> reductionTickets [
	^ conference reductionTickets
]

{ #category : #adding }
ERConfigurationController >> registerAsAttendee [
	attendee userAccount
		roleAdd: 'attendee';
		save.
	attendee save.
	conference addAttendee: attendee.
	conference save.
	^ attendee
]

{ #category : #adding }
ERConfigurationController >> registerAsGroupManager [
	attendee userAccount
		roleAdd: 'groupManager';
		save.
	attendee save.
	conference save.
	^ attendee
]

{ #category : #'as yet unclassified' }
ERConfigurationController >> registrationsStatistics [
	|list|
	list := OrderedCollection new.
	^ list
"	^ #('Date' 'Total Attendees')"
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
	aReductionTicket discountStrategy save.
	aReductionTicket limitStrategy save.
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

{ #category : #accessing }
ERConfigurationController >> users [
	^ conference users
]

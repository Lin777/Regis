Class {
	#name : #ERConfigurationController,
	#superclass : #ERLoggedController,
	#category : #'ESUGApp-Controller'
}

{ #category : #adding }
ERConfigurationController >> addAttendee: anAttendee [
	| anAttendeeSaved |
	(ERUserAccount findUserByEmail: anAttendee email)
		ifNil: [ | userSaved |
			userSaved := anAttendee userAccount save.
			conference addUser: userSaved.
			anAttendeeSaved := (anAttendee userAccount: userSaved) save.
			conference addAttendee: anAttendeeSaved.
			conference save.
			^ anAttendeeSaved ].
	^ nil
]

{ #category : #adding }
ERConfigurationController >> addAttendsToLunchPer: day to: list [
	| normal vegetarian vegan |
	normal := 0. vegan := 0. vegetarian := 0.
	self attends
		do: [ :anAttendee | 
			(anAttendee perform: day asSymbol)
				ifTrue: [ anAttendee isNormal
						ifTrue: [ normal := normal + 1 ].
					anAttendee isVegan
						ifTrue: [ vegan := vegan + 1 ].
					anAttendee isVegetarian
						ifTrue: [ vegetarian := vegetarian + 1 ] ] ].
	self addNormal: normal vegan: vegan vegetarian: vegetarian per: day to: list
]

{ #category : #adding }
ERConfigurationController >> addItemTo: aList of: each [
	| man women |
	man := 0.
	women := 0.
	self attends
		do: [ :anAttendee | 
			anAttendee tshirtSize = each
				ifTrue: [ anAttendee isMale
						ifTrue: [ man := man + 1 ].
					anAttendee isFemale
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
	(ERUserAccount findUserByEmail: anAttendee email)
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
ERConfigurationController >> createFile: aNameFile [
	^ FileStream newFileNamed: aNameFile.
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
ERConfigurationController >> exportAttends [
	| file cvs |
	file := self createFile: 'attends.cvs'.
	cvs := NeoCSVWriter on: file.
	cvs writeHeader: self headerAttendee.
	self attends
		do: [ :each | 
			cvs
				nextPut:
					{each id.
					each firstName.
					each lastName.
					each email.
					each password.
					each userAccount rolesAsString.
					each address.
					each address2.
					each city.
					each country.
					each province.
					each postal.
					each facebookURL.
					each twitterURL.
					each homePage.
					''.
					each gender.
					each tshirtSize.
					each foodPreference.
					each attendSocialEvent asString.
					each addedToMainList asString.
					each orgName.
					each orgAddrees1.
					each orgAddrees2.
					each orgCity.
					each orgCountry.
					each orgProvince.
					each orgPostal.
					each membershipType.
					each keywords.
					each additionalText.
					each paymentType.
					each coupon.
					each paymentCurrency} ]
]

{ #category : #rendering }
ERConfigurationController >> exportAwards [
	| file cvs |
	file := self createFile: 'awards.cvs'.
	cvs := NeoCSVWriter on: file.
	cvs writeHeader: self hearderAwards.
	self submittedAwards
		do: [ :each | 
			cvs
				nextPut:
					{each name1.
					each submittedBy.} ]
]

{ #category : #rendering }
ERConfigurationController >> exportGroupManagers [
	| file cvs |
	file := self createFile: 'groupManagers.cvs'.
	cvs := NeoCSVWriter on: file.
	cvs writeHeader: self headerGroups.
	self groups
		do: [ :each | 
			cvs
				nextPut:
					{each groupManager id.
					each groupManager firstName.
					each groupManager lastName.
					each groupManager email.
					each groupManager password.
					each groupManager userAccount rolesAsString.
					each groupManager orgName.
					each groupManager orgAddrees1.
					each groupManager orgAddrees2.
					each groupManager orgCity.
					each groupManager orgCountry.
					each groupManager orgProvince.
					each groupManager orgPostal.
					each groupManager membershipType} ]
]

{ #category : #rendering }
ERConfigurationController >> exportTalks [
	| file cvs |
	file := self createFile: 'talks.cvs'.
	cvs := NeoCSVWriter on: file.
	cvs writeHeader: self headerTalks.
	self submittedTalks
		do: [ :each | 
			cvs
				nextPut:
					{each name1.
					each submittedBy.
					each uploadFile} ]
]

{ #category : #rendering }
ERConfigurationController >> exportUsers [
	| file cvs |
	file := self createFile: 'users.cvs'.
	cvs := NeoCSVWriter on: file.
	cvs
		writeHeader: self headerUser.
	self users
		do: [ :each | 
			cvs
				nextPut:
					{each id.
					each firstName.
					each lastName.
					each email.
					each password.
					each rolesAsString} ]
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
	^ #('Id' 'FirstName' 'LastName' 'Email' 'Password' 'Role' 'Address Line1' 'Address Line2' 'City' 'Country' 'Province' 'Postal' 'Facebook URL' 'Twitter URL' 'Home Page' 'Days' 'Gender' 'T-Shirt' 'Preference Food' 'Social Event' 'Added main List' 'Org. Name' 'Org. Address1' 'Org. Address2' 'Org. City' 'Org. Country' 'Org. Province' 'Org. Postal' 'Org. Membership' 'keywords' 'Additional text' 'Payment Type' 'Reduction ticket' 'Currency' )
]

{ #category : #rendering }
ERConfigurationController >> headerGroups [
	^ #('id' 'First Name' 'Last Name' 'Email' 'Password' 'Org. Name' 'Org. Address1' 'Org. Address2' 'Org. City' 'Org. Country' 'Org. Province' 'Org. Postal' 'Org. Membership')
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
	| normal vegetarian vegan |
	normal := 0. vegan := 0. vegetarian := 0.
	self attends
		do: [ :anAttendee | 
			(anAttendee attendSocialEvent)
				ifTrue: [ anAttendee isNormal
						ifTrue: [ normal := normal + 1 ].
					anAttendee isVegan
						ifTrue: [ vegan := vegan + 1 ].
					anAttendee isVegetarian
						ifTrue: [ vegetarian := vegetarian + 1 ].
					anAttendee addPersonToSocialDinner ifTrue: [ "Person added by default normal"normal := normal + 1 ] ] ].
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
	attendee save."
	conference addAttendee: attendee."
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

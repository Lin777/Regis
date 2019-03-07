Class {
	#name : #ESUGSetUp,
	#superclass : #Object,
	#category : #'ESUGApp-Core'
}

{ #category : #accessing }
ESUGSetUp class >> activateOnlyThisConference: aConference [
	ERConference findAll do: [ :each | each active: false ].
	aConference active: true; save
	"
ERAttendee findAll."
]

{ #category : #accessing }
ESUGSetUp class >> addReductionFeeForGoldSponsor: sponsorName forConference: conference [
	| goldSponsorReductionTicket |
	"10% to 5 at most"
	goldSponsorReductionTicket := ERReductionTicket new
		ticketId: sponsorName , (1 to: 9999) atRandom asString;
		discountStrategy: (ERPercentageDiscount of: 10);
		limitStrategy: (ERLimitedReductionTicketUse of: 5); save.
	conference addReductionTicket: goldSponsorReductionTicket
]

{ #category : #accessing }
ESUGSetUp class >> addReductionFeeForPlatiniumSponsor: sponsorName forConference: conference [
	| platiniumSponsorReductionTicket |
	"20% to 10 at most"
	platiniumSponsorReductionTicket := ERReductionTicket new
		ticketId: sponsorName , (1 to: 9999) atRandom asString;
		discountStrategy: (ERPercentageDiscount of: 20);
		limitStrategy: (ERLimitedReductionTicketUse of: 10); save.
	conference addReductionTicket: platiniumSponsorReductionTicket
]

{ #category : #accessing }
ESUGSetUp class >> configureESUGFeesForConference: conference [
	| esugEuroBankAccountInformation esugEuroFee |
	esugEuroBankAccountInformation := ERBankAccountInformation new
		owner: 'ESUG - EUROPEAN SMALLTALK USERS GROUP';
		number: 'W751167780';
		iban: 'FR76 1562 9027 0100 0433 0600 144';
		ribKey: '44';
		bankInformation:
			(ERBankInformation new
				name: 'Crédit Mutuel Nord Europe';
				code: '15629';
				counterCode: '02701';
				bic: 'CMCIFR2A';
				addressString:
					'CCM Douai
92 rue de Paris
59500 Douai
').
	esugEuroFee := ERFee new
		erfAllDaysFee: 470;
		erfOneDayFee: 170;
		lrfAllDaysFee: 660;
		lrfOneDayFee: 210;
		extraPersonSD: 50;
		currency: 'Euro';
		payPalCommissionPercentage: 5.4;
		staticCommissionPaypal: 0.3;
		bankAccountInformation: esugEuroBankAccountInformation;
		bankPayPalUrl:
			'https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=board%40esug.org&item_name=ESUG+Conference+Registration&item_number=[INVOICENUMBER]&amount=[AMOUNT]&no_shipping=1&no_note=1&currency_code=EUR&charset=UTF-8'; save.
	conference fee: esugEuroFee
]

{ #category : #accessing }
ESUGSetUp class >> configureESUGReductionCodesForConference: conference [
	| studentVolunteerReductionTicket platiniumSponsors goldSponsors |
	"students"
	studentVolunteerReductionTicket := ERReductionTicket new
		ticketId: 'students' , (1 to: 9999) atRandom asString;
		discountStrategy: (ERPercentageDiscount of: 100);
		limitStrategy: (ERLimitedReductionTicketUse of: 15); save.
	conference
		addReductionTicket: studentVolunteerReductionTicket.

	"free entrance"
	studentVolunteerReductionTicket := ERReductionTicket new
		ticketId: 'free' , (1 to: 9999) atRandom asString;
		discountStrategy: (ERPercentageDiscount of: 100) ;
		limitStrategy: (ERLimitedReductionTicketUse of: 1) ; save.
	conference
		addReductionTicket: studentVolunteerReductionTicket.

	"platinium sponsors"
	platiniumSponsors := #(cincom instantiations gemtalk).
	platiniumSponsors
		do: [ :sponsorName | 
			self
				addReductionFeeForPlatiniumSponsor: sponsorName asString
				forConference: conference ].

	"gold sponsors"
	goldSponsors := #(stic heegek deltalloyd).
	goldSponsors
		do: [ :sponsorName | 
			self
				addReductionFeeForGoldSponsor: sponsorName asString
				forConference: conference ]
]

{ #category : #accessing }
ESUGSetUp class >> createAndRegisterConferenceWithConfiguration: esugConferenceConfiguration atEntryPoint: entryPoint [
	| conference adminPassword adminUser |
	conference := ERConference new
		configuration: esugConferenceConfiguration;
		save.
	adminPassword := '12345678'.
	adminUser := ERUserAccount new
		firstName: 'Admin';
		lastName: 'Admin';
		password: (ERUserAccount hashPassword: adminPassword) asString;
		email: 'admin@esug.org';
		role: ERUserAccount adminRole;
		save.
	conference
		addUser: adminUser;
		save.
	^ conference
]

{ #category : #accessing }
ESUGSetUp class >> createESUGConfiguration [
	| esugEmailConfiguration conferenName esugOrganizer |
	"Set Postmark key"
	"PatSmtpToPostMarkClientAdapter key: 'xxxxx'. 
	"
	esugEmailConfiguration := ERConferenceEmailConfiguration new
		senderEmailAddress: 'dev@esug.org';
		apiKey: '3d9cd16a-3d91-4a2d-a4e3-1c8644767d71';
		welcomeText: 'Welcome to this great conference'.
	
	esugOrganizer := ERConferenceOrganizer new
		name: 'ESUG';
		fiscalSituation: 'Association Loi 1901 n°W751167780 (not subjected to  V.A.T.)';
		webPageUrl: 'http://www.esug.org';
		addressString:
			'c/o Mr. Stéphane Ducasse - 1 rue Cesar Franck 59800 Lille - France'.
		
	conferenName := 'ESUG'.
	^ ERConferenceConfigurationModel new
		organizer: esugOrganizer;
		name: conferenName;
		description: 'ESUG International Smalltalk Conference';
		homePageUrl: 'http://www.esug.org/wiki/pier/Conferences/2018/';
		dateFrom: '09/10/2019';
		dateTo: '09/14/2019';
		dateSubmissionDeadline:  '09/14/2019';
		earlyRegistrationDeadline: '07/25/2019';
		emailConfiguration: esugEmailConfiguration
]

{ #category : #accessing }
ESUGSetUp class >> initialize [
	
	Metacello new
	baseline: 'Magritte';
		repository: 'github://magritte-metamodel/magritte:master/source';
		onConflict: [ :ex :a :b | a projectName = b projectName ifTrue: [ a projectSpec isBaselineOfProjectSpec ifTrue: [ ex useLoaded ] ifFalse: [ ex useIncoming ] ] ifFalse: [ ex resume ] ];
		load: #('Magritte-Seaside').
	Metacello new 
		baseline: 'MaterialDesignLite'; 
		repository: 'github://DuneSt/MaterialDesignLite:v2.1.2/src';
		onConflict: [ :ex :a :b | a projectName = b projectName ifTrue: [ a projectSpec 		isBaselineOfProjectSpec ifTrue: [ ex useLoaded ] ifFalse: [ ex useIncoming ] ] ifFalse: [ ex resume ] ];
		load: 'all'.
	Metacello new
        githubUser: 'pharo-contributions' project: 'Artefact' commitish: 'master' path: 'src';
        baseline: 'Artefact';
        onConflict: [ :ex :a :b | a projectName = b projectName ifTrue: [ a projectSpec isBaselineOfProjectSpec ifTrue: [ ex useLoaded ] ifFalse: [ ex useIncoming ] ] ifFalse: [ ex resume ] ];
        load: #('default' 'seaside').
]

{ #category : #accessing }
ESUGSetUp class >> start [
	| esugConferenceConfiguration entryPoint conference |
	"self start"
	self startAndCleanSeaside.
	esugConferenceConfiguration := self createESUGConfiguration.
	entryPoint := 'esug'.
	conference := self
		createAndRegisterConferenceWithConfiguration: esugConferenceConfiguration
		atEntryPoint: entryPoint.
	self configureESUGFeesForConference: conference.
	self configureESUGReductionCodesForConference: conference.
	self activateOnlyThisConference: conference.
	EREsugApp initialize
]

{ #category : #accessing }
ESUGSetUp class >> startAndCleanSeaside [
	ZnZincServerAdaptor startOn: 8000.

	"Clear Seaside registered App"
	WAAdmin clearAll.
	WAAdmin applicationDefaults
		removeParent: WADevelopmentConfiguration instance.
	WAFileHandler default: WAFileHandler new.
	WAFileHandler default
		preferenceAt: #fileHandlerListingClass
		put: WAHtmlFileHandlerListing.
	WAAdmin defaultDispatcher
		register: WAFileHandler default
		at: 'files'.
	WAAdmin register: WADispatcherBrowser asApplicationAt: 'browse'.

	WAConfigurationTool initialize
]

{ #category : #accessing }
ESUGSetUp class >> stop [
	"STOP and Clean (incomplete)"
	ZnZincServerAdaptor stop.
]

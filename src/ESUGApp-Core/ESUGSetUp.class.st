"
Description
-------------------------------------
I am a principal class for page

Examples
--------------------

This class load dependencies with conflicts such as: Artefact, MaterialDesignLite (magritte) and Magritte.

When execute: 

ESUGSetUp start.

If not exist a Backup folder this script will initialize all necesary objects .
If exist a Backup folder this script will restore all objects of backup

"
Class {
	#name : #ESUGSetUp,
	#superclass : #Object,
	#category : #'ESUGApp-Core'
}

{ #category : #conferenceConfiguration }
ESUGSetUp class >> activateOnlyThisConference: aConference [
	ERConference findAll do: [ :each | each active: false ].
	aConference active: true; save
]

{ #category : #configurationOfReductionTickets }
ESUGSetUp class >> addFreeEntranceTicketTo: conference [
	|freeEntranceReductionTicket|
	"free entrance"
	freeEntranceReductionTicket := ERReductionTicket new
		ticketId: 'free' , (1 to: 9999) atRandom asString;
		discountStrategy: (ERPercentageDiscount of: 100) ;
		limitStrategy: (ERLimitedReductionTicketUse of: 1) ; save.
	conference
		addReductionTicket: freeEntranceReductionTicket.
]

{ #category : #configurationOfReductionTickets }
ESUGSetUp class >> addGoldSponsorsTo: conference [
   "gold sponsors"
  #(stic heegek deltalloyd)
		do: [ :sponsorName | 
			self
				addReductionFeeForGoldSponsor: sponsorName asString
				forConference: conference ]
]

{ #category : #configurationOfReductionTickets }
ESUGSetUp class >> addPlatiniumSponsorsTo: conference [
   "platinium sponsors"
	#(cincom instantiations gemtalk)
		do: [ :sponsorName | 
			self
				addReductionFeeForPlatiniumSponsor: sponsorName asString
				forConference: conference ].
]

{ #category : #configurationOfReductionTickets }
ESUGSetUp class >> addReductionFeeForGoldSponsor: sponsorName forConference: conference [
	| goldSponsorReductionTicket |
	"10% to 5 at most"
	goldSponsorReductionTicket := ERReductionTicket new
		ticketId: sponsorName , (1 to: 9999) atRandom asString;
		discountStrategy: (ERPercentageDiscount of: 10);
		limitStrategy: (ERLimitedReductionTicketUse of: 5); save.
	conference addReductionTicket: goldSponsorReductionTicket
]

{ #category : #configurationOfReductionTickets }
ESUGSetUp class >> addReductionFeeForPlatiniumSponsor: sponsorName forConference: conference [
	| platiniumSponsorReductionTicket |
	"20% to 10 at most"
	platiniumSponsorReductionTicket := ERReductionTicket new
		ticketId: sponsorName , (1 to: 9999) atRandom asString;
		discountStrategy: (ERPercentageDiscount of: 20);
		limitStrategy: (ERLimitedReductionTicketUse of: 10); save.
	conference addReductionTicket: platiniumSponsorReductionTicket
]

{ #category : #configurationOfReductionTickets }
ESUGSetUp class >> addStudentVolunterTicketTo: conference [
	|studentVolunteerReductionTicket|
   "students"
	studentVolunteerReductionTicket := ERReductionTicket new
		ticketId: 'students' , (1 to: 9999) atRandom asString;
		discountStrategy: (ERPercentageDiscount of: 100);
		limitStrategy: (ERLimitedReductionTicketUse of: 15); save.
	conference
		addReductionTicket: studentVolunteerReductionTicket.
]

{ #category : #setUps }
ESUGSetUp class >> cleanDatabase [

	ERDatabase initialize
]

{ #category : #accessing }
ESUGSetUp class >> configurationOfHome [
	^ (ERConfigurationOfHomePage new 
		title: 'ESUG 2022';
		htmlContent: '<p>
The ESUG board is pleased to announce that the 28th ESUG conference/summer-school will be held in Novi Sad, Serbia from 22.8.2022. to 26.8.2022 (with Camp Smalltalk 20/21.8.). The conference is organised by the Faculty of Sciences, University of Novi Sad.
</p>
<section>
<h3>Conference calls</h3>

<ul>
<li> <a href="https://esug.github.io/2022-Conference/call2022.html" target="_blank">Call for Presentations</a></li>
<li> <a href="https://esug.github.io/2022-Conference/callForStudents2022.html" target="_blank">Call for Student Volunteers</a></li>
<li> <a href="https://esug.github.io/2022-Conference/cfpIWST2022.html" target="_blank">IWST22</a> </li>
<li> <a href="https://esug.github.io/2022-Conference/awardsSubmissions.html" target="_blank">Innovation award call: Submissions and Winners</a></li>
<li> <a href="https://esug.github.io/2022-Conference/camp2022.html" target="_blank">Camp Smalltalk</a></li>
</ul>


</section><section>
<h3> Conference registration</h3>
<a id="registration"></a>
<p>
The conference registration will be open soon on our portal. 
</p>


<p>
Orientational conference prices from ESUG 2019 in Euros:
</p>
<ul>
<li> Early Registration Fee: 500€ (all days) / 180€ (per day)</li>
<li> Late Registration Fee: 660€ (all days) / 210€ (per day)</li>
<li> Extra person to social dinner: 60€</li>
<li> Payment by bank transfer: free of charge</li>
<li> Payment by credit card: +6% fees</li>
</ul>


</section><section>
<h3>Conference Program</h3>

<p>
Slides will be uploaded <a href="https://github.com/ESUG/esug.github.io/tree/source/2022-Conference/slides/"  target="_blank">here</a> 
</p>
<p>
Videos will be on <a href="https://www.youtube.com/" target="_blank">youtube</a>
</p>



</section><section>
<h3>International Workshop on Smalltalk Technologies IWST</h3>

<ul>
<li> CfP: <a href="https://esug.github.io/2022-Conference/cfpIWST2022.html" target="_blank">IWST22</a></li>
<li> The workshop proceedings will be published in <a href="http://dl.acm.org/citation.cfm?id=2991041&amp;preflayout=flat" target="_blank">ACM Digital Library- Download IWST-Proceedings (to be announced)</a></li>
</ul>







</section><section>
<h3>Innovation Technology Awards - 18th Edition</h3>
<p>
Share your Smalltalk related code with the community, and enter the contest to win up to 500 Euros! All you have to do is submit your project along with  a 3-5 min videos and post it to youtube!
</p>
<ul>
<li> <a href="https://esug.github.io/2022-Conference/awardsCall2022.html" target="_blank">2022 Innovation award call</a></li>
<li> <a href="https://esug.github.io/2022-Conference/awardsSubmissions.html" target="_blank">list of submitted Projects: Winners Inside!</a></li>
<li> Dates:<ul>
<li> Demos: Monday, XXX evening.</li>
<li> Results Announcement Ceremony: Wednesday, XXX, during the social event dinner</li>
</ul>
</li>
</ul>


</section><section>
<h3>Student volunteer call</h3>
<p>
See <a href="https://esug.github.io/2022-Conference/callForStudents2022.html" target="_blank">Call for Student Volunteers</a>
</p>
</section><section>
<h3>Conference live</h3>

<ul>
<li> Videos will be on Youtube</li>
<li> SlideShare: <a href="http://www.slideshare.net/esug/presentations" target="_blank">http://www.slideshare.net/esug/presentations</a></li>
<li> Archive: <a href="http://www.esug.org/data/ESUG2022/" target="_blank">http://www.esug.org/data/ESUG2022/</a></li>
</ul>

</section><section>
<h3>NoviSad</h3>
<p>
<a href="https://novisad.travel/en/" target="_blank">General (tourist) Information</a>
</p>

</section><section>
<h3>Venue and Maps</h3>


<section>
<h4>Conference venue</h4>

<p>
The conference will be held at the <a href="https://goo.gl/maps/b3RAqZYXtvsFGx2h7" target="_blank">building of the Department of Matehmatics and Informatics, Faculty of Sciences, University of Novi Sad</a>.
</p>

</section><section>
<h4> Social Event</h4>
<a id="social"></a>


<p>
During the diner, results of the various ESUG awards will be announced.
</p>


<p>
If you want to attend the social event with your partner you can pay an extra fee for him/her directly during your registration for the conference.
</p>

</section><section>
<h4> Staying in Novi Sad</h4>

<p>
Here is a list of hotels that would allow you to easily reach the conference venue, with the walking distance.
</p><ul>
<li> <a href="http://www.voyagerns.co.rs/index.html" target="_blank">Voyager B&amp;B</a>, 5 minutes</li>
<li> <a href="https://hotelzenit.co.rs/en/" target="_blank">Zenit</a>, 15 minutes</li>
<li> <a href="https://www.hotelputnik.rs/index.php?langiso3=GBR" target="_blank">Putnik</a>, 15 minutes</li>
<li> <a href="https://hotelmediteraneo.rs/" target="_blank">Mediteraneo</a>, 15 minutes</li>
<li> <a href="https://hotel-centar.rs/homepage-1/" target="_blank">Centar</a>, 20 minutes</li>
<li> <a href="https://hotelpupin.rs/en/" target="_blank">Pupin</a>, 20 minutes</li>
<li> <a href="https://hotelvelikinovisad.com/en/" target="_blank">Veliki</a>, 20 minutes</li>
<li> <a href="https://www.restoranfontana.com/en/prenociste-smestaj-apartmani-novi-sad/" target="_blank">Fontana</a>, 20 minutes</li>
<li> <a href="http://www.leopoldns.com/" target="_blank">Leopold I</a>, 25 minutes + stairs to the fortress</li>
<li> <a href="http://en.planetainn.com/" target="_blank">Planeta Inn</a>, 25 minutes</li>
<li> <a href="https://www.hotelparkns.com/en/" target="_blank">Park</a>, 30 minutes</li>
<li> <a href="https://vila-park-novi-sad-rs.book.direct/en-gb" target="_blank">Vila Park</a>, 30 minutes </li>
</ul>



<p>
There are also many Bed &amp; Breakfasts and short let flats.
Look for them on sites such as <a href="http://booking.com" target="_blank">Booking.com</a> or <a href="http://airbnb.com" target="_blank">Airbnb</a>.
</p>
</section><section>
<h4>Student volunteer hosting</h4>
<p>
If you are student volunteer, do not book yourself, we have arranged the booking already!
</p>

</section></section>
')
]

{ #category : #configurationOfFee }
ESUGSetUp class >> configureESUGFeesForConference: conference [
	conference fee: self createFee
]

{ #category : #configurationOfReductionTickets }
ESUGSetUp class >> configureESUGReductionCodesForConference: conference [

	"students"
	self addStudentVolunterTicketTo: conference.

	"free entrance"
	self addFreeEntranceTicketTo: conference.

	"platinium sponsors"
	self addPlatiniumSponsorsTo: conference.

	"gold sponsors"
	self addGoldSponsorsTo: conference
]

{ #category : #conferenceConfiguration }
ESUGSetUp class >> createAdminUserWithPassword: adminPassword [
	^ ERUserAccount new
		firstName: 'Admin';
		lastName: 'Admin';
		password: (ERUserAccount hashPassword: adminPassword) asString;
		email: 'admin@esug.org';
		role: ERUserAccount adminRole;
		save.
]

{ #category : #conferenceConfiguration }
ESUGSetUp class >> createAndRegisterConferenceWithConfiguration: esugConferenceConfiguration atEntryPoint: entryPoint [
	| conference adminPassword  |
	conference := ERConference new
		configuration: esugConferenceConfiguration;
		save.
	conference configurationOfHomePage: self configurationOfHome.
	adminPassword := '12345678'.
	conference
		addNewUser: (self createAdminUserWithPassword: adminPassword);
		save.
	^ conference
]

{ #category : #configurationOfFee }
ESUGSetUp class >> createBankAccountInformation [
	^ ERBankAccountInformation new
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
]

{ #category : #conferenceConfiguration }
ESUGSetUp class >> createESUGConfiguration [
	^ ERConferenceConfigurationModel new
		organizer: self createEsugConferenceOrganizer;
		name: 'ESUG';
		description: 'ESUG International Smalltalk Conference';
		homePageUrl: 'http://www.esug.org/wiki/pier/Conferences/2018/';
		dateFrom: '10/10/2020';
		dateTo: '10/14/2020';
		dateSubmissionDeadline:  '10/14/2020';
		earlyRegistrationDeadline: '09/25/2020';
		emailConfiguration: self createEsugEmailConfiguration
]

{ #category : #conferenceConfiguration }
ESUGSetUp class >> createEsugConferenceOrganizer [
	^ ERConferenceOrganizer new
		name: 'ESUG';
		fiscalSituation: 'Association Loi 1901 n°W751167780 (not subjected to  V.A.T.)';
		webPageUrl: 'http://www.esug.org';
		addressString:
			'c/o Mr. Stéphane Ducasse - 1 rue Cesar Franck 59800 Lille - France'.
]

{ #category : #conferenceConfiguration }
ESUGSetUp class >> createEsugEmailConfiguration [
	^ ERConferenceEmailConfiguration new
		senderEmailAddress: 'dev@esug.org';
		apiKey: '3d9cd16a-3d91-4a2d-a4e3-1c8644767d71';
		welcomeText: 'Welcome to this great conference'.
]

{ #category : #configurationOfFee }
ESUGSetUp class >> createFee [
	^ ERFee new
		erfAllDaysFee: 500;
		erfOneDayFee: 180;
		lrfAllDaysFee: 660;
		lrfOneDayFee: 210;
		extraPersonSD: 60;
		currency: 'Euro';
		payPalCommissionPercentage: 5.4;
		staticCommissionPaypal: 0.3;
		creditCardCommissionPercentage: 0;
		bankAccountInformation: self createBankAccountInformation;
		bankPayPalUrl:
			'https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=board%40esug.org&item_name=ESUG+Conference+Registration&item_number=[INVOICENUMBER]&amount=[AMOUNT]&no_shipping=1&no_note=1&currency_code=EUR&charset=UTF-8'; save.
]

{ #category : #backupAndRestoreData }
ESUGSetUp class >> existBackupToRestart [
	|path|
	path := (Smalltalk imageDirectory / 'Backup').
	^ path hasFiles
	
]

{ #category : #installationOfConflictLibraries }
ESUGSetUp class >> initialize [
	self installDependencesWithConflicts
]

{ #category : #setUps }
ESUGSetUp class >> initializeDataFromScratch [
	| esugConferenceConfiguration entryPoint conference |
	esugConferenceConfiguration := self createESUGConfiguration.
	entryPoint := 'esug'.
	conference := self
		createAndRegisterConferenceWithConfiguration: esugConferenceConfiguration
		atEntryPoint: entryPoint.
	self configureESUGFeesForConference: conference.
	self configureESUGReductionCodesForConference: conference.
	self activateOnlyThisConference: conference
]

{ #category : #installationOfConflictLibraries }
ESUGSetUp class >> installArtefact [
	Metacello new
        githubUser: 'Lin777' project: 'Artefact' commitish: 'master' path: 'src';
        baseline: 'Artefact';
        onConflict: [ :ex :a :b | a projectName = b projectName ifTrue: [ a projectSpec isBaselineOfProjectSpec ifTrue: [ ex useLoaded ] ifFalse: [ ex useIncoming ] ] ifFalse: [ ex resume ] ];
        load: #('default' 'seaside').
]

{ #category : #installationOfConflictLibraries }
ESUGSetUp class >> installDependencesWithConflicts [
	self installMagritte.
	self installMDLForMagritte.
	self installArtefact.
	
]

{ #category : #installationOfConflictLibraries }
ESUGSetUp class >> installMDLForMagritte [
	Metacello new 
		baseline: 'MaterialDesignLite'; 
		repository: 'github://Lin777/MaterialDesignLite:master/src';
		onConflict: [ :ex :a :b | a projectName = b projectName ifTrue: [ a projectSpec 		isBaselineOfProjectSpec ifTrue: [ ex useLoaded ] ifFalse: [ ex useIncoming ] ] ifFalse: [ ex resume ] ];
		load: 'all'
]

{ #category : #installationOfConflictLibraries }
ESUGSetUp class >> installMagritte [
	Metacello new
	baseline: 'Magritte';
		repository: 'github://magritte-metamodel/magritte:master/source';
		onConflict: [ :ex :a :b | a projectName = b projectName ifTrue: [ a projectSpec isBaselineOfProjectSpec ifTrue: [ ex useLoaded ] ifFalse: [ ex useIncoming ] ] ifFalse: [ ex resume ] ];
		load: #('Magritte-Seaside')
]

{ #category : #backupAndRestoreData }
ESUGSetUp class >> restoreData [
	[ ERBackupRestore uniqueInstance restoreBackup ]
	on: Exception 
	do: [ :ex | ex signal ]
]

{ #category : #setUps }
ESUGSetUp class >> start [
	"Initialize the application. If exist a backup, restore the latest version of database. If not exists a backup, initialize all data required"

	self startAndCleanSeaside.
	self cleanDatabase.
	self existBackupToRestart 
		ifTrue: [ self restoreData ]	
		ifFalse: [ self initializeDataFromScratch ].
	EREsugApp initialize
]

{ #category : #setUps }
ESUGSetUp class >> startAndCleanSeaside [

	| application |
	ZnZincServerAdaptor startOn: 8000.

	"Clear Seaside registered App"
	WAAdmin clearAll.
	WAAdmin applicationDefaults
		removeParent: WADevelopmentConfiguration instance.
	WAFileHandler default: WAFileHandler new.
	WAFileHandler default
		preferenceAt: #fileHandlerListingClass
		put: WAHtmlFileHandlerListing;
		preferenceAt: #scriptGeneratorClass 
		put: JQScriptGenerator.
	WAAdmin defaultDispatcher
		register: WAFileHandler default
		at: 'files'.
	application := WAAdmin register: WADispatcherBrowser asApplicationAt: 'browse'.
	application	addLibrary: JQUiDeploymentLibrary.

	WAConfigurationTool initialize
]

{ #category : #setUps }
ESUGSetUp class >> stop [
	"STOP and Clean (incomplete)"
	ZnZincServerAdaptor stop.
]

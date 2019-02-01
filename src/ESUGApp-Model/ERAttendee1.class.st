Class {
	#name : #ERAttendee1,
	#superclass : #SDActiveRecord,
	#instVars : [
		'userAccount',
		'contactInformation',
		'conferenceInformation',
		'affiliationInformation',
		'additionalInformation',
		'paymentInformation'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #'as yet unclassified' }
ERAttendee1 class >> countries [
	^ #('United States' 'United Kingdom' 'Afghanistan' 'Albania' 'Algeria' 'American Samoa' 'Andorra' 'Angola' 'Anguilla' 'Antarctica' 'Antigua and Barbuda' 'Argentina' 'Armenia' 'Aruba' 'Australia' 'Austria' 'Azerbaijan' 'Bahamas' 'Bahrain' 'Bangladesh' 'Barbados' 'Belarus' 'Belgium' 'Belize' 'Benin' 'Bermuda' 'Bhutan' 'Bolivia' 'Bosnia and Herzegovina' 'Botswana' 'Bouvet Island' 'Brazil' 'British Indian Ocean Territory' 'Brunei Darussalam' 'Bulgaria' 'Burkina Faso' 'Burundi' 'Cambodia' 'Cameroon' 'Canada' 'Cape Verde' 'Cayman Islands' 'Central African Republic' 'Chad' 'Chile' 'China' 'Christmas Island' 'Cocos (Keeling) Islands' 'Colombia' 'Comoros' 'Congo' 'Congo, The Democratic Republic of The' 'Cook Islands' 'Costa Rica' 'Cote D'' ivoire' 'Croatia' 'Cuba' 'Cyprus' 'Czech Republic' 'Denmark' 'Djibouti' 'Dominica' 'Dominican Republic' 'Ecuador' 'Egypt' 'El Salvador' 'Equatorial Guinea' 'Eritrea' 'Estonia' 'Ethiopia' 'Falkland Islands Malvinas' 'Faroe Islands' 'Fiji' 'Finland' 'France' 'French Guiana' 'French Polynesia' 'French Southern Territories' 'Gabon' 'Gambia' 'Georgia' 'Germany' 'Ghana' 'Gibraltar' 'Greece' 'Greenland' 'Grenada' 'Guadeloupe' 'Guam' 'Guatemala' 'Guinea' 'Guinea - bissau' 'Guyana' 'Haiti' 'Heard Island and Mcdonald Islands' 'Holy See Vatican City State' 'Honduras' 'Hong Kong' 'Hungary' 'Iceland' 'India' 'Indonesia' 'Iran , Islamic Republic of' 'Iraq' 'Ireland' 'Israel' 'Italy' 'Jamaica' 'Japan' 'Jordan' 'Kazakhstan' 'Kenya' 'Kiribati' 'Korea , Democratic People ''s Republic of' 'Korea, Republic of' 'Kuwait' 'Kyrgyzstan' 'Lao People''s Democratic Republic' 'Latvia' ' Lebanon' 'Lesotho' 'Liberia' 'Libyan Arab Jamahiriya' 'Liechtenstein' 'Lithuania' 'Luxembourg' 'Macao' 'Macedonia , The Former Yugoslav Republic of' 'Madagascar' ' Malawi ' ' Malaysia ' ' Maldives ' ' Mali ' ' Malta ' ' Marshall Islands ' ' Martinique ' ' Mauritania ' ' Mauritius ' ' Mayotte ' ' Mexico ' ' Micronesia , Federated States of ' ' Moldova , Republic of ' ' Monaco ' ' Mongolia ' ' Montserrat ' ' Morocco ' ' Mozambique ' ' Myanmar ' ' Namibia ' ' Nauru ' ' Nepal ' ' Netherlands ' ' Netherlands Antilles ' ' New Caledonia ' ' New Zealand ' ' Nicaragua ' ' Niger ' ' Nigeria ' ' Niue ' ' Norfolk Island ' ' Northern Mariana Islands ' ' Norway ' ' Oman ' ' Pakistan ' ' Palau ' ' Palestinian Territory , Occupied ' ' Panama ' ' Papua New Guinea ' ' Paraguay ' ' Peru ' ' Philippines ' ' Pitcairn ' ' Poland ' ' Portugal ' ' Puerto Rico ' ' Qatar ' ' Reunion ' ' Romania ' ' Russian Federation ' ' Rwanda ' ' Saint Helena ' ' Saint Kitts and Nevis ' ' Saint Lucia ' ' Saint Pierre and Miquelon ' ' Saint Vincent and The Grenadines ' ' Samoa ' ' San Marino ' ' Sao Tome and Principe ' ' Saudi Arabia ' ' Senegal ' ' Serbia and Montenegro ' ' Seychelles ' ' Sierra Leone ' ' Singapore ' ' Slovakia ' ' Slovenia ' ' Solomon Islands ' ' Somalia ' ' South Africa ' ' South Georgia and The South Sandwich Islands ' ' Spain ' ' Sri Lanka ' ' Sudan ' ' Suriname ' ' Svalbard and Jan Mayen ' ' Swaziland ' ' Sweden ' ' Switzerland ' ' Syrian Arab Republic ' ' Taiwan , Province of China ' ' Tajikistan ' ' Tanzania , United Republic of ' ' Thailand ' ' Timor - leste ' ' Togo ' ' Tokelau ' ' Tonga ' ' Trinidad and Tobago ' ' Tunisia ' ' Turkey ' ' Turkmenistan ' ' Turks and Caicos Islands ' ' Tuvalu ' ' Uganda ' ' Ukraine ' ' United Arab Emirates ' ' United Kingdom ' ' United States ' ' United States Minor Outlying Islands ' ' Uruguay ' ' Uzbekistan ' ' Vanuatu ' ' Venezuela ' ' Viet Nam ' ' Virgin Islands , British ' ' Virgin Islands , U.S.' ' Wallis and Futuna ' ' Western Sahara ' ' Yemen ' ' Zambia ' ' Zimbabwe ')
]

{ #category : #'as yet unclassified' }
ERAttendee1 class >> currencyTypes [
	^ #('Euro')
]

{ #category : #accessing }
ERAttendee1 class >> days [
	^ #('monday' 'tuesday' 'wednesday' 'thursday' 'friday')
]

{ #category : #'as yet unclassified' }
ERAttendee1 class >> foodPreferences [
	^ #('Normal' 'Vegan' 'Vegetarian')
]

{ #category : #accessing }
ERAttendee1 class >> genders [
	^ #('Male' 'Female')
]

{ #category : #'as yet unclassified' }
ERAttendee1 class >> membershipTypes [
	^ #('Industrial' 'Other' 'Professor / Reseacher' 'Student')
]

{ #category : #'as yet unclassified' }
ERAttendee1 class >> paymentTypes [
	^ #('Bank transfer' 'Credit Card')
]

{ #category : #'as yet unclassified' }
ERAttendee1 class >> roles [
	^ #('admin' 'attendee' 'groupManager' 'studentVolunter')
]

{ #category : #'as yet unclassified' }
ERAttendee1 class >> rolesForAdminRegister [
	^ #('admin' 'studentVolunter')
]

{ #category : #'as yet unclassified' }
ERAttendee1 class >> tShirtSizes [
	^ #('XS' 'S' 'M' 'L' 'XL' 'XXL' 'XXXL' 'XXXXL')
]

{ #category : #accessing }
ERAttendee1 >> additionalInformation [
	^ additionalInformation
]

{ #category : #accessing }
ERAttendee1 >> additionalInformation: anObject [
	additionalInformation := anObject
]

{ #category : #accessing }
ERAttendee1 >> affiliationInformation [
	^ affiliationInformation
]

{ #category : #accessing }
ERAttendee1 >> affiliationInformation: anObject [
	affiliationInformation := anObject
]

{ #category : #accessing }
ERAttendee1 >> conferenceInformation [
	^ conferenceInformation
]

{ #category : #accessing }
ERAttendee1 >> conferenceInformation: anObject [
	conferenceInformation := anObject
]

{ #category : #accessing }
ERAttendee1 >> contactInformation [
	^ contactInformation
]

{ #category : #accessing }
ERAttendee1 >> contactInformation: anObject [
	contactInformation := anObject
]

{ #category : #accessing }
ERAttendee1 >> descriptionAdd [
	<magritteDescription>
	| tmp1 |
	tmp1 := MAClassDescription new .
	tmp1
		accessor: #additionalInformation ;
		label: 'add';
		priority: 100;
		required: true.
	^ tmp1 yourself
]

{ #category : #accessing }
ERAttendee1 >> descriptionUser [
	<magritteDescription>
	| tmp1 |
	tmp1 := MAClassDescription new .
	tmp1
		accessor: #userAccount;
		label: 'user';
		priority: 10;
		required: true.
	^ tmp1 yourself
]

{ #category : #testing }
ERAttendee1 >> hasCoupon [
	self paymentInformation coupon isNil 
	ifFalse: [ self paymentInformation coupon isEmpty 
		ifTrue:[^ false ]]
	ifTrue: [ ^ false ].
	^ true
]

{ #category : #'initialize-release' }
ERAttendee1 >> initialize [ 
	super initialize .
	userAccount := ERUserAccount1 new.
	contactInformation := ERContactInformation new.
	conferenceInformation := ERRegisterConferenceInformation new.
	affiliationInformation := ERAffiliationInformation new.
	additionalInformation := ERAdditionalInformation new.
	paymentInformation := ERPaymentInformation new.
]

{ #category : #accessing }
ERAttendee1 >> paymentInformation [
	^ paymentInformation
]

{ #category : #accessing }
ERAttendee1 >> paymentInformation: anObject [
	paymentInformation := anObject
]

{ #category : #accessing }
ERAttendee1 >> userAccount [
	^ userAccount
]

{ #category : #accessing }
ERAttendee1 >> userAccount: anObject [
	userAccount := anObject
]

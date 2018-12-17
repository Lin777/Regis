"
I am a registered conference assistant 
"
Class {
	#name : #ERAttendee,
	#superclass : #SDActiveRecord,
	#instVars : [
		'userAccount',
		'orgName',
		'orgAddrees1',
		'orgAddrees2',
		'orgCity',
		'orgCountry',
		'orgProvince',
		'orgPostal',
		'membershipType',
		'keywords',
		'additionalText',
		'address',
		'address2',
		'city',
		'country',
		'province',
		'postal',
		'facebookURL',
		'twitterURL',
		'homePage',
		'foodPreference',
		'attendSocialEvent',
		'addedToMainList',
		'tshirtSize',
		'attendance',
		'gender',
		'paymentType',
		'paymentCurrency',
		'coupon'
	],
	#category : #'ESUGApp-Models'
}

{ #category : #'as yet unclassified' }
ERAttendee class >> countries [
	  ^ #('Select Country' 'United States' 'United Kingdom' 'Afghanistan' 'Albania' 'Algeria' 'American Samoa' 'Andorra' 'Angola' 'Anguilla'
'Antarctica' 'Antigua and Barbuda' 'Argentina' 'Armenia' 'Aruba' 'Australia' 'Austria' 'Azerbaijan' 'Bahamas' 'Bahrain' 'Bangladesh'
'Barbados' 'Belarus' 'Belgium' 'Belize' 'Benin' 'Bermuda' 'Bhutan' 'Bolivia' 'Bosnia and Herzegovina' 'Botswana' 'Bouvet Island'
'Brazil' 'British Indian Ocean Territory' 'Brunei Darussalam' 'Bulgaria' 'Burkina Faso' 'Burundi' 'Cambodia' 'Cameroon' 'Canada' 
'Cape Verde' 'Cayman Islands' 'Central African Republic' 'Chad' 'Chile' 'China' 'Christmas Island' 'Cocos (Keeling) Islands' 'Colombia'
'Comoros' 'Congo' 'Congo, The Democratic Republic of The' 'Cook Islands' 'Costa Rica' 'Cote D'ivoire' 'Croatia' 'Cuba' 'Cyprus' 
'Czech Republic' 'Denmark' 'Djibouti' 'Dominica' 'Dominican Republic' 'Ecuador' 'Egypt' 'El Salvador' 'Equatorial Guinea' 'Eritrea'
'Estonia' 'Ethiopia' 'Falkland Islands (Malvinas)' 'Faroe Islands' 'Fiji' 'Finland' 'France' 'French Guiana' 'French Polynesia'
'French Southern Territories' 'Gabon' 'Gambia' 'Georgia' 'Germany' 'Ghana' 'Gibraltar' 'Greece' 'Greenland' 'Grenada' 'Guadeloupe' 'Guam'
'Guatemala' 'Guinea' 'Guinea-bissau' 'Guyana' 'Haiti' 'Heard Island and Mcdonald Islands' 'Holy See (Vatican City State)' 'Honduras' 
'Hong Kong' 'Hungary' 'Iceland' 'India' 'Indonesia' 'Iran, Islamic Republic of' 'Iraq' 'Ireland' 'Israel' 'Italy' 'Jamaica' 'Japan'
'Jordan' 'Kazakhstan' 'Kenya' 'Kiribati' 'Korea, Democratic People's Republic of' 'Korea, Republic of' 'Kuwait' 'Kyrgyzstan'
'Lao People's Democratic Republic' 'Latvia' 'Lebanon' 'Lesotho' 'Liberia' 'Libyan Arab Jamahiriya' 'Liechtenstein' 'Lithuania' 'Luxembourg'
'Macao' 'Macedonia, The Former Yugoslav Republic of' 'Madagascar' 'Malawi' 'Malaysia' 'Maldives' 'Mali' 'Malta' 'Marshall Islands' 
'Martinique' 'Mauritania' 'Mauritius' 'Mayotte' 'Mexico' 'Micronesia, Federated States of' 'Moldova, Republic of' 'Monaco' 'Mongolia' 'Montserrat'
'Morocco' 'Mozambique' 'Myanmar' 'Namibia' 'Nauru' 'Nepal' 'Netherlands' 'Netherlands Antilles' 'New Caledonia' 'New Zealand' 'Nicaragua'
'Niger' 'Nigeria' 'Niue' 'Norfolk Island' 'Northern Mariana Islands' 'Norway' 'Oman' 'Pakistan' 'Palau' 'Palestinian Territory, Occupied'
'Panama' 'Papua New Guinea' 'Paraguay' 'Peru' 'Philippines' 'Pitcairn' 'Poland' 'Portugal' 'Puerto Rico' 'Qatar' 'Reunion' 'Romania'
'Russian Federation' 'Rwanda' 'Saint Helena' 'Saint Kitts and Nevis' 'Saint Lucia' 'Saint Pierre and Miquelon' 
'Saint Vincent and The Grenadines' 'Samoa' 'San Marino' 'Sao Tome and Principe' 'Saudi Arabia' 'Senegal' 'Serbia and Montenegro' 
'Seychelles' 'Sierra Leone' 'Singapore' 'Slovakia' 'Slovenia' 'Solomon Islands' 'Somalia' 'South Africa' 
'South Georgia and The South Sandwich Islands' 'Spain' 'Sri Lanka' 'Sudan' 'Suriname' 'Svalbard and Jan Mayen' 'Swaziland' 'Sweden'
'Switzerland' 'Syrian Arab Republic' 'Taiwan, Province of China' 'Tajikistan' 'Tanzania, United Republic of' 'Thailand' 'Timor-leste' 'Togo'
'Tokelau' 'Tonga' 'Trinidad and Tobago' 'Tunisia' 'Turkey' 'Turkmenistan' 'Turks and Caicos Islands' 'Tuvalu' 'Uganda' 'Ukraine' 
'United Arab Emirates' 'United Kingdom' 'United States' 'United States Minor Outlying Islands' 'Uruguay' 'Uzbekistan' 'Vanuatu'
'Venezuela' 'Viet Nam' 'Virgin Islands, British' 'Virgin Islands, 'U.S.' 'Wallis and Futuna' 'Western Sahara' 'Yemen' 'Zambia' 'Zimbabwe')
]

{ #category : #'as yet unclassified' }
ERAttendee class >> currencyTypes [
	^ #('Euro' 'Dollar')
]

{ #category : #'as yet unclassified' }
ERAttendee class >> foodPreferences [
	^ #('Vegan' 'Vegetarian' 'Normal')
]

{ #category : #'as yet unclassified' }
ERAttendee class >> genders [
	^ #('Male' 'Female')
]

{ #category : #'as yet unclassified' }
ERAttendee class >> membershipTypes [
	^ #('Industrial' 'Other' 'Professor / Reseacher' 'Student')
]

{ #category : #'as yet unclassified' }
ERAttendee class >> paymentTypes [
	^ #('Bank transfer' 'Credit Card')
]

{ #category : #'as yet unclassified' }
ERAttendee class >> tShirtSizes [
	^ #('XS' 'S' 'M' 'L' 'XL' 'XXL' 'XXXL' 'XXXXL')
]

{ #category : #accessing }
ERAttendee >> addedToMainList [
	^ addedToMainList
]

{ #category : #accessing }
ERAttendee >> addedToMainList: anObject [
	addedToMainList := anObject
]

{ #category : #accessing }
ERAttendee >> additionalText [
	^ additionalText
]

{ #category : #accessing }
ERAttendee >> additionalText: anObject [
	additionalText := anObject
]

{ #category : #accessing }
ERAttendee >> address [
	^ address
]

{ #category : #accessing }
ERAttendee >> address2 [
	^ address2
]

{ #category : #accessing }
ERAttendee >> address2: anObject [
	address2 := anObject
]

{ #category : #accessing }
ERAttendee >> address: anObject [
	address := anObject
]

{ #category : #accessing }
ERAttendee >> attendSocialEvent [
	^ attendSocialEvent
]

{ #category : #accessing }
ERAttendee >> attendSocialEvent: anObject [
	attendSocialEvent := anObject
]

{ #category : #accessing }
ERAttendee >> attendance [
	^ attendance
]

{ #category : #accessing }
ERAttendee >> attendance: anObject [
	attendance := anObject
]

{ #category : #accessing }
ERAttendee >> city [
	^ city
]

{ #category : #accessing }
ERAttendee >> city: anObject [
	city := anObject
]

{ #category : #'as yet unclassified' }
ERAttendee >> confirmPassword: aString [
	"self password = ERUserAccount hashPassword: aString"
]

{ #category : #accessing }
ERAttendee >> country [
	^ country
]

{ #category : #accessing }
ERAttendee >> country: anObject [
	country := anObject
]

{ #category : #accessing }
ERAttendee >> coupon [
	^ coupon
]

{ #category : #accessing }
ERAttendee >> coupon: anObject [
	coupon := anObject
]

{ #category : #accessing }
ERAttendee >> email [
	^ self userAccount email.
]

{ #category : #accessing }
ERAttendee >> email: anString [
	self userAccount email: anString.
]

{ #category : #accessing }
ERAttendee >> facebookURL [
	^ facebookURL
]

{ #category : #accessing }
ERAttendee >> facebookURL: anObject [
	facebookURL := anObject
]

{ #category : #accessing }
ERAttendee >> firstName [
	^ userAccount firstName
]

{ #category : #accessing }
ERAttendee >> firstName: anObject [
	userAccount firstName: anObject
]

{ #category : #accessing }
ERAttendee >> foodPreference [
	^ foodPreference
]

{ #category : #accessing }
ERAttendee >> foodPreference: anObject [
	foodPreference := anObject
]

{ #category : #initialization }
ERAttendee >> friday: aBoolean [
	self attendance at: #friday put: aBoolean 
]

{ #category : #accessing }
ERAttendee >> gender [
	^ gender
]

{ #category : #accessing }
ERAttendee >> gender: anObject [
	gender := anObject
]

{ #category : #accessing }
ERAttendee >> homePage [
	^ homePage
]

{ #category : #accessing }
ERAttendee >> homePage: anObject [
	homePage := anObject
]

{ #category : #initialization }
ERAttendee >> initialize [
	super initialize.
	userAccount := ERUserAccount new.
	self attendance: (Dictionary newFrom: {'monday'->true . 'tuesday' -> true . 'wednesday' -> true . 'thursday' -> true . 'friday' -> true})
]

{ #category : #accessing }
ERAttendee >> keywords [
	^ keywords
]

{ #category : #accessing }
ERAttendee >> keywords: anObject [
	keywords := anObject
]

{ #category : #accessing }
ERAttendee >> lastName [
	^ userAccount lastName
]

{ #category : #accessing }
ERAttendee >> lastName: anObject [
	userAccount lastName: anObject
]

{ #category : #accessing }
ERAttendee >> membershipType [
	^ membershipType
]

{ #category : #accessing }
ERAttendee >> membershipType: anObject [
	membershipType := anObject
]

{ #category : #initialization }
ERAttendee >> monday: aBoolean [
	self attendance at: #monday put: aBoolean 
]

{ #category : #accessing }
ERAttendee >> orgAddrees1 [
	^ orgAddrees1
]

{ #category : #accessing }
ERAttendee >> orgAddrees1: anObject [
	orgAddrees1 := anObject
]

{ #category : #accessing }
ERAttendee >> orgAddrees2 [
	^ orgAddrees2
]

{ #category : #accessing }
ERAttendee >> orgAddrees2: anObject [
	orgAddrees2 := anObject
]

{ #category : #accessing }
ERAttendee >> orgCity [
	^ orgCity
]

{ #category : #accessing }
ERAttendee >> orgCity: anObject [
	orgCity := anObject
]

{ #category : #accessing }
ERAttendee >> orgCountry [
	^ orgCountry
]

{ #category : #accessing }
ERAttendee >> orgCountry: anObject [
	orgCountry := anObject
]

{ #category : #accessing }
ERAttendee >> orgName [
	^ orgName
]

{ #category : #accessing }
ERAttendee >> orgName: anObject [
	orgName := anObject
]

{ #category : #accessing }
ERAttendee >> orgPostal [
	^ orgPostal
]

{ #category : #accessing }
ERAttendee >> orgPostal: anObject [
	orgPostal := anObject
]

{ #category : #accessing }
ERAttendee >> orgProvince [
	^ orgProvince
]

{ #category : #accessing }
ERAttendee >> orgProvince: anObject [
	orgProvince := anObject
]

{ #category : #accessing }
ERAttendee >> password [
	^ userAccount password
]

{ #category : #accessing }
ERAttendee >> password: anObject [
	userAccount password: anObject
]

{ #category : #accessing }
ERAttendee >> paymentCurrency [
	^ paymentCurrency
]

{ #category : #accessing }
ERAttendee >> paymentCurrency: anObject [
	paymentCurrency := anObject
]

{ #category : #accessing }
ERAttendee >> paymentType [
	^ paymentType
]

{ #category : #accessing }
ERAttendee >> paymentType: anObject [
	paymentType := anObject
]

{ #category : #accessing }
ERAttendee >> postal [
	^ postal
]

{ #category : #accessing }
ERAttendee >> postal: anObject [
	postal := anObject
]

{ #category : #accessing }
ERAttendee >> province [
	^ province
]

{ #category : #accessing }
ERAttendee >> province: anObject [
	province := anObject
]

{ #category : #initialization }
ERAttendee >> thursday: aBoolean [
	self attendance at: #thursday put: aBoolean 
]

{ #category : #accessing }
ERAttendee >> tshirtSize [
	^ tshirtSize
]

{ #category : #accessing }
ERAttendee >> tshirtSize: anObject [
	tshirtSize := anObject
]

{ #category : #initialization }
ERAttendee >> tuesday: aBoolean [
	self attendance at: #tuesday put: aBoolean 
]

{ #category : #accessing }
ERAttendee >> twitterURL [
	^ twitterURL
]

{ #category : #accessing }
ERAttendee >> twitterURL: anObject [
	twitterURL := anObject
]

{ #category : #accessing }
ERAttendee >> userAccount [
	^ userAccount.
]

{ #category : #accessing }
ERAttendee >> userAccount: aUserAccount [
	userAccount := aUserAccount.
]

{ #category : #initialization }
ERAttendee >> wednesday: aBoolean [
	self attendance at: #wednesday put: aBoolean 
]

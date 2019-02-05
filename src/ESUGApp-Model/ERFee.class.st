Class {
	#name : #ERFee,
	#superclass : #SDActiveRecord,
	#instVars : [
		'currency',
		'erfAllDaysFee',
		'erfOneDayFee',
		'lrfAllDaysFee',
		'lrfOneDayFee',
		'bankAccountInformation',
		'bankPayPalUrl',
		'extraPersonSD'
	],
	#category : #'ESUGApp-Model'
}

{ #category : #accessing }
ERFee >> bankAccountInformation [
	^ bankAccountInformation
]

{ #category : #accessing }
ERFee >> bankAccountInformation: anObject [
	bankAccountInformation := anObject
]

{ #category : #accessing }
ERFee >> bankPayPalUrl [
	^ bankPayPalUrl
]

{ #category : #accessing }
ERFee >> bankPayPalUrl: anObject [
	bankPayPalUrl := anObject
]

{ #category : #accessing }
ERFee >> currency [
	^ currency
]

{ #category : #accessing }
ERFee >> currency: anObject [
	currency := anObject
]

{ #category : #accessing }
ERFee >> descriptionBankPayPalUrl [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #bankPayPalUrl; 
		priority: 70;
		beRequired;
		label: 'Pay Pal URL (Required)';
		withoutLabel: true;
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERFee >> descriptionErfAllDaysFee [
	<magritteDescription>
	| tmp |
	tmp := MANumberDescription new.
	tmp 
		accessor: #erfAllDaysFee; 
		priority: 30;
		beRequired;
		group: 'Early Registration Fee:';
		label: 'All Days Fee (Required)';
		withoutLabel: true;
		cssClass: 'half';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERFee >> descriptionErfOneDayFee [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #erfOneDayFee; 
		priority: 40;
		beRequired;
		label: 'One Day Fee (Required)';
		withoutLabel: true;
		cssClass: 'half';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERFee >> descriptionExtraPersonSD [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #extraPersonSD; 
		priority: 20;
		beRequired;
		label: 'Price for add person to the Social Dinner (Required)';
		withoutLabel: true;
		cssClass: 'half';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERFee >> descriptionLrfAllDaysFee [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #lrfAllDaysFee; 
		priority: 50;
		beRequired;
		group: 'Late Registration Fee:';
		label: 'All Days Fee (Required)';
		withoutLabel: true;
		cssClass: 'half';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERFee >> descriptionLrfOneDayFee [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #lrfOneDayFee; 
		priority: 60;
		beRequired;
		label: 'One Day Fee (Required)';
		withoutLabel: true;
		cssClass: 'half';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERFee >> descriptionPaymentCurrency [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #currency;
		priority: 10;
		beRequired;
		options: ERAttendee currencyTypes;
		cssClass: 'half';
		withoutLabel: true;
		componentClass: MDLMASelectListComponent .
	^ tmp1 yourself
]

{ #category : #accessing }
ERFee >> erfAllDaysFee [
	^ erfAllDaysFee
]

{ #category : #accessing }
ERFee >> erfAllDaysFee: anObject [
	erfAllDaysFee := anObject
]

{ #category : #accessing }
ERFee >> erfOneDayFee [
	^ erfOneDayFee
]

{ #category : #accessing }
ERFee >> erfOneDayFee: anObject [
	erfOneDayFee := anObject
]

{ #category : #accessing }
ERFee >> extraPersonSD [
	^ extraPersonSD
]

{ #category : #accessing }
ERFee >> extraPersonSD: anObject [
	extraPersonSD := anObject
]

{ #category : #initialization }
ERFee >> initialize [
	super initialize.
	bankAccountInformation := ERBankAccountInformation new.
	
]

{ #category : #accessing }
ERFee >> lrfAllDaysFee [
	^ lrfAllDaysFee
]

{ #category : #accessing }
ERFee >> lrfAllDaysFee: anObject [
	lrfAllDaysFee := anObject
]

{ #category : #accessing }
ERFee >> lrfOneDayFee [
	^ lrfOneDayFee
]

{ #category : #accessing }
ERFee >> lrfOneDayFee: anObject [
	lrfOneDayFee := anObject
]

{ #category : #'as yet unclassified' }
ERFee >> payPalAmountToken [
	^ '[AMOUNT]'
]

{ #category : #'as yet unclassified' }
ERFee >> payPalInvoiceNumberToken [
	
	^ '[INVOICENUMBER]'
]

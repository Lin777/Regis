Class {
	#name : #ERRegisterConferenceInformation,
	#superclass : #Object,
	#instVars : [
		'attendance',
		'gender',
		'tshirtSize',
		'foodPreference',
		'attendSocialEvent',
		'addedToMainList',
		'addPersonToSocialDinner',
		'personAddedFoodPreference'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #accessing }
ERRegisterConferenceInformation >> addPersonToSocialDinner [
	^ addPersonToSocialDinner
]

{ #category : #accessing }
ERRegisterConferenceInformation >> addPersonToSocialDinner: anObject [
	addPersonToSocialDinner := anObject
]

{ #category : #accessing }
ERRegisterConferenceInformation >> addedToMainList [
	^ addedToMainList
]

{ #category : #accessing }
ERRegisterConferenceInformation >> addedToMainList: anObject [
	addedToMainList := anObject
]

{ #category : #accessing }
ERRegisterConferenceInformation >> attendSocialEvent [
	^ attendSocialEvent
]

{ #category : #accessing }
ERRegisterConferenceInformation >> attendSocialEvent: anObject [
	attendSocialEvent := anObject
]

{ #category : #accessing }
ERRegisterConferenceInformation >> attendance [
	^ attendance
]

{ #category : #accessing }
ERRegisterConferenceInformation >> attendance: anObject [
	attendance := anObject
]

{ #category : #'as yet unclassified' }
ERRegisterConferenceInformation >> daysOfAssistance [
	| aString |
	aString := ''.
	#(#monday #tuesday #wednesday #thursday #friday)
		do: [ :each | 
			(self perform: each)
				ifTrue: [ aString isEmpty
						ifTrue: [ aString := each asString capitalized ]
						ifFalse: [ aString :=  aString , ', ' , each asString capitalized ] ] ].
	^ aString
]

{ #category : #'as yet unclassified' }
ERRegisterConferenceInformation >> descriptionAddPersonToSocialDinner [
	<magritteDescription>
	| tmp2 |
	tmp2 := MABooleanDescription new.
	tmp2 
		checkboxLabel: 'Check if you add a person to the Social Dinner';
		accessor: #addPersonToSocialDinner;
		beRequired ;
		componentClass: MDLMACheckboxComponent;
		priority: 120;
		withoutLabel: true.
	^ tmp2 yourself
]

{ #category : #'as yet unclassified' }
ERRegisterConferenceInformation >> descriptionAddedToMainList [
	<magritteDescription>
	| tmp2 |
	tmp2 := MABooleanDescription new.
	tmp2 
		checkboxLabel: 'Check if you want to be added to the Mailling List';
		accessor: #addedToMainList;
		beRequired;
		componentClass: MDLMACheckboxComponent;
		priority: 110;
		withoutLabel: true.
	^ tmp2 yourself
]

{ #category : #'as yet unclassified' }
ERRegisterConferenceInformation >> descriptionAttendSocialEvent [
	<magritteDescription>
	| tmp2 |
	tmp2 := MABooleanDescription new.
	tmp2 
		checkboxLabel: 'Check if you will you go to the social Event';
		accessor: #attendSocialEvent;
		beRequired ;
		componentClass: MDLMACheckboxComponent;
		priority: 100;
		withoutLabel: true.
	^ tmp2 yourself
]

{ #category : #'as yet unclassified' }
ERRegisterConferenceInformation >> descriptionFood [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #foodPreference;
		priority: 80;
		required: false;
		cssClass: 'third';
		options: ERAttendee foodPreferences;
		withoutLabel: true;
		componentClass: MDLMASelectListComponent .
	^ tmp1 yourself
]

{ #category : #'as yet unclassified' }
ERRegisterConferenceInformation >> descriptionFoodPreferenceOfExtraPerson [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #personAddedFoodPreference;
		priority: 130;
		required: false;
		default: 'Normal';
		options: ERAttendee foodPreferences;
		withoutLabel: true;
		componentClass: MDLMASelectListComponent .
	^ tmp1 yourself
]

{ #category : #'as yet unclassified' }
ERRegisterConferenceInformation >> descriptionFriday [
	<magritteDescription>
	| tmp2 |
	tmp2 := MABooleanDescription new.
	tmp2 
		checkboxLabel: 'Friday';
		accessor: #friday;
		componentClass: MDLMACheckboxComponent;
		priority: 50;
		withoutLabel: true.
	^ tmp2 yourself
]

{ #category : #'as yet unclassified' }
ERRegisterConferenceInformation >> descriptionGender [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #gender;
		priority: 60;
		required: false;
		cssClass: 'third';
		options: ERAttendee genders;
		withoutLabel: true;
		componentClass: MDLMASelectListComponent .
	^ tmp1 yourself
]

{ #category : #'as yet unclassified' }
ERRegisterConferenceInformation >> descriptionMonday [
	<magritteDescription>
	| tmp2 |
	tmp2 := MABooleanDescription new.
	tmp2 
		checkboxLabel: 'Monday';
		accessor: #monday;
		group: 'Days: ';
		componentClass: MDLMACheckboxComponent;
		priority: 10;
		withoutLabel: true.
	^ tmp2 yourself
]

{ #category : #'as yet unclassified' }
ERRegisterConferenceInformation >> descriptionThursday [
	<magritteDescription>
	| tmp2 |
	tmp2 := MABooleanDescription new.
	tmp2 
		checkboxLabel: 'Thursday';
		accessor: #thursday;
		componentClass: MDLMACheckboxComponent;
		priority: 40;
		withoutLabel: true.
	^ tmp2 yourself
]

{ #category : #'as yet unclassified' }
ERRegisterConferenceInformation >> descriptionTshirtSize [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #tshirtSize;
		priority: 70;
		required: false;
		cssClass: 'third';
		options: ERAttendee tShirtSizes;
		withoutLabel: true;
		componentClass: MDLMASelectListComponent .
	^ tmp1 yourself
]

{ #category : #'as yet unclassified' }
ERRegisterConferenceInformation >> descriptionTuesday [
	<magritteDescription>
	| tmp2 |
	tmp2 := MABooleanDescription new.
	tmp2 
		checkboxLabel: 'Tuesday';
		accessor: #tuesday;
		componentClass: MDLMACheckboxComponent;
		priority: 20;
		withoutLabel: true.
	^ tmp2 yourself
]

{ #category : #'as yet unclassified' }
ERRegisterConferenceInformation >> descriptionWednesday [
	<magritteDescription>
	| tmp2 |
	tmp2 := MABooleanDescription new.
	tmp2 
		checkboxLabel: 'Wednesday';
		accessor: #wednesday;
		componentClass: MDLMACheckboxComponent;
		priority: 30;
		withoutLabel: true.
	^ tmp2 yourself
]

{ #category : #accessing }
ERRegisterConferenceInformation >> foodPreference [
	^ foodPreference
]

{ #category : #accessing }
ERRegisterConferenceInformation >> foodPreference: anObject [
	foodPreference := anObject
]

{ #category : #initialization }
ERRegisterConferenceInformation >> friday [
	^ self attendance at: 'friday'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> friday: aBoolean [
	self attendance at: 'friday' put: aBoolean
]

{ #category : #accessing }
ERRegisterConferenceInformation >> gender [
	^ gender
]

{ #category : #accessing }
ERRegisterConferenceInformation >> gender: anObject [
	gender := anObject
]

{ #category : #initialization }
ERRegisterConferenceInformation >> initialize [
	super initialize.
	foodPreference :=  'Normal'.
	gender :='Male'.
	tshirtSize :='XS'.
	self attendSocialEvent: true.
	self addedToMainList: true.
	self addPersonToSocialDinner: false.
	self gender: 'Male'.
	self
		attendance:
			(Dictionary
				newFrom:
					{('monday' -> true).
					('tuesday' -> true).
					('wednesday' -> true).
					('thursday' -> true).
					('friday' -> true)})
]

{ #category : #initialization }
ERRegisterConferenceInformation >> isFemale [
	^ gender = 'Female'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> isMale [
	^ gender = 'Male'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> isNormal [
	^ foodPreference ='Normal' 
]

{ #category : #initialization }
ERRegisterConferenceInformation >> isNormal: aString [
	^ aString ='Normal' 
]

{ #category : #initialization }
ERRegisterConferenceInformation >> isVegan [
	^ foodPreference = 'Vegan'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> isVegan: aString [
	^ aString = 'Vegan'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> isVegetarian [
	^ foodPreference =  'Vegetarian'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> isVegetarian: aString [
	^ aString =  'Vegetarian'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> monday [
	^ self attendance at: 'monday'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> monday: aBoolean [
	self attendance at: 'monday' put: aBoolean
]

{ #category : #accessing }
ERRegisterConferenceInformation >> personAddedFoodPreference [
	^ personAddedFoodPreference
]

{ #category : #accessing }
ERRegisterConferenceInformation >> personAddedFoodPreference: anObject [
	personAddedFoodPreference := anObject
]

{ #category : #initialization }
ERRegisterConferenceInformation >> thursday [
	^ self attendance at: 'thursday'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> thursday: aBoolean [
	self attendance at: 'thursday' put: aBoolean
]

{ #category : #accessing }
ERRegisterConferenceInformation >> tshirtSize [
	^ tshirtSize
]

{ #category : #accessing }
ERRegisterConferenceInformation >> tshirtSize: anObject [
	tshirtSize := anObject
]

{ #category : #initialization }
ERRegisterConferenceInformation >> tuesday [
	^ self attendance at: 'tuesday'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> tuesday: aBoolean [
	self attendance at: 'tuesday' put: aBoolean
]

{ #category : #initialization }
ERRegisterConferenceInformation >> wednesday [
	^ self attendance at: 'wednesday'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> wednesday: aBoolean [
	self attendance at: 'wednesday' put: aBoolean
]

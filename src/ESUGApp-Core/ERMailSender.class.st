Class {
	#name : #ERMailSender,
	#superclass : #Object,
	#category : #'ESUGApp-Core'
}

{ #category : #rendering }
ERMailSender >> senderEmailAddress [
	^ ERController uniqueInstance senderEmailAddress
]

{ #category : #rendering }
ERMailSender >> subjectDescription [
	self subclassResponsibility 
]

{ #category : #rendering }
ERMailSender >> textBody [
	self subclassResponsibility 
]

{ #category : #rendering }
ERMailSender >> titleBody [
	self subclassResponsibility 
]

{ #category : #rendering }
ERMailSender >> toEmailString [
	self subclassResponsibility 
]

{ #category : #rendering }
ERMailSender >> value [ 	
	^ PMEmail new
		from: self senderEmailAddress ;
		to: self toEmailString ;
		subject: self subjectDescription;
		htmlBody: self titleBody, self textBody;
		yourself 
]

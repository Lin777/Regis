Class {
	#name : #ERContainerApplyReductionTicket,
	#superclass : #ERGeneralContainerView,
	#category : #'ESUGApp-Components'
}

{ #category : #accessing }
ERContainerApplyReductionTicket >> renderPageOn: html [
	self createSelectField: 'Reduction Ticket Code: ' for: #coupon: with: #coupon list: nil to: attendee on: html
]

{ #category : #accessing }
ERContainerApplyReductionTicket >> title [
	^ 'Apply Reduction Ticket'
]

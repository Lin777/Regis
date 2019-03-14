Class {
	#name : #ERTestAttendee,
	#superclass : #ERTestModel,
	#category : #'ESUGApp-Test-UnitTest'
}

{ #category : #tests }
ERTestAttendee >> testHasCoupon [
	|attendee|
	attendee := self class testAttendee.
	self deny: attendee hasCoupon.
	attendee paymentInformation coupon: ''.
	self deny: attendee hasCoupon.
	attendee paymentInformation coupon: self validCoupon .
	self assert: attendee hasCoupon 
]

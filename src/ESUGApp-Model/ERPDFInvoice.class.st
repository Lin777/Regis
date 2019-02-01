Class {
	#name : #ERPDFInvoice,
	#superclass : #Object,
	#category : #'ESUGApp-Model'
}

{ #category : #tool }
ERPDFInvoice class >> demoPath [
	^ 'pdf/'
]

{ #category : #tool }
ERPDFInvoice class >> streamNamed: aName [
	| file |
	file := (self demoPath , aName) asFileReference.
	file parent ensureCreateDirectory.
	file ensureDelete.
	self flag: #todo.	"The next expression is a hack to correct a Pharo 6/7 compatibility.
	We need a binary write stream to print on but the way to get one changed between Pharo 6 and 7. To improve the code we could add a Pharo^ compatibility package that would add #binaryWriteStream to Pharo 6, but I have not time for now, I just want to make demos work.
	"
	^ SystemVersion current major < 7
		ifTrue: [ file writeStream
				binary;
				yourself ]
		ifFalse: [ file binaryWriteStream ]
]

{ #category : #'as yet unclassified' }
ERPDFInvoice class >> templateRegistrationInvoice: user [
	<script>
	self new templateRegistrationInvoice: (self streamNamed: 'RegistrationInvoice.pdf') of: user.
	^ (self demoPath, 'RegistrationInvoice.pdf') asFileReference
]

{ #category : #adding }
ERPDFInvoice >> addBorder: pdfPage [
	pdfPage add: (self lineElementFrom: 20 mm @ 115 mm to: 190 mm @ 115 mm);
	add: (self lineElementFrom: 20 mm @ 121 mm to: 190 mm @ 121 mm);
	add: (self lineElementFrom: 20 mm @ 115 mm to: 20 mm @ 137 mm);
	add: (self lineElementFrom: 20 mm @ 137 mm to: 190 mm @ 137 mm);
	add: (self lineElementFrom: 190 mm @ 115 mm to: 190 mm @ 137 mm);
	add: (self lineElementFrom: 20 mm @ 142 mm to: 190 mm @ 142 mm);
	add: (self lineElementFrom: 20 mm @ 157 mm to: 190 mm @ 157 mm);
	add: (self lineElementFrom: 20 mm @ 142 mm to: 20 mm @ 157 mm);
	add: (self lineElementFrom: 190 mm @ 142 mm to: 190 mm @ 157 mm).
]

{ #category : #adding }
ERPDFInvoice >> addDateInvoice: aPage [
	| fontInvoice |
	fontInvoice := PDFTimesFont size: 25pt.
	fontInvoice bold: true.
	aPage add: (PDFFormattedTextElement new
		textColor: self colorTitle;
		font: fontInvoice;
		dimension: 190 mm @ 20 mm;
		from: 0 mm @ 35 mm;
		text: 'Invoice';
		alignment: PDFAlignment right);
	add: (PDFFormattedTextElement new
		font: self fontContent;
		dimension: 190 mm @ 20 mm;
		from: 0 mm @ 48 mm;
		text: 'January 17, 2019';
		alignment: PDFAlignment right).
]

{ #category : #accessing }
ERPDFInvoice >> addFooter: pdfPage [
	pdfPage add: (PDFTextElement new
		textColor: self colorTitle;
		font: self fontFooter;
		from: 20 mm @ 276 mm;
		text: 'ESUG');
	add: (PDFTextElement new
		textColor: self colorLink;
		font: self fontFooter;
		from: 20 mm @ 280 mm;
		text: 'http://www.esug.org');
	add: (PDFFormattedTextElement new
		textColor: self colorTitle;
		font: self fontFooter;
		dimension: 190 mm @ 3 mm;
		from: 0 mm @ 272 mm;
		text: 'Association Loi 1901 n W751167780 (not subjected to V.A.T.)';
		alignment: PDFAlignment right);
	add: (PDFFormattedTextElement new
		font: self fontFooter;
		textColor: self colorTitle;
		dimension: 190 mm @ 3 mm;
		from: 0 mm @ 276 mm;
		text: 'c/o Mr. Stéphane Ducasse - 1 rue Cesar Franck - 59800 Lille - France';
		alignment: PDFAlignment right).
]

{ #category : #adding }
ERPDFInvoice >> addHeader: aPage [
	self addInfoESUG: aPage.
	self addDateInvoice: aPage.
]

{ #category : #'as yet unclassified' }
ERPDFInvoice >> addInfoESUG: aPage [
	| fontHeader |
	fontHeader := PDFTimesFont size: 10pt.
	aPage add: (PDFTextElement new
		textColor: self colorTitle;
		font: fontHeader;
		from: 20 mm @ 45 mm;
		text: 'European Smalltalk User Group (ESUG)');
	add: (PDFTextElement new
		textColor: self colorTitle;
		font: fontHeader;
		from: 20 mm @ 49 mm;
		text: 'Association Loi 1901 n W751167780');
	add: (PDFTextElement new
		textColor: self colorTitle;
		font: fontHeader;
		from: 20 mm @ 53 mm;
		text: 'c/o Mr. Stéphane Ducasse');
	add: (PDFTextElement new
		textColor: self colorTitle;
		font: fontHeader;
		from: 20 mm @ 57 mm;
		text: '1 rue Cesar Franck');
	add: (PDFTextElement new
		textColor: self colorTitle;
		font: fontHeader;
		from: 20 mm @ 61 mm;
		text: '59800 Lille');
	add: (PDFTextElement new
		textColor: self colorTitle;
		font: fontHeader;
		from: 20 mm @ 65 mm;
		text: 'France');
	add: (PDFTextElement new
		textColor: self colorLink;
		font: fontHeader;
		from: 20 mm @ 69 mm;
		text: 'http://www.esug.org').
]

{ #category : #adding }
ERPDFInvoice >> addInfoInvoice: pdfPage of: user [
	pdfPage add: (PDFTextElement new
		textColor: self colorTitle;
		font: self fontContent;
		from: 20 mm @ 82 mm;
		text: 'Invoice No.');
	add: (PDFTextElement new
		font: self fontContent;
		from: 45 mm @ 82 mm;
		text: "user invoiceNumber" '2019-01-001');
	add: (PDFFormattedTextElement new
		textColor: self colorTitle;
		font: self fontContent;
		dimension: 160 mm @ 70 mm;
		from: 0 mm @ 78 mm;
		text: 'Bill to:';
		alignment: (PDFAlignment right));
	add: (PDFFormattedTextElement new
		font: self fontContent;
		dimension: 190 mm @ 70 mm;
		from: 0 mm @ 78 mm;
		text: "user name" 'Luc Fabresse';
		alignment: (PDFAlignment right));
	add: (PDFFormattedTextElement new
		font: self fontContent;
		dimension: 190 mm @ 75 mm;
		from: 0 mm @ 83 mm;
		text: 'IMT Lille Douai';
		alignment: (PDFAlignment right));
	add: (PDFFormattedTextElement new
		font: self fontContent;
		dimension: 190 mm @ 80 mm;
		from: 0 mm @ 88 mm;
		text: '911 rue charles bourseul';
		alignment: (PDFAlignment right));
	add: (PDFFormattedTextElement new
		font: self fontContent;
		dimension: 190 mm @ 85 mm;
		from: 0 mm @ 93 mm;
		text: '59500 Douai';
		alignment: (PDFAlignment right))
]

{ #category : #adding }
ERPDFInvoice >> addInfoPayment: pdfPage [
	pdfPage add: (PDFTextElement new
		textColor: self colorTitle;
		font: self fontBoldContent;
		from: 20 mm @ 178 mm;
		text: 'Pay by Credit Card or Paypal:');
	add: (PDFTextElement new
		font: self fontContent;
		from: 30 mm @ 183 mm;
		text: 'Pay to our Paypal account');
	add: (PDFTextElement new
		textColor: self colorLink;
		font: self fontContent;
		from: 80 mm @ 183 mm;
		text: 'board@esug.org');
	add: (PDFTextElement new
		font: self fontContent;
		from: 30 mm @ 188 mm;
		text: 'More infos: ');
	add: (PDFTextElement new
		textColor: self colorLink;
		font: self fontContent;
		from: 55 mm @ 188 mm;
		text: 'http://www.esug.org/wiki/pier/About/SupportESUG');
	add: (PDFTextElement new
		textColor: self colorTitle;
		font: self fontBoldContent;
		from: 20 mm @ 196 mm;
		text: 'Pay by Bank Transfer:');
	add: (PDFDataTableElement new
		data: #(
			#('Account Owner:' 'ESUG - EUROPEAN SMALLTALK USERS GROUP')
			#('Bank name:' 'Crédit Mutuel Nord Europe')
			#('IBAN:' 'FR76 1562 9027 0100 0433 0600 144')
			#('BIC/SWIFT Code:' 'CMCIFR2A')
		);
		font: self fontContent;
		from: 30 mm @ 202 mm;
		dimension: 160 mm @ 20 mm;
		style: #noBorder; yourself
	).
]

{ #category : #adding }
ERPDFInvoice >> addTablePayment: pdfPage of: user [
	| fontLegend currency |
	currency :=  (128 asCharacter) asString, ' 500'.
	fontLegend := PDFTimesFont size: 10pt.
	pdfPage add: (PDFDataTableWithColumnsCaptionElement new 
		captions: #('Description' 'Total');
		data: (Array with: (Array with: 'Full Registration to ESUG19' with: currency));
		from: 20 mm @ 115 mm;
		dimension: 170 mm @ 22 mm;
		customizationBlock: [ :cell :x :y :data | 
			y = 1 ifTrue: [
				x = 1 ifTrue: [ cell dimension: 140 mm @ 4 mm ]
				ifFalse: [ cell dimension: 30 mm @ 4 mm ].
			].
			x even ifTrue: [ cell alignment: (PDFAlignment right) ]
		];
		style: #dataTableWithColoredCaption;
		yourself);
	add: (PDFDataTableElement new
		data: (
			Array with: (Array with: 'Total to pay:' with: currency)
			with: (Array with: 'Not subjected to VAT' with: '')
			with: (Array with: 'Amounts are in Euro (EUR)' with: ''));
		from: 20 mm @ 142 mm;
		dimension: 170 mm @ 15 mm;
		customizationBlock: [ :cell :x :y :data | 
			y = 1 ifTrue: [ x = 1 ifTrue: [ cell textColor: self colorTitle; font: self fontBoldContent ] ] 
			ifFalse: [ cell font: self fontFooter ]
		];
		yourself
	);
	add: (PDFTextElement new
		font: fontLegend;
		from: 22 mm @ 158 mm;
		text: 'ESUG is a French Association of 1901 law (non-profit organization)');
	add: (PDFTextElement new
		font: fontLegend;
		from: 22 mm @ 163 mm;
		text: 'and it is not subjected to VAT, "TVA non applicable - article 293 B du CGI".').
]

{ #category : #'as yet unclassified' }
ERPDFInvoice >> colorBorder [
	^ PDFColor r: 255 g: 255 b: 255
]

{ #category : #'as yet unclassified' }
ERPDFInvoice >> colorLink [
	^ PDFColor r: 230 g: 0 b: 115
]

{ #category : #'as yet unclassified' }
ERPDFInvoice >> colorTitle [
	^ PDFColor r: 0 g: 0 b: 128
]

{ #category : #'as yet unclassified' }
ERPDFInvoice >> fontBoldContent [
	^ (self fontContent) bold: true.
]

{ #category : #'as yet unclassified' }
ERPDFInvoice >> fontContent [
	^ PDFTimesFont size: 13pt.
]

{ #category : #'as yet unclassified' }
ERPDFInvoice >> fontFooter [
	^ PDFTimesFont size: 10 pt.
]

{ #category : #'as yet unclassified' }
ERPDFInvoice >> lineElementFrom: aPoint1 to: aPoint2 [
	^ (PDFLineElement
		from: aPoint1
		to: aPoint2) drawColor: self colorTitle
]

{ #category : #'as yet unclassified' }
ERPDFInvoice >> templateRegistrationInvoice: aStream of: user [
	| pharoLogo pdfDoc pdfPage |
	pharoLogo := CssForLoginMDL new esugJpg.
	pdfDoc := PDFDocument new.
	pdfDoc styleSheet > #noBorder drawColor: self colorBorder.
	pdfDoc styleSheet > #noBorder > #cell alignment: PDFAlignment left.
	pdfDoc styleSheet > #dataTableWithColoredCaption 
		font: self fontContent;
		drawColor: self colorBorder;
		margin: 10 pt.
	pdfDoc styleSheet > #dataTableWithColoredCaption > #caption
		font: ((self fontContent) bold: true);
		textColor: self colorTitle.
	pdfDoc styleSheet > #dataTableWithColoredCaption > #cell alignment: PDFAlignment left.
	pdfDoc styleSheet > #datatable drawColor: self colorBorder.
	pdfDoc styleSheet > #datatable > #cell 
		font: self fontContent;
		alignment: PDFAlignment right; 
		margin: 20 pt.
	pdfPage := PDFPage new.
	pdfPage add: ((PDFJpegElement fromStream: pharoLogo readStream)
			from: 70 mm @ 10 mm;
			width: 60mm). 
	self addHeader: pdfPage.
	self addInfoInvoice: pdfPage of: user.
	self addTablePayment: pdfPage of: user.
	self addBorder: pdfPage.
	self addInfoPayment: pdfPage.
	self addFooter: pdfPage.
	pdfDoc add: pdfPage.
	pdfDoc exportTo: aStream
]

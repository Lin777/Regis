# ESUGConfRegistrationApp [![master branch:](https://travis-ci.org/Lin777/ESUGConfRegistrationApp.svg?branch=master)](https://travis-ci.org/Lin777/ESUGConfRegistrationApp/branches)
ESUG Conference Registration Application

## Installation 
### Prerequisites
- Latest Pharo 6.1+ image.
- Pharo VM for Pharo 6.1+.

You can get both by downloading it from the [Pharo](http://pharo.org) site or in the command line with [zeroconf](http://get.pharo.org): 

```bash
wget -O- get.pharo.org | bash
```

To load the ESUGApp package into the Pharo image:

```Smalltalk
Metacello new
 baseline:'ESUGApp';
 repository: 'github://Lin777/ESUGConfRegistrationApp:master/src';
 load.
 
ESUGSetUp start
```

You can see the application run in: http://localhost:8000/ESUG

Admin credentials:

email: admin@esug.org
password: 12345678

## Progress Status

### Roles

* [x] Admin / Organizer
* [x] Attendee
* [x] Team Manager / Secretary
* [ ] Student Volunter

### Attendee

* [x] create an account
* [x] register: days, participate to social dinner, vegetarian/vegans/..., polo gender/size (Man XS, Woman XS, M/W M, M/W L, M/W XL, => M/W 4XL), social networks info
* [x] coupon to pay less/free
* [x] can get its invoice -> unique invoice number
* [x] add an extra person to the social diner
* [x] get a *pdf* invoice (current Patagonia send it in HTML...) re-ask me a template
* [x] pay using paypal URL (cf. PatagoniaForESUG-Example.st)
* [ ] submit an ESUG Award	

### Team Manager-Secretary

* [x] registers/manages multiple attendees
* [x] get one bill for registered people -> unique invoice number (all these attendees will have this number)

### Admin-Organizer

* [x] setup infos (cf. PatagoniaForESUG-Example.st) :
* [x] admin credentials (login/password)
* [x] ESUG dates : start & stop
* [x] prices : early 1 day, early full, late 1 day, late full
* [x] price for extra person to the social dinner
* [ ] STMP server : currently we use a REST service to send emails (PatSmtpToPostMarkClientAdapter) and this is  easier than having its own SMTP server
* [x] Open / close registration
* [x] create coupons : percentage discount, fixed reduction, limited usage
	cf. https://esug.github.io/become_sponsor.html when clicking on a coupon -> see all registrations that used it 
* [x] modify a registration
* [x] apply a coupon on a registration
* [ ] Report to see who paid 
* [ ] mark a bill as paid => all registration of this bill are marked as paid

### CVS export 

* [x] full export (for us)
* [x] attendees list should only contain: names, mail, Organisation, Country

### Statistics to organize
* [x] number of participants to lunches per day and per types. Example: Monday: 120 normal attendees, 10 vegetarians, 3 vegans ... 	Tuesday: ...
* [x] polos: 40 Man S, 10 Woman S, 10 Woman M, 10 Man M, 30 Man XL, 4 Man 3XL, ...
* [x] number of participants to social dinner (same)
* [x] download all invoices in one zip

## Student Volunter

* [ ] check that a participant has been registered
* [ ] add an extra person to the social diner to an attendee -> email to pay extra fee + invoice?



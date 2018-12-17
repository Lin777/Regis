# ESUGConfRegistrationApp
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
 
 (Smalltalk at: #ZnZincServerAdaptor) startOn: 8080.
```

You can see the application run in: http://localhost:8080/ESUG

## Run Tests

The tests for the model run like any test.

On the other hand, the tests with Selenium (Parasol) require extract the Chromedriver's ZIP file into the directory where you put the Selenium server JAR file. And then run the Selenium server, execute the following on the command line:

```bash
java -Dwebdriver.chrome.driver=chromedriver -jar selenium-server-standalone-3.0.1.jar
```

and now you can run the tests.

If you have any inconvenience with parasol, you can check the [Parasol github](https://github.com/SeasideSt/Parasol)

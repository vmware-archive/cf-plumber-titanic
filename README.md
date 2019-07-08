[Plumber API example using Titanic data](https://raybuhr.github.io/2017/10/making-predictions-over-http/), slightly modified to run on Cloud Foundry (CF). 

![](https://github.com/pivotalsoftware/cf-r-plumber/blob/misc/Screen%20Shot%202019-04-01%20at%203.48.13%20PM.png)

Note the following important nuances:
* The host should be set as "0.0.0.0" in the pr$run function in [startscript.R](https://github.com/pivotalsoftware/cf-plumber-titanic/blob/master/startscript.R)
* The port is best set by including PORT <- as.numeric( Sys.getenv('PORT') ) and then supplying PORT as the argument in the pr$run function in [startscript.R](https://github.com/pivotalsoftware/cf-plumber-titanic/blob/master/startscript.R)

Note also the following minor modifications that were made to integrate the original API with CF:
* Creation of [r.yml](https://github.com/pivotalsoftware/cf-plumber-titanic/blob/master/r.yml) file which lists required add-on packages (dplyr and plumber in this case)
* Creation of [manifest.yml](https://github.com/pivotalsoftware/cf-plumber-titanic/blob/master/manifest.yml) file
* Creation of [Procfile](https://github.com/pivotalsoftware/cf-plumber-titanic/blob/master/Procfile) file 
* Trivial renaming of 'server.R' file in original code to 'startscript.R' 

To push this app to your CF environment, run the following command after establishing an API endpoint:
```
cf push cf-plumber-titanic -b https://github.com/cloudfoundry/r-buildpack.git
```

An example API is hosted live on a Cloud Foundry environment [here](https://cf-plumber-titanic.apps.pcfone.io).  To test the API is working try typing the following into a web browser:
```
https://cf-plumber-titanic.apps.pcfone.io/survival?Sex=male&Pclass=2&Age=20
```

Acknowledgements: Huge thanks to [Ray Buhr](https://raybuhr.github.io/2017/10/making-predictions-over-http/) for the original model training and scoring API developed on R and R-plumber.  Below is the author's description of the API, mapped to screenshots of the app running on CF:

The API here has three main components:

1. [Landing Page](https://cf-plumber-titanic.apps.pcfone.io) - presents a simple HTML page explaining the API

![](screenshots/Screen%20Shot%202019-06-20%20at%2010.19.22%20AM.png)

2. Health Check - a generic endpoint at `/healthcheck` used to test if server is responding

![](screenshots/Screen%20Shot%202019-06-20%20at%202.04.49%20PM.png)

3. Survival Prediction - the main goal, a RESTful HTTP API 

  - responds to url query string or JSON body payload requests with a probability of survival

![](screenshots/Screen%20Shot%202019-06-20%20at%202.02.23%20PM.png)

  - provides useful responses when requests features don't meet expectations

![](screenshots/Screen%20Shot%202019-06-20%20at%202.07.17%20PM.png)

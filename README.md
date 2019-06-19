[Plumber API Example](https://www.rplumber.io/), slightly modified to run on Cloud Foundry (CF). 

![](https://github.com/pivotalsoftware/cf-r-plumber/blob/misc/Screen%20Shot%202019-04-01%20at%203.48.13%20PM.png)

Note the following important nuances:
* The host should be set as "0.0.0.0" in the pr$run function in [startscript.R](https://github.com/pivotalsoftware/cf-r-plumber/blob/master/startscript.R)
* The port is best set by including PORT <- as.numeric( Sys.getenv('PORT') ) and then supplying PORT as the argument in the pr$run function in [startscript.R](https://github.com/pivotalsoftware/cf-r-plumber/blob/master/startscript.R)

To push this app to your CF environment, run the following command after establishing an API endpoint:
```
cf push rplumber -b https://github.com/cloudfoundry/r-buildpack.git
```

An example API is hosted live on a Cloud Foundry environment [here](https://rplumber.apps.pcfdemo.net).  To test the API is working try typing the following into a web browser:
```
http://rplumber.apps.pcfdemo.net/echo?msg=DataScienceonPCF!
```

Also try typing the following simple summing function in a terminal window (return sum of 5 and 6):
```
curl --data "a=5&b=6"  rplumber.apps.pcfdemo.net/sum
```




# plumber-titanic

Code for [blog post 2017/10/27](https://raybuhr.github.io/2017/10/making-predictions-over-http/)

Demonstrates how we can take a trained predictive model (i.e. statistical learning model or machine learning model) and deploy it to a server as a RESTful API that accepts JSON requests and returns JSON responses. To do this, we will use the package [plumber](https://www.rplumber.io/).

There are two main files:

- `titanic-api.R` which uses functions in R as the logic for our REST API
- `server.R` which sources the functions and uses the plumber annotations to generate web API endpoints, then starts a local webserver

The API here has three main components:

1. Landing Page - presents a simple HTML page explaining the API at `/`I

![](screenshots/plumber_landing_page_screenshot.png)

2. Health Check - a generic endpoint at `/healthcheck` used to test if server is responding

![](screenshots/plumber_healthcheck_screenshot.png)

3. Survival Prediction - the main goal, a RESTful HTTP API 

  - responds to url query string or JSON body payload requests with a probability of survival

![](screenshots/plumber_survival_prediction_screenshot.png)

  - provides useful responses when requests features don't meet expectations

![](screenshots/plumber_survival_error_screenshot.png)


And over course, this works from the command line as well. Here is hitting with a simple curl request (piped into jq).

![](screenshots/plumber_curl_screenshot.png)

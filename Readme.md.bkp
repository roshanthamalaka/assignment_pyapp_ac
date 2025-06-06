References:

Creating Python Web App using Flask:
https://medium.com/@dattu1993/creating-a-web-application-with-python-a-comprehensive-guide-for-beginners-db59df5867e4

Flask Documentation
https://flask.palletsprojects.com/en/stable/quickstart/

There several frameworks available with Python for Web Applications. Popular framework are Flask and Django. I have used Flask because it is lightweight.

By default Application runs on Port 5000 and to run it need use command   flask --app app.py run. 

To aviod that and use python for running the application used below to customized the port  as per below document 
https://learn.microsoft.com/en-us/visualstudio/ide/quickstart-python?view=vs-2022 

**Containerize Web Application**

This Section Describe Containerization related approach

References

Develop Python App  for containerization
https://docs.docker.com/guides/python/develop/

Containerizing The App
https://docs.docker.com/guides/python/containerize/ 

I have used Manullay Create assests because not using docker desktop.

When it comes dockerization we have to specify dependencies packages in requirements.txt file. 
In there I have specified required packages with respect the versions in my local machine because if version higher than my current version may introduce breaking changes. To avoid that I have followed that as a precaution.

To view Current Version of dependencies in my machine used below commands 

1. Flask Version: flask --version
2. Pytz Version: pip3 show pytz

__Problem Occured During Containerization___

Intiailly Exposed app like this 
if __name__ == "__main__":
    app.run('127.0.0.1', 8181)

However when running can't access the app externally. To avoid that added like this 
if __name__ == "__main__":
    app.run('0.0.0.0', 8181)
SO app will listen on all ports. So that We can access externally with docker 
docker run -p 8180:8181 myapp:v2

__Prometheus Exporter Creation with metrics__

Basic Understanding about Prometheus work  referred below documentation
https://betterstack.com/community/guides/monitoring/prometheus/

Prometheus scrap metric at interval typically on /metric  HTTP endpoint 

To expose metrics from application need to have relevant promethus libraries.

According to the Official Promethues Documentation Each Programming Language Has different Libaries 
https://prometheus.io/docs/instrumenting/clientlibs/

From the available libraries Choose Python Library 
Above Link Opens Github in there we can see the Link For Library documentation.
https://prometheus.github.io/client_python 

In here under instrumenting section we can see that it provides Four metrics namely counter,gauage,summary and histogram.
Since need to count the request We use counter instrument in our code 

According to it We have to specify counter and as per the syntax we can increment by one or specific value.

<ins>Refer below document for publish metrics</ins>

https://betterstack.com/community/guides/monitoring/prometheus-python-metrics/#step-3-instrumenting-a-counter-metric

Added Code Block Below 

@app.route('/metrics')
def metrics():
    """ Exposes application metrics in a Prometheus-compatible format. """
    return generate_latest(), 200, {'Content-Type': CONTENT_TYPE_LATEST}

This Publish Almost All the metrics. We only need specific only. In the Above document there is a section how to public specific metrics
We have to create custom registry. Below Section document.
https://betterstack.com/community/guides/monitoring/prometheus-python-metrics/#step-1-setting-up-the-demo-project:~:text=If%20you%20want%20to%20disable%20these%20and%20expose%20only%20specific%20metrics%2C%20you%20need%20to%20create%20a%20custom%20registry%3A 

So We have added counter metrics to registry as below 

counter_gdlf = Counter("Gandalf_total_requests","Total Number of Request to /gandalf uri",registry=registry,)
counter_clmb = Counter("Colombo_total_requests","Total Number of Request to /colombo uri

Then it exported only those two metrics

**Prometheus Server Setup** 

Installation : https://prometheus.io/docs/introduction/first_steps/ 

from flask import Flask,render_template
from datetime import datetime
import pytz
import os
from prometheus_client import Counter,generate_latest,CONTENT_TYPE_LATEST,CollectorRegistry


app = Flask(__name__)

# Create Custom Registry for Publish Specific 
registry = CollectorRegistry()


## Counters Metrics For Prometheus to export
# Library will _total to end so it will in the Prometheus as 
counter_gdlf = Counter("Gandalf_total_requests","Total Number of Request to /gandalf uri",registry=registry,)
counter_clmb = Counter("Colombo_total_requests","Total Number of Request to /colombo uri",registry=registry,) 

# When App loads it shows Welcome to App Screen
# Use route() decorator to tell Flask what URL should trigger our function.
@app.route("/")
def defaultpage():
    return "Welcome to My App"



# To show the Gandalf image had to use Rendering Template in Flask 
# Documentation https://flask.palletsprojects.com/en/stable/quickstart/#rendering-templates 
# Need to create templates folder under that need to create an html file shows the image. 
@app.route("/gandalf")
def gandalfpage():
 counter_gdlf.inc() # Increment Counter of gandalf by one. Syntax from document
 return  render_template('gandalf.html')

# To print time we have to use datetime module and its function now
# https://docs.python.org/3/library/datetime.html
# Get Time for Time Zone  https://www.geeksforgeeks.org/get-current-time-in-different-timezone-using-python/
# Formating the Time from datetime using strftime https://www.programiz.com/python-programming/datetime/strftime


@app.route("/colombo")
def timePage():
    IST = pytz.timezone('Asia/Colombo')
    colombo_datetime = datetime.now(IST) # This will return time in Full format  2025-06-03 21:36:48.742131+05:30
    time_now = colombo_datetime.strftime("%H:%M:%S") # Since Need only Current as per the requirment, So format the using strftime function
    print ("Colombo Time is ",time_now) # Added as Debugging step to see the time as inted format
    counter_clmb.inc()  # Increment Counter Colombo by one
    return "Colombo Time when the Request Made: "+ time_now

# Error Handling with Error message
@app.errorhandler(404)
def not_found(error):
    return render_template('error.html'), 404

#Return Prometheus Metrics
# https://betterstack.com/community/guides/monitoring/prometheus-python-metrics/#step-1-setting-up-the-demo-project
@app.route('/metrics')
def metrics():
    return generate_latest(registry), 200, {'Content-Type': CONTENT_TYPE_LATEST}

#https://learn.microsoft.com/en-us/visualstudio/ide/quickstart-python?view=vs-2022
# By Default app will run in flask webserver with port 5000. To use Customized port which is need for containerization added below to change the port
# After that able run using pyton3 command instead of flask --app app.py 
if __name__ == "__main__":
    app.run('0.0.0.0', 8181)

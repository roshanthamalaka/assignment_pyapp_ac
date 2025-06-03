
from flask import Flask,render_template
from datetime import datetime
import pytz

app = Flask(__name__)

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
    return "Colombo Time when the Request Made: "+ time_now

# Error Handling with Error message
@app.errorhandler(404)
def not_found(error):
    return render_template('error.html'), 404
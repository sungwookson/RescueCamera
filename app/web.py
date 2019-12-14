#!/usr/bin/python
from flask import Flask, render_template
import RPi.GPIO as GPIO
from time import sleep
import atexit

pin = 3
max_angle = 80
min_angle = 0
increment = 20

GPIO.setmode(GPIO.BOARD)
GPIO.setup(pin, GPIO.OUT)
pwm=GPIO.PWM(pin, 50)
pwm.start(0)

def SetAngle(angle):
	print angle
	duty = angle / 18 + 2
	GPIO.output(pin, True)
	pwm.ChangeDutyCycle(duty)
	sleep(1)
	GPIO.output(pin, False)
	pwm.ChangeDutyCycle(0)

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/rotate/<int:new_angle>', methods=['GET', 'POST'])
def rotateTo(new_angle):
	global curAngle
	curAngle = new_angle
	SetAngle(curAngle)
	return ""

@app.route('/rotate/left', methods=['GET', 'POST'])
def rotateLeft():
	global curAngle
	if min_angle <= curAngle - increment:
		curAngle -= increment
		SetAngle(curAngle)
	return ""

@app.route('/rotate/right', methods=['GET', 'POST'])
def rotateRight():
	global curAngle
	if curAngle + increment <= max_angle:
		curAngle += increment
		SetAngle(curAngle)
	return ""


if __name__ == '__main__':
	global curAngle
	curAngle = 0
	app.run(debug=False, port=80, host='0.0.0.0')
    
#defining function to run on shutdown
def close_running_threads():
	pwm.stop()
	GPIO.cleanup()
#Register the function to be called on exit
atexit.register(close_running_threads)

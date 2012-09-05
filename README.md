##Touch-Tracker

####A Simple Air App to detect what Touch & Gesture events your hardware supports.

Sits as a layer on top of your app that you can toggle on and off by holding your finger or mouse at the top of the screen for five seconds.

***

To use just add a new Diagnostics object to the topmost layer of your application.
```
app.addChild(new Diagnostics())
```
To listen for gesture events, set the input mode in the constructor of the Diagnostics object

```
app.addChild(new Diagnostics(MultitouchInputMode.GESTURE))
```

Mac and PC builds are available in the /app folder or download the repo and compile the ANT build yourself if you wish to make changes.

![touch-tracker-preview](http://braitsch.io/tmp/touch-tracker-github.png "touch-tracker")
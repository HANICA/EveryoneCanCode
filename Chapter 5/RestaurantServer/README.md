# EveryoneCanCode - Guided Project / Restaurant

For the Restaurant project in Chapter 5 students need a small server app (see §5.7). 
We ran into problems with the orginal app so we decided to create a macOS app using Swift 4 ourselves. There is a Python-based server replacement but the problem is that one needs to at least have a little Python experience, also the Everyone Can Code book shows screenshots of the app as is and we tried to keep our app close to it.<br>
<br>
Some info on how the app works (intended for Swift Teachers):
- menu.json (as provided by Apple Inc.) comes with the app as part of the App bundle
- when you start the app for the first time you will get a warning because you download the app from internet, it won't open unless you allow it using to be opened using the "Privacy & settings" screen (shown in Dutch below:)
(gatekeeper.png)
- menu.json will be copied to the Shared Application folder, if you press "Edit "

the app starts a HTTP server on port 8090 (default), if you open the App bundle you will also see a settings.json, you could change the port there (restart app to make the change work)

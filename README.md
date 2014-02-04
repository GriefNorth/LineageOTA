#CyanogenModOTA
A simple OTA REST Server for CyanogenMod OTA Updater System Application

##How to use
Just <code>git clone</code> this repo (or [download it](https://github.com/julianxhokaxhiu/CyanogenModOTA/archive/master.zip)) and upload all the files to your preferred directory on your server. You just have to be sure that is running PHP.

After, upload all your ZIP files that you get after you build the ROM on the <code>_builds</code> directory.

##and after?
Just follow the rest of the tutorial on [my personal blog post](http://blog.julianxhokaxhiu.com/entry/how-the-cm-ota-server-works-and-how-to-implement-and-use-ours) where I explain how to override the build server on your ROM.

##What about Debug?
I've implemented a [simple script made for NodeJS](https://github.com/julianxhokaxhiu/CyanogenModOTAUnitTest) that you clone and use it.

##Do you support Delta updates?
YES! As long as you have <code>xdelta3</code> installed into your system (Windows/Mac/Linux). More info here: [xdelta.org](http://xdelta.org/)

##Changelog
- 0.2: Refactored a lot of code + boost MD5 calculation + added support for **Delta Updates** (<code>/api/v1/build/get_delta</code>)
- 0.1: First implementation of the server. Only the <code>/api</code> call is implemented right now.

Enjoy :)
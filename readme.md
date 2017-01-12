## First and Foremost

Embarrassingly (hilariously depending on from whose perspective) I decided to develop this app and get some experimental data **BEFORE** doing a time complexity analysis. After developing the app I discovered that cracking the password ~ took 30 seconds, ~~ took 30 minutes, and a few hours into cracking ~~~ I decided to do a pen and paper analysis and found that it may take 2.25 days!

For a charSet (character set to be tested) of size 87 a pwd (password) of length L would take 87^L operations, so that if one operation were to take one centisecond (which it takes a bit longer), then a pwd of length 127 would take *6.6045 x 10^236 years* to crack. The reduced charSet of length 62 being only alphanumeric characters would still, for a pwd of length 127, take *1.3634 x 10^218 years* to crack.

In short, I had forgotten how trying to crack passwords like this is futile!!

## Secondly

The above being said, I do not consider this mini project a waste of time. I have learnt the basics of Windows batch file programming, and some basic concepts of scripting languages, such as an “if” block being executed as one statement, etc. I imagine that knowledge of batch programming’s enabledelayedexpansion will be handy when learning other scripting languages.

In this particular language, the characters space, | ) < > ^ cause problems when executing the file, and so have been omitted from the charSet.

This app is really a testing mode version. After the brief analysis mentioned in First and Foremost, I decided there is no point to working on it further to get it production ready. 

## Thirdly – Acknowledgements

1) [This tutorial](http://www.tutorialspoint.com/batch_script/) is a little hard to understand in parts, but gave me most of what I needed to know

2) [This site](http://ss64.com/nt/setlocal.html) and some of its links helped me to understand the *very* essential “setlocal enabledelayedexpansion” and “endlocal & set (…)” commands.

## Last and Least

If you legally download a movie file and it happens to be a password protect RAR file, **delete it!** Trying to gain the password legally will be more effort than it’s worth, as will be trying to crack it.

But if you wish to learn about Windows batch file programming then hopefully the links in this readme file will help you.

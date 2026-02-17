> [!CAUTION]
> BetterPrint is **IN DEVELOPMENT** now and also i cant say this thing is stable (also if u spam images in console it **WILL** fuckin destroy ur fps)

# BetterPrint
wow pro print

![preview](https://github.com/AndreyTheDev/betterprint/blob/main/resources/yeyeye.jpg)
also u can use this in ur scripts, but please dont forget give me credit 😭🙏

### why its cool
1. u can print cool text
2. u can make cool things
3. betterprint is cool
4. its fully opensource
5. oyoyoyeyeyeywhatafu

### guide! yay
okay lets start, so we need start init first cuz we need setup all things
```lua
local BetterPrint = loadstring(game:HttpGet("https://raw.githubusercontent.com/AndreyTheDev/betterprint/main/source.lua"))()

BetterPrint:Init() --// also if u want debug mode u can just use BetterPrint:Init(true)
```
also we can print smth in console now!
```lua
local BetterPrint = loadstring(game:HttpGet("https://raw.githubusercontent.com/AndreyTheDev/betterprint/main/source.lua"))()

BetterPrint:Init()
BetterPrint.print("wow pro")
```
and yea we can change color and size of the text
```lua
local BetterPrint = loadstring(game:HttpGet("https://raw.githubusercontent.com/AndreyTheDev/betterprint/main/source.lua"))()

BetterPrint:Init()
BetterPrint.print("wow pro", "Red", 20) --// {text}, {color from colorbase or rgb (optional)}, size (optional)}
```
soo can we print images? yep
```lua
local BetterPrint = loadstring(game:HttpGet("https://raw.githubusercontent.com/AndreyTheDev/betterprint/main/source.lua"))()

BetterPrint:Init()
BetterPrint.printimage("rbxassetid://11104447788", 200, 200, "Stretch") --// {image}, {height (optional)}, {width (optional)}, {scaletype (optional)}
```
ascii arts? yea! (but also warn: ascii arts generates using asciified api soooo it have delay n it doesnt works on exploits that dont supports request)
```lua
local BetterPrint = loadstring(game:HttpGet("https://raw.githubusercontent.com/AndreyTheDev/betterprint/main/source.lua"))()

BetterPrint:Init()
BetterPrint.printascii("hii!", "Green", "Standard") --// {text}, {color from colorbase or rgb (optional}, {font (optional, also its font from asciified)}
```
###### also yea i didnt add some features to guide cuz i didnt finish ts features :/

#### also credits (cuz yeah)
###### https://scriptblox.com/u/Verified (i stole his luarmor like loading)
###### also join my telegram channel -> t.me/SegmaNews

Wiremod E2: ChatPrint
===============
A utility function to print coloured text to a players chat area.

Usage
===============

chatPrint(vector color, string text, ...)
chatPrint(entity player, vector color, string text, ...)
chatPrint(array r)
chatPrint(entity player, array r)

Examples
===============

Prints "Hello world!" in green to the E2 owner's chat:
```
chatPrint(owner(), vec(0,255,0), "Hello world!")
```


Rainbow Chat (shows usage of arrays) (thanks to Divran for this):
```
@name rainbow chat
runOnChat(1)

if (chatClk(owner())) {
    local STR = lastSaid()
    local R = array()
    R:pushVector(vec(255,100,255))
    R:pushString(owner():name())
    R:pushVector(vec(255,255,255))
    R:pushString(": ")
    for(I=1,STR:length()) {
        local Color = hsv2rgb(360/STR:length()*I,1,1)
        R:pushVector(Color)
        R:pushString(STR[I])
    }
    chatPrint(R)
    hideChat(1)
}
```

Installation
===============
1. Put this folder into Steam/Steamapps/(Steam username or 'Common')/garrysmod/garrysmod/addons/
2. Done, enjoy.
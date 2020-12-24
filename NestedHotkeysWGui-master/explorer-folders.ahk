#Include lib\NestedHotkeysWGui.ahk
;Configure the look of the GUI
; NHWGUI_textSize  := 22

dev_db = ""
dev_applet = ""

;Replaces default shortcut with a menu to open different folders
~!`::
    nhgMain := New NestedHotkeysWGui("Folders")
    nhgMain
        .Add("~","OpenExplorer"," ~\")
        .Add("2","OpenFolder"," ~\Downloads",A_MyDocuments "\..\Downloads")
        .Add("3","OpenFolder"," ~\Documents",A_MyDocuments)
        .Add("R","OpenFolder"," C:\","C:\")
        .Add("T","OpenFolder"," C:\Users\cccho\", "C:\Users\cccho")
        .Add(",","send_dev_db"," Dev -> DB")
        .Add(".","send_applet"," Dev -> Applet")
    .Run()
    return

OpenFolder(path){
    Run %path%
}

OpenExplorer(_) {
    run explorer
}

send_dev_db(_) {
    SendRaw % dev_db
}

send_applet(_) {
    SendRaw % dev_applet
}
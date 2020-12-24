global NHWGUI_bgColor   := "1D1D1D",
global NHWGUI_textColor := "FFFFFF",
global NHWGUI_titleSize  := 22
global NHWGUI_textSize  := 16
global NHWGUI_labelSize  := 14

#SingleInstance force
AutoTrim off

Class NestedHotKeysWGui{
    ;guiNumber:=""
    selectedKeys:=Object()
    selectedParameters:=Object()
    selectedFunctions:=Object()

    __New(title){
        this.guiNumber:= RegExReplace(RandomStr(), "\W", "i")
        ;this.guiNumber := title
        name:=this.guiNumber
        Gui, %name%:New
        Gui, %name%:-Caption +AlwaysOnTop +ToolWindow
        Gui, %name%:Color, %NHWGUI_bgColor%
        Gui, %name%:Font, s%NHWGUI_titleSize% c%NHWGUI_textColor%, Roboto Light
        wWrap:=Round((A_ScreenWidth/3))
        Gui, %name%:Add, Text,+Wrap w%wWrap% x16 y14, %title%
        Gui, %name%:Font, c%NHWGUI_textColor%
    }
    Add( hotKey, function, desc, param:=""){
        name:=this.guiNumber
        Gui, %name%:Font, s16, Roboto Mono
        Gui, %name%:Add, Text, x16, %hotKey%: 

        wWrap:=A_ScreenWidth-(2*(A_ScreenWidth/3))-50

        Gui, %name%:Font, s18, Roboto Light
        Gui, %name%:Add, Text, +Wrap w%wWrap% x+4, %desc%

        if (hotKey = "~") {
            hotKey := "``"
        }
        this.selectedKeys.Insert(hotKey)
        this.selectedFunctions.Insert(function)
        
        this.selectedParameters.Insert(param)
        return this
    }
    Run(){
        name:=this.guiNumber

        posX := 4*(A_ScreenWidth/5)
        width := A_ScreenWidth-posX
        height := 778
        Gui, %name%:Show, x%posX% y42 w%width% h%height%
        data:=""
        for i,selectedKey in this.selectedKeys
            data:="," selectedKey "" data
        Input, subkey, L1, {Esc},%data%
        for i, selectedKey in this.selectedKeys {
            if (selectedKey=subkey) {
                if (IsFunc(this.selectedFunctions[i])) {
                    fn:=this.selectedFunctions[i]
                    Gui, %name%:Hide
                    %fn%(this.selectedParameters[i])
                }
            }
        }
        Gui, %name%:Hide
    }
}

RandomStr(l = 16, i = 48, x = 122) { ; length, lowest and highest Asc value
	Loop, %l% {
		Random, r, i, x
		s .= Chr(r)
	}
	Return, s
}
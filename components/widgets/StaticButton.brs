sub init()
  m.background = m.top.findNode("background")
  m.label = m.top.findNode("label")
  m.top.observeField("focusedChild", "onFocusedChild")
end sub

sub onFocusedChild(msg as dynamic)
  focusedChild = msg.getData()
  m.top.selected = false

  if focusedChild <> invalid
      setButtonFocus()
  else
      removeButtonFocus()
  end if
end sub

sub setupButton(event as object)
  m.buttonData = event.getData()
  if type(m.buttonData) = "roAssociativeArray" and m.buttonData.Count() > 0
      m.label.setFields({
          color: m.buttonData.unfocusedTextColor,
          font: m.buttonData.font,
          horizAlign: "center",
          vertAlign: "center",
          text: m.buttonData.text,
          width: m.buttonData.width,
          height: m.buttonData.height
      })

      m.background.setFields({
          width: m.buttonData.width,
          height: m.buttonData.height,
          uri: m.buttonData.backgroundUri,
          visible: true,
          blendColor: m.buttonData.unfocusedColor
      })
  end if
end sub

sub setButtonText(text as string)
  if text <> invalid and text <> ""
      m.label.font = m.buttonData.font
      m.label.text = text
      m.top.text = m.label.text
  end if
end sub

sub setButtonFocus()
  m.label.setFields({
      color: m.buttonData.focusedTextColor
  })
  m.background.setFields({
      blendColor: m.buttonData.focusedColor,
      visible: true
  })
end sub

sub removeButtonFocus()
  m.label.setFields({
      color: m.buttonData.unfocusedTextColor
  })
  m.background.setFields({
      blendColor: m.buttonData.unfocusedColor,
      visible: true
  })
end sub

function onKeyEvent(key as string, press as boolean) as Boolean
  handled = false
  if press and key = "OK" and m.top.isInFocusChain()
      m.top.selected = true
      handled = true
  end if

  return handled
end function
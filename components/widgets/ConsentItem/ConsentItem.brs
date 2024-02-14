sub init()
  m.background = m.top.findNode("background")
  m.container = m.top.findNode("container")
  m.label = m.top.findNode("label")
  m.icon = m.top.findNode("icon")
  m.top.observeField("focusedChild", "onFocusedChild")
  m.top.observeField("selected", "onSelected")
end sub

sub onFocusedChild(msg as dynamic)
  focusedChild = msg.getData()

  if focusedChild <> invalid
    setItemFocus()
  else
    removeItemFocus()
  end if
end sub

sub setupItem(event as object)
  m.itemData = event.getData()
  if type(m.itemData) = "roAssociativeArray" and m.itemData.Count() > 0
    m.container.setFields({
      layoutDirection: "horiz",
      horizAlignment: "left",
      vertAlignment: "center",
      translation: [15, m.itemData.height / 2],
      itemSpacings: [15]
    })

    m.label.setFields({
      color: m.itemData.unfocusedTextColor,
      font: m.itemData.font,
      horizAlign: "left",
      vertAlign: "center",
      text: m.itemData.text,
      width: m.itemData.width,
      height: m.itemData.height
    })

    m.icon.setFields({
      uri: m.itemData.uri,
      blendColor: m.itemData.unselectedColor
      width: 50,
      height: 50
    })

    m.background.setFields({
      width: m.itemData.width,
      height: m.itemData.height,
      uri: m.itemData.backgroundUri,
      visible: true,
      blendColor: m.itemData.unfocusedColor
    })
  end if
end sub

sub setItemText(text as string)
  if text <> invalid and text <> ""
    m.label.font = m.itemData.font
    m.label.text = text
    m.top.text = m.label.text
  end if
end sub

sub setItemFocus()
  m.label.setFields({
    color: m.itemData.focusedTextColor
  })
  m.background.setFields({
    blendColor: m.itemData.focusedColor,
    visible: true
  })
end sub

sub removeItemFocus()
  m.label.setFields({
    color: m.itemData.unfocusedTextColor
  })
  m.background.setFields({
    blendColor: m.itemData.unfocusedColor,
    visible: true
  })
end sub

function onKeyEvent(key as string, press as boolean) as boolean
  handled = false
  if press and key = "OK" and m.top.isInFocusChain()
    m.top.selected = not m.top.selected
    handled = true
  end if

  return handled
end function

sub onSelected(msg as dynamic)
  isSelected = msg.getData()

  if isSelected
    m.icon.setFields({
      blendColor: m.itemData.selectedColor
    })
  else
    m.icon.setFields({
      blendColor: m.itemData.unselectedColor
    })
  end if
end sub
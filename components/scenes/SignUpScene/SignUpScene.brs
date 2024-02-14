sub init()
  m.keyboard = m.top.findNode("keyboard")
  m.container = m.top.findNode("container")
  m.title = m.top.findNode("title")
  m.emailLabel = m.top.findNode("emailLabel")
  m.email = m.top.findNode("email")
  m.passwordLabel = m.top.findNode("passwordLabel")
  m.password = m.top.findNode("password")
  m.buttonGroup = m.top.findNode("buttonGroup")
  m.saveButton = m.top.findNode("saveButton")
  m.cancelButton = m.top.findNode("cancelButton")
  m.statesContainer = m.top.findNode("statesContainer")
  m.locationBackground = m.top.findNode("locationBackground")
  m.locationLabel = m.top.findNode("locationLabel")
  m.stateLabel = m.top.findNode("stateLabel")
  m.statesList = m.top.findNode("statesList")
  m.selectedStateLabel = m.top.findNode("selectedStateLabel")
  m.saveStateButton = m.top.findNode("saveStateButton")

  m.saveButton.observeField("selected", "onButtonSelected")
  m.cancelButton.observeField("selected", "onButtonSelected")
  m.saveStateButton.observeField("selected", "onButtonSelected")
  m.statesList.observeField("itemSelected", "onItemSelected")
  m.statesList.observeField("itemFocused", "onItemFocused")
  m.top.observeField("focusedChild", "onFocusedChild")
  m.keyboard.observeField("text", "onKeyboardTextChanged")
  m.keyboard.textEditBox.observeField("cursorPosition", "onCursorPositionChanged")

  setStyles()
  getStateContent()
end sub

sub setStyles()
  styles = getSignUpSceneStyles()
  m.styles = styles

  m.keyboard.setFields(styles.keyboard)
  m.container.setFields(styles.container)
  m.title.setFields(styles.titleLabel)
  m.emailLabel.setFields(styles.emailLabel)
  m.email.setFields(styles.emailTextBox)
  m.passwordLabel.setFields(styles.passwordLabel)
  m.password.setFields(styles.passwordTextBox)
  m.locationLabel.setFields(styles.locationLabel)
  m.locationBackground.setFields(styles.locationBackground)
  m.locationBackground.blendColor = styles.locationBackground.unfocusedColor
  m.stateLabel.setFields(styles.stateLabel)
  m.stateLabel.color = styles.stateLabel.unfocusedColor
  m.statesList.setFields(styles.statesList)
  m.buttonGroup.setFields(styles.buttonGroup)
  m.saveButton.setFields(styles.saveButton)
  m.cancelButton.setFields(styles.cancelButton)
  m.saveStateButton.setFields(styles.saveStateButton)
  m.selectedStateLabel.setFields(styles.selectedStateLabel)

  m.saveButton.buttonData = styles.saveButton
  m.cancelButton.buttonData = styles.cancelButton
  m.saveStateButton.buttonData = styles.saveStateButton

  m.saveButton.callfunc("setButtonText", "Sign up")
  m.cancelButton.callfunc("setButtonText", "Cancel")
  m.saveStateButton.callfunc("setButtonText", "Save")

  m.lastFocused = m.email
  m.email.setFocus(true)
end sub

sub onItemSelected(msg as dynamic)
  m.selectedIndex = msg.getData()
  stateSelected = m.statesList.content.getChild(m.selectedIndex)
  m.selectedStateLabel.text = Substitute("{0}", stateSelected.title, stateSelected.id)
end sub

sub getStateContent()
  if m.contentFetcher = invalid
    m.contentFetcher = createObject("roSGNode", "ContentTask")
    m.contentFetcher.observeField("result", "onSuccessResponse")
    m.contentFetcher.observeField("error", "onErrorResponse")
    m.contentFetcher.control = "RUN"
  end if
end sub

sub onSuccessResponse(msg as dynamic)
  statesData = msg.getData().content

  setStatesContent(statesData)
end sub

sub setStatesContent(data as object)
  if data <> invalid and data.count() > 0
    content = CreateObject("roSGNode", "ContentNode")
    content.id = "statesListContent"

    for each item in data
      childNode = CreateObject("roSGNode", "ContentNode")
      childNode.id = item.code
      childNode.title = item.name
      childNode.addFields({
        configEnforced: item.config_enforced
      })
      content.appendChild(childNode)
    end for

    m.selectedIndex = 0
    m.statesList.content = content
    defaultState = content.getChild(0)
    m.stateLabel.text = Substitute("{0}", defaultState.title, defaultState.id)
    m.selectedStateLabel.text = Substitute("{0}", defaultState.title, defaultState.id)
  end if
end sub

sub onFocusedChild(msg as dynamic)
  if m.top.isInFocusChain() and m.lastFocused <> invalid
    m.lastFocused.setFocus(true)
  end if
end sub

sub onCursorPositionChanged()
  if m.keyboard.visible
    m[m.activeInput].cursorPosition = m.keyboard.textEditBox.cursorPosition
  end if
end sub

sub onKeyboardTextChanged()
  if m.keyboard.visible then
    m[m.activeInput].text = m.keyboard.text
  end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
  handled = false
  if press = true
    if key = "back"
      if m.keyboard.visible
        m.keyboard.visible = false
        m.keyboard.text = ""
        m.lastFocused = m[m.activeInput]
        m[m.activeInput].setFocus(true)
        handled = true
      else if m.statesContainer.visible
        handled = true
      end if
    else if key = "OK"
      handleOKPressed()
    else if key = "up"
      if m.password.hasFocus()
        m.lastFocused = m.email
        m.email.setFocus(true)
        m.email.active = true
        m.password.active = false
        handled = true
      else if m.locationBackground.hasFocus()
        m.lastFocused = m.password
        m.stateLabel.color = m.styles.stateLabel.unfocusedColor
        m.locationBackground.blendColor = m.styles.locationBackground.unfocusedColor
        m.password.setFocus(true)
        m.password.active = true
      else if m.saveButton.isInFocusChain() or m.cancelButton.isInFocusChain()
        m.lastFocused = m.locationBackground
        m.stateLabel.color = m.styles.stateLabel.focusedColor
        m.locationBackground.blendColor = m.styles.locationBackground.focusedColor
        m.locationBackground.setFocus(true)
      end if
    else if key = "down"
      if m.email.hasFocus()
        m.lastFocused = m.password
        m.password.setFocus(true)
        m.password.active = true
        m.email.active = false
        handled = true
      else if m.password.hasFocus()
        m.password.active = false
        m.lastFocused = m.locationBackground
        m.stateLabel.color = m.styles.stateLabel.focusedColor
        m.locationBackground.blendColor = m.styles.locationBackground.focusedColor
        m.locationBackground.setFocus(true)
      else if m.locationBackground.hasFocus()
        m.lastFocused = m.saveButton
        m.stateLabel.color = m.styles.stateLabel.unfocusedColor
        m.locationBackground.blendColor = m.styles.locationBackground.unfocusedColor
        m.saveButton.setFocus(true)
      end if
    else if key = "right"
      if m.saveButton.isInFocusChain()
        m.lastFocused = m.cancelButton
        m.cancelButton.setFocus(true)
      else if m.statesList.isInFocusChain()
        m.lastFocused = m.saveStateButton
        m.saveStateButton.setFocus(true)
      end if
    else if key = "left"
      if m.cancelButton.isInFocusChain()
        m.lastFocused = m.saveButton
        m.saveButton.setFocus(true)
      else if m.saveStateButton.isInFocusChain()
        m.lastFocused = m.statesList
        m.statesList.setFocus(true)
      end if
    end if
  end if
  return handled
end function

sub handleOKPressed()
  if m.email.hasFocus() then
    m.activeInput = "email"
    m.keyboard.visible = true
    m.lastFocused = invalid
    m.keyboard.setFocus(true)
  else if m.password.hasFocus() then
    m.activeInput = "password"
    m.keyboard.visible = true
    m.lastFocused = invalid
    m.keyboard.setFocus(true)
  else if m.locationBackground.hasFocus()
    m.container.visible = false
    m.statesContainer.visible = true
    m.lastFocused = m.statesList
    m.statesList.setFocus(true)
  end if
end sub

sub onButtonSelected(msg as dynamic)
  selectedButton = msg.getNode()
  isButtonSelected = msg.getData()

  if isButtonSelected
    if selectedButton = "saveButton"
      m.top.event = {
        type: "SIGN_UP",
        data: {
          email: m.email.text,
          password: m.password.text,
          location: m.statesList.content.getChild(m.selectedIndex)
        }
      }
    else if selectedButton = "cancelButton"
      m.top.event = {
        type: "BACK"
      }
    else if selectedButton = "saveStateButton"
      stateSelected = m.statesList.content.getChild(m.selectedIndex)
      m.stateLabel.text = Substitute("{0}", stateSelected.title, stateSelected.id)

      m.container.visible = true
      m.statesContainer.visible = false
      m.lastFocused = m.locationBackground
      m.locationBackground.setFocus(true)
    end if
  end if
end sub

sub destroyTask()
  if m.jsonParser <> invalid
    m.jsonParser.control = "STOP"
    m.jsonParser = invalid
  end if
end sub

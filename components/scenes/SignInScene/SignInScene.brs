sub init()
  m.keyboard = m.top.findNode("keyboard")
  m.container = m.top.findNode("container")
  m.title = m.top.findNode("title")
  m.emailLabel = m.top.findNode("emailLabel")
  m.email = m.top.findNode("email")
  m.passwordLabel = m.top.findNode("passwordLabel")
  m.password = m.top.findNode("password")
  m.buttonGroup = m.top.findNode("buttonGroup")
  m.confirmButton = m.top.findNode("confirmButton")
  m.cancelButton = m.top.findNode("cancelButton")

  m.confirmButton.observeField("selected", "onButtonSelected")
  m.cancelButton.observeField("selected", "onButtonSelected")
  m.top.observeField("focusedChild", "onFocusedChild")
  m.keyboard.observeField("text", "onKeyboardTextChanged")
  m.keyboard.textEditBox.observeField("cursorPosition", "onCursorPositionChanged")

  setStyles()
end sub

sub setStyles()
  styles = getSignInSceneStyles()

  m.keyboard.setFields(styles.keyboard)
  m.container.setFields(styles.container)
  m.title.setFields(styles.titleLabel)
  m.emailLabel.setFields(styles.emailLabel)
  m.email.setFields(styles.emailTextBox)
  m.passwordLabel.setFields(styles.passwordLabel)
  m.password.setFields(styles.passwordTextBox)
  m.buttonGroup.setFields(styles.buttonGroup)
  m.confirmButton.setFields(styles.confirmButton)
  m.cancelButton.setFields(styles.cancelButton)
  m.confirmButton.buttonData = styles.confirmButton
  m.cancelButton.buttonData = styles.cancelButton
  m.confirmButton.callfunc("setButtonText", "Sign in")
  m.cancelButton.callfunc("setButtonText", "Cancel")

  m.lastFocused = m.email
  m.email.setFocus(true)
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
    if key = "back" and m.keyboard.visible
      m.keyboard.visible = false
      m.keyboard.text = ""
      m.lastFocused = m[m.activeInput]
      m[m.activeInput].setFocus(true)
      handled = true
    else if key = "OK"
      handleOKPressed()
    else if key = "up"
      if m.password.hasFocus()
        m.lastFocused = m.email
        m.email.setFocus(true)
        m.email.active = true
        m.password.active = false
        handled = true
      else if m.confirmButton.isInFocusChain() or m.cancelButton.isInFocusChain()
        m.lastFocused = m.password
        m.password.setFocus(true)
        m.password.active = true
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
        m.lastFocused = m.confirmButton
        m.confirmButton.setFocus(true)
      end if
    else if key = "right"
      if m.confirmButton.isInFocusChain()
        m.lastFocused = m.cancelButton
        m.cancelButton.setFocus(true)
      end if
    else if key = "left"
      if m.cancelButton.isInFocusChain()
        m.lastFocused = m.confirmButton
        m.confirmButton.setFocus(true)
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
  end if
end sub

sub onButtonSelected(msg as dynamic)
  selectedButton = msg.getNode()
  isButtonSelected = msg.getData()

  if isButtonSelected
    if selectedButton = "confirmButton"
      m.top.event = {
        type: "SIGN_IN",
        data: {
          email: m.email.text,
          password: m.password.text
        }
      }
    else if selectedButton = "cancelButton"
      m.top.event = {
        type: "BACK"
      }
    end if
  end if
end sub

sub init()
  m.signUpButton = m.top.findNode("signUpButton")
  m.signInButton = m.top.findNode("signInButton")

  m.signUpButton.observeField("selected", "onButtonSelected")
  m.signInButton.observeField("selected", "onButtonSelected")
  m.top.observeField("focusedChild", "onFocusedChild")

  m.lastFocused = invalid

  setStyles()
end sub

sub setStyles()
  styles = getWelcomeSceneStyles()

  m.signInButton.setFields(styles.signInButton)
  m.signUpButton.setFields(styles.signUpButton)
  m.signInButton.buttonData = styles.signInButton
  m.signUpButton.buttonData = styles.signUpButton
  m.signInButton.callfunc("setButtonText", "Sign In")
  m.signUpButton.callfunc("setButtonText", "Sign Up")

  m.lastFocused = m.signInButton
  m.signInButton.setFocus(true)
end sub

sub onFocusedChild(msg as dynamic)
  if m.top.isInFocusChain() and m.lastFocused <> invalid
    m.lastFocused.setFocus(true)
  end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
  handled = false
  if press
    if key = "up"
      if m.signUpButton.isInFocusChain()
        m.lastFocused = m.signInButton
        m.signInButton.setFocus(true)
        handled = true
      end if
    else if key = "down"
      if m.signInButton.isInFocusChain()
        m.lastFocused = m.signUpButton
        m.signUpButton.setFocus(true)
        handled = true
      end if
    end if
  end if
  return handled
end function

sub onButtonSelected(msg as dynamic)
  selectedButton = msg.getNode()
  eventType = ""

  if selectedButton = "signInButton"
    eventType = "SIGN_IN_BUTTON_SELECTED"
  else if selectedButton = "signUpButton"
    eventType = "SIGN_UP_BUTTON_SELECTED"
  end if

  m.top.event = {
    type: eventType
  }
end sub

sub init()
  m.container = m.top.findNode("container")
  m.title = m.top.findNode("title")
  m.message = m.top.findNode("message")
  m.collectionConsent = m.top.findNode("collectionConsent")
  m.sharingConsent = m.top.findNode("sharingConsent")
  m.buttonGroup = m.top.findNode("buttonGroup")
  m.saveButton = m.top.findNode("saveButton")
  m.signOutButton = m.top.findNode("signOutButton")

  m.saveButton.observeField("selected", "onButtonSelected")
  m.signOutButton.observeField("selected", "onButtonSelected")
  m.collectionConsent.observeField("selected", "onItemSelected")
  m.sharingConsent.observeField("selected", "onItemSelected")
  m.top.observeField("focusedChild", "onFocusedChild")

  m.allowCollection = false
  m.allowSharing = false

  setStyles()
end sub

sub setStyles()
  styles = getConsentSceneStyles()

  m.container.setFields(styles.container)
  m.title.setFields(styles.titleLabel)
  m.message.setFields(styles.messageLabel)
  m.collectionConsent.setFields(styles.collectionConsent)
  m.sharingConsent.setFields(styles.sharingConsent)
  m.collectionConsent.itemData = styles.collectionConsent
  m.sharingConsent.itemData = styles.sharingConsent
  m.collectionConsent.callfunc("setItemText", "Allow data collection for personalized recommendations")
  m.sharingConsent.callfunc("setItemText", "Allow data sharing with third parties")

  m.buttonGroup.setFields(styles.buttonGroup)
  m.saveButton.setFields(styles.saveButton)
  m.signOutButton.setFields(styles.signOutButton)
  m.saveButton.buttonData = styles.saveButton
  m.signOutButton.buttonData = styles.signOutButton
  m.saveButton.callfunc("setButtonText", "Save")
  m.signOutButton.callfunc("setButtonText", "Sign Out")

  m.lastFocused = m.saveButton
  m.saveButton.setFocus(true)
end sub

sub initDataChanged(msg as dynamic)
  m.userConfig = msg.getData()
  locationData = m.userConfig.locationData
  m.configEnforced = locationData.configEnforced
  m.consents = m.userConfig.consents

  if m.consents["allow_data_collection"]
    m.collectionConsent.selected = true
    m.allowCollection = true
  end if

  if m.consents["allow_data_sharing"]
    m.sharingConsent.selected = true
    m.allowSharing = true
  end if

  if m.configEnforced
    m.message.text = "This settings are enforced by the state laws of " + locationData.name + "."
  end if
end sub

sub onFocusedChild(msg as dynamic)
  if m.top.isInFocusChain() and m.lastFocused <> invalid
    m.lastFocused.setFocus(true)
  end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
  handled = false
  if press = true
    if key = "back"
      handled = true
    else if key = "up"
      if m.sharingConsent.isInFocusChain()
        m.lastFocused = m.collectionConsent
        m.collectionConsent.setFocus(true)
        handled = true
      else if m.saveButton.isInFocusChain() and not m.configEnforced
        m.lastFocused = m.sharingConsent
        m.sharingConsent.setFocus(true)
        handled = true
      else if m.signOutButton.isInFocusChain()
        m.lastFocused = m.saveButton
        m.saveButton.setFocus(true)
        handled = true
      end if
    else if key = "down"
      if m.collectionConsent.isInFocusChain()
        m.lastFocused = m.sharingConsent
        m.sharingConsent.setFocus(true)
        handled = true
      else if m.sharingConsent.isInFocusChain()
        m.lastFocused = m.saveButton
        m.saveButton.setFocus(true)
        handled = true
      else if m.saveButton.isInFocusChain()
        m.lastFocused = m.signOutButton
        m.signOutButton.setFocus(true)
        handled = true
      end if
    end if
  end if
  return handled
end function

sub onButtonSelected(msg as dynamic)
  selectedButton = msg.getNode()
  isButtonSelected = msg.getData()

  if isButtonSelected
    if selectedButton = "saveButton"
      m.consents["allow_data_collection"] = m.allowCollection
      m.consents["allow_data_sharing"] = m.allowSharing
      m.userConfig.consents = m.consents

      m.top.event = {
        type: "UPDATE_CONSENTS",
        data: {
          userConfig: m.userConfig,
        }
      }
    else if selectedButton = "signOutButton"
      m.top.event = {
        type: "SIGN_OUT"
      }
    end if
  end if
end sub

sub onItemSelected(msg as dynamic)
  selectedItem = msg.getNode()
  isItemSelected = msg.getData()

  if isItemSelected
    if selectedItem = "collectionConsent"
      m.allowCollection = true
    else if selectedItem = "sharingConsent"
      m.allowSharing = true
    end if
  else
    if selectedItem = "collectionConsent"
      m.allowCollection = false
    else if selectedItem = "sharingConsent"
      m.allowSharing = false
    end if
  end if
end sub

sub main(args as dynamic)
  m.screen = CreateObject("roSGSCreen")
  m.port = createObject("roMessagePort")
  m.screen.setMessagePort(m.port)
  m.scene = m.screen.CreateScene("MainScene")
  m.scene.observeField("event", m.port)
  m.screen.show()

  while true
    msg = wait(0, m.port)
    msgType = type(msg)
    if msgType = "roSGScreenEvent"
      if msg.isScreenClosed() then return
    end if
  end while
end sub
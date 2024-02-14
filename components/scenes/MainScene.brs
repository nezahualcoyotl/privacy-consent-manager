sub init()
	m.scenes = m.top.findNode("scenes")
	m.router = Router()
	m.router.initialize(m.scenes)
	m.router.navigateToScene("WelcomeScene", {}, false)
	m.background = m.top.findNode("background")
end sub

sub routingEventCallback(e)
	event = e.getData()
  print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> event " event 
end sub
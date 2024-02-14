sub init()
	m.scenes = m.top.findNode("scenes")
	m.router = Router()
	m.router.initialize(m.scenes)
	m.router.navigateToScene("WelcomeScene", {}, false)
	m.background = m.top.findNode("background")
end sub

sub routingEventCallback(e)
	event = e.getData()
	if event.type = "SIGN_UP_BUTTON_SELECTED"
		m.router.navigateToScene("SignUpScene")
	else if event.type = "BACK"
		m.router.navigateToPreviousScene()
	end if
end sub
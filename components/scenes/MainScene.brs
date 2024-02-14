sub init()
	m.scenes = m.top.findNode("scenes")
	m.router = Router()
	m.router.initialize(m.scenes)
	m.router.navigateToScene("WelcomeScene", {}, false)
	m.background = m.top.findNode("background")

	m.jsonParser = invalid
end sub

sub routingEventCallback(e)
	event = e.getData()
	if event.type = "SIGN_UP_BUTTON_SELECTED"
		m.router.navigateToScene("SignUpScene")
	else if event.type = "SIGN_IN_BUTTON_SELECTED"
		m.router.navigateToScene("SignInScene")
	else if event.type = "SIGN_IN"
		loginUser(event.data)
	else if event.type = "SIGN_UP"
		saveUser(event.data)
	else if event.type = "UPDATE_CONSENTS"
		updateConsents(event.data.userConfig)
	else if event.type = "SIGN_OUT"
		m.router.navigateToScene("WelcomeScene", {}, true)
	else if event.type = "BACK"
		m.router.navigateToPreviousScene()
	end if
end sub

sub loginUser(data as object)
	if m.jsonParser = invalid
		m.jsonParser = createObject("roSGNode", "LoginTask")
		m.jsonParser.functionName = "loginUser"
		m.jsonParser.observeField("result", "onSuccessResponse")
		m.jsonParser.observeField("error", "onErrorResponse")
		m.jsonParser.data = data
		m.jsonParser.control = "RUN"
	end if
end sub

sub updateConsents(data as object)
	if m.jsonParser = invalid
		m.jsonParser = createObject("roSGNode", "LoginTask")
		m.jsonParser.functionName = "updateConsents"
		m.jsonParser.observeField("result", "onConsentsUpdated")
		m.jsonParser.observeField("error", "onErrorResponse")
		m.jsonParser.data = data
		m.jsonParser.control = "RUN"
	end if
end sub

sub saveUser(data as object)
	if m.jsonParser = invalid
		m.jsonParser = createObject("roSGNode", "LoginTask")
		m.jsonParser.functionName = "saveUser"
		m.jsonParser.observeField("result", "onSuccessResponse")
		m.jsonParser.observeField("error", "onErrorResponse")
		m.jsonParser.data = data
		m.jsonParser.control = "RUN"
	end if
end sub

sub onSuccessResponse(msg as dynamic)
	data = msg.getData()
	destroyTask()

	print "<--------------- SIGN IN/UP SUCCESSFUL --------------->"
	if data <> invalid
		m.router.navigateToScene("ConsentScene", data.userConfig, true)
	end if
end sub

sub onConsentsUpdated(msg as dynamic)
	data = msg.getData()
	destroyTask()
	print "<--------------- CONSENTS UPDATED --------------->"
end sub

sub onErrorResponse(msg as dynamic)
	data = msg.getData()
	destroyTask()
	print "<--------------- ERROR --------------->"
end sub

function onKeyEvent(key as string, press as boolean) as boolean
	handled = false
	if press and key = "back" then
		m.router.navigateToPreviousScene()
		handled = true
	end if
	return handled
end function

sub destroyTask()
	if m.jsonParser <> invalid
		m.jsonParser.control = "STOP"
		m.jsonParser = invalid
	end if
end sub

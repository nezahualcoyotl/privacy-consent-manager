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
	else if event.type = "SIGN_IN_BUTTON_SELECTED"
		m.router.navigateToScene("SignInScene")
	else if event.type = "SIGN_IN"
		loginUser(event.data)
	else if event.type = "SIGN_UP"
		saveUser(event.data)
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
		m.jsonParser.jsonFilePath = "pkg:/source/json/usersConfig.json"
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
		m.jsonParser.jsonFilePath = "pkg:/source/json/usersConfig.json"
		m.jsonParser.data = data
		m.jsonParser.control = "RUN"
	end if
end sub

sub onSuccessResponse(msg as dynamic)
	data = msg.getData()
	destroyTask()

	if data <> invalid
		m.router.navigateToScene("ConsentScene", data)
	end if
end sub

sub onErrorResponse(msg as dynamic)
	data = msg.getData()
	destroyTask()
	stop
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

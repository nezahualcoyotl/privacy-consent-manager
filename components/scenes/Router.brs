function Router() as object
  r = {
    top: m.topRef,
    history: [],
    initialize: _initialize,
    navigateToPreviousScene: _navigateToPreviousScene,
    navigateToScene: _navigateToScene,
    clearHistory: _clearHistory,
    scenes: [],
  }
  return r
end function

function _initialize(scenes)
  m.scenes = scenes
end function

function _navigateToScene(name, data = {}, removeCurrentScene = false)
  scene = createObject("roSGNode", name)
  scene.initData = data
  scene.observeField("event", "onSceneEvent")
  if m.history.count() > 0 and removeCurrentScene then
    if removeCurrentScene = true then
      removeScene(m.history.pop())
    else
      removeScene(m.history.peek())
    end if
  else if m.history.count() > 0 then
    currentScene = m.history.peek()
    currentScene.focused = false
    currentScene.visible = false
    currentScene.unobserveField("event")
  end if
  m.history.push(scene)
  m.scenes.appendChild(scene)
  scene.setFocus(true)
  return scene
end function

sub _navigateToPreviousScene()
  if m.history.count() > 0 then
    currentScene = m.history.pop()
    currentScene.visible = false
    currentScene.unobserveField("event")
    removeScene(currentScene)
    if (m.history.count() > 0)
      previousScene = m.history.peek()
      previousScene.observeField("event", "onSceneEvent")
      previousScene.visible = true
      previousScene.setFocus(true)
    end if
  end if
end sub

sub _clearHistory()
  while (m.history.count() > 0)
    scene = m.history.pop()
    removeScene(scene)
  end while
end sub

sub removeScene(scene)
  scene.unobserveField("event")
  m.scenes.removeChild(scene)
end sub

sub onSceneEvent(e)
  event = e.getData()
  m.top.routerCallback = event
end sub

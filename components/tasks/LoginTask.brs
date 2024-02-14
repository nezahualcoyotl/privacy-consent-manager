sub init()

end sub

sub loginUser()
  fileContent = ReadAsciiFile("tmp:/usersConfig.json")
  jsonObject = ParseJson(fileContent)
  data = m.top.data

  payload = checkSavedUser(jsonObject, data)

  if payload.isValidUser
    m.top.result = {
      success: true,
      userConfig: payload.userConfig
    }
  else
    m.top.error = {
      error: true,
      details: "Invalid email or password"
    }
  end if
end sub

sub saveUser()
  fileContent = ReadAsciiFile("tmp:/usersConfig.json")
  usersBucket = ParseJson(fileContent)

  data = m.top.data
  date = createObject("roDateTime")

  payload = checkSavedUser(usersBucket, data)

  if payload.isValidUser
    m.top.error = {
      error: true,
      details: "User already exist"
    }
  else
    stateData = data.location
    configEnforced = stateData.configEnforced
    stateConfig = {
      name: stateData.title,
      code: stateData.id,
      configEnforced: configEnforced
    }

    userConfig = {
      "id": GenerateGuid(),
      "email": data.email,
      "password": data.password,
      "locationData": stateConfig,
      "time": date.asSeconds(),
      "consents": {
        "allow_data_collection": configEnforced,
        "allow_data_sharing": configEnforced
      }
    }

    if usersBucket = invalid
      usersBucket = []
    end if

    usersBucket.push(userConfig)
    success = WriteAsciiFile("tmp:/usersConfig.json", formatJson(usersBucket))

    if success
      m.top.result = {
        success: true,
        userConfig: userConfig
      }
    else
      m.top.error = {
        error: true,
        details: "Somenthing wrong happened. Try again."
      }
    end if
  end if
end sub

sub updateConsents()
  fileContent = ReadAsciiFile("tmp:/usersConfig.json")
  usersBucket = ParseJson(fileContent)

  data = m.top.data
  date = createObject("roDateTime")
  data.time = date.asSeconds()

  userIndex = getCurrentUserIndex(usersBucket, data.id)
  usersBucket[userIndex] = data

  success = WriteAsciiFile("tmp:/usersConfig.json", formatJson(usersBucket))

  if success
    m.top.result = {
      success: true
    }
  else
    m.top.error = {
      error: true,
      details: "Somenthing wrong happened. Try again."
    }
  end if
end sub

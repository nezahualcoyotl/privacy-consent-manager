sub init()

end sub

sub loginUser()
  fileContent = ReadAsciiFile(m.top.jsonFilePath)
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
  fileContent = ReadAsciiFile(m.top.jsonFilePath)
  jsonObject = ParseJson(fileContent)
  data = m.top.data
  date = createObject("roDateTime")

  payload = checkSavedUser(jsonObject, data)

  if payload.isValidUser
    m.top.error = {
      error: true,
      details: "User already exist"
    }
  else
    stateData = data.location
    locationCode = stateData.id
    configEnforced = stateData.configEnforced

    userConfig = {
      "id": GenerateGuid(),
      "email": data.email,
      "password": data.password,
      "location": locationCode,
      "time": date.asSeconds(),
      "config": {
        "allow_data_collection": configEnforced,
        "allow_data_sharing": configEnforced
      }
    }
    m.top.getScene().event = userConfig

    ' success = writeAsciiFile(m.top.jsonFilePath, formatJson(userConfig))

    ' stop
    ' if success
    '     m.top.result = {
    '         success: true,
    '     }
    ' else
    '     m.top.error = {
    '         error: true,
    '         details: "Somenthing wrong happened. Try again."
    '     }
    ' end if
  end if
end sub

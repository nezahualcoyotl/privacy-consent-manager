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

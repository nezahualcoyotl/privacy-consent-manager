sub init()
  m.top.functionName = "getStatesContent"
end sub

sub getStatesContent()
  fileContent = ReadAsciiFile("pkg:/source/json/statesConfig.json")
  jsonObject = ParseJson(fileContent)

  if jsonObject <> invalid and jsonObject.count() > 0
    m.top.result = {
      success: true,
      content: jsonObject
    }
  else
    m.top.error = {
      error: true,
      details: "Something went wrong"
    }
  end if
end sub
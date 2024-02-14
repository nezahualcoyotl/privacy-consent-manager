function checkSavedUser(response as object, userData as object) as object
  isValidUser = false
  userConfig = {}

  if response <> invalid and response.count() > 0
      for each user in response
          if user.email = userData.email
              if user.password = userData.password
                  isValidUser = true
                  userConfig = user
              end if
          end if
      end for
  end if

  return {
      isValidUser: isValidUser,
      userConfig: userConfig
  }
end function

function GenerateGuid() As String
  return GetRandomHexString(8) + "-" + GetRandomHexString(4) + "-" + GetRandomHexString(4) + "-" + GetRandomHexString(4) + "-" + GetRandomHexString(12)
End function

function GetRandomHexString(length As Integer) As String
  hexChars = "0123456789ABCDEF"
  hexString = ""
  for i = 1 to length
      hexString = hexString + hexChars.Mid(Rnd(16) - 1, 1)
  next
  return hexString
End function
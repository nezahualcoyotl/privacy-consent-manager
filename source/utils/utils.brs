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
end function

function GetRandomHexString(length as integer) as string
  hexChars = "0123456789ABCDEF"
  hexString = ""
  for i = 1 to length
    hexString = hexString + hexChars.Mid(Rnd(16) - 1, 1)
  next
  return hexString
end function

function getCurrentUserIndex(userBucket as object, userId as string) as integer
  for i = 0 to userBucket.count() - 1
    user = userBucket[i]
    if user.id = userId then return i
  end for
end function
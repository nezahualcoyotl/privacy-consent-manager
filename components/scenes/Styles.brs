function getWelcomeSceneStyles() as object
    return {
        signInButton: {
            backgroundUri: "pkg:/images/roundedRect8.9.png",
            height: 81,
            width: 282,
            focusedColor: "0xf5f5f7ff",
            unfocusedColor: "0x40445999",
            focusedTextColor: "0x404459FF",
            unfocusedTextColor: "0xf5f5f7ff",
            translation: [300, 420],
            font: "font:MediumBoldSystemFont"
        },
        signUpButton: {
            backgroundUri: "pkg:/images/roundedRect8.9.png",
            height: 81,
            width: 282,
            focusedColor: "0xf5f5f7ff",
            unfocusedColor: "0x40445999",
            focusedTextColor: "0x404459FF",
            unfocusedTextColor: "0xf5f5f7ff",
            translation: [300, 522],
            font: "font:MediumBoldSystemFont"
        }
    }
end function

function getSignUpSceneStyles() as object
    return {
        keyboard: {
            visible: false,
            translation: [270, 720],
            focusBitmapUri: "pkg:/images/roundedRect8.9.png",
            focusedKeyColor: "0x404459FF",
            keyColor: "0xf5f5f7ff",
            showTextEditBox: false,
        },
        container: {
            layoutDirection: "vert",
            horizAlignment: "left",
            translation: [300, 90],
            itemSpacings: [90, 6, 21, 6, 21, 6, 90]
        },
        titleLabel: {
            color: "0x404459FF",
            font: "font:LargeBoldSystemFont",
            horizAlign: "center",
            vertAlign: "center",
            text: "SIGN UP"
        },
        emailLabel: {
            color: "0x404459FF",
            font: "font:MediumBoldSystemFont",
            horizAlign: "center",
            vertAlign: "center",
            text: "Email"
        },
        passwordLabel: {
            color: "0x404459FF",
            font: "font:MediumBoldSystemFont",
            horizAlign: "center",
            vertAlign: "center",
            text: "Password"
        },
        emailTextBox: {
            backgroundUri: "pkg:/images/roundedRect8.9.png",
            height: 81,
            width: 900,
            hintTextColor: "0x40445999",
            textColor: "0x404459FF",
            unfocusedTextColor: "0xf5f5f7ff",
            hintText: "Enter your email",
            active: true,
            clearOnDownKey: false,
            maxTextLength: 75
        },
        passwordTextBox: {
            backgroundUri: "pkg:/images/roundedRect8.9.png",
            height: 81,
            width: 900,
            hintTextColor: "0x40445999",
            textColor: "0x404459FF",
            unfocusedTextColor: "0xf5f5f7ff",
            hintText: "Enter your password",
            clearOnDownKey: false,
            secureMode: true,
            maxTextLength: 75
        },
        saveButton: {
            backgroundUri: "pkg:/images/roundedRect8.9.png",
            height: 81,
            width: 282,
            focusedColor: "0xf5f5f7ff",
            unfocusedColor: "0x40445999",
            focusedTextColor: "0x404459FF",
            unfocusedTextColor: "0xf5f5f7ff",
            font: "font:MediumBoldSystemFont"
        },
        cancelButton: {
            backgroundUri: "pkg:/images/roundedRect8.9.png",
            height: 81,
            width: 282,
            focusedColor: "0xf5f5f7ff",
            unfocusedColor: "0x40445999",
            focusedTextColor: "0x404459FF",
            unfocusedTextColor: "0xf5f5f7ff",
            font: "font:MediumBoldSystemFont"
        },
        buttonGroup: {
            layoutDirection: "horiz",
            horizAlignment: "center",
            translation: [960, 500],
            itemSpacings: [21]
        },
        locationLabel: {
            color: "0x404459FF",
            font: "font:MediumBoldSystemFont",
            horizAlign: "center",
            vertAlign: "center",
            text: "Location"
        },
        locationBackground: {
            uri: "pkg:/images/roundedRect8.9.png",
            height: 81,
            width: 900
            unfocusedColor: "0x40445999",
            focusedColor: "0xf5f5f7ff",
        },
        stateLabel: {
            height: 81,
            width: 750,
            translation: [15, 0]
            focusedColor: "0x404459FF",
            unfocusedColor: "0xf5f5f7ff",
            horizAlign: "left",
            vertAlign: "center"
            font: "font:MediumBoldSystemFont"
        },
        statesList: {
            translation: [210, 150],
            itemSize: [440, 48],
            numRows: 15,
            color: "0xf5f5f7ff",
            focusedColor: "0x404459FF",
            vertFocusAnimationStyle: "floatingFocus"
        },
        selectedStateLabel: {
            height: 81,
            translation: [900, 300]
            color: "0x404459FF",
            horizAlign: "left",
            vertAlign: "center"
            font: "font:LargeBoldSystemFont"
        },
        saveStateButton: {
            backgroundUri: "pkg:/images/roundedRect8.9.png",
            height: 81,
            width: 282,
            translation: [900, 597],
            focusedColor: "0xf5f5f7ff",
            unfocusedColor: "0x40445999",
            focusedTextColor: "0x404459FF",
            unfocusedTextColor: "0xf5f5f7ff",
            font: "font:MediumBoldSystemFont"
        }
    }
end function
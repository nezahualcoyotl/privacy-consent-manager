# Privacy Content Manager

This is an app to manage privacy configurations for users.

## Purpose

The primary goal of the Privacy Content Manager is to read and write on a json file to read and write users configurations

## Important Notes

- The JSON file used for storing user configurations is temporary. It will be removed if the application is minimized since Instant Resume is not implemented. Therefore, user configurations and data will not persist between sessions.

## Known Issues and TODOs

- **Back-Button Handling on start**: Currently, pressing the back button immediately after launching the application does not have the intended effect.
- **Email Validation**: While the app validates the uniqueness of user emails, it does not yet validate the format of the emails.
- **Confirmation Before Saving**: Ideally, the app would ask for confirmation before saving any changes to the settings. Although this feature is not yet implemented, the app does provide feedback to inform the user that their changes have been saved.

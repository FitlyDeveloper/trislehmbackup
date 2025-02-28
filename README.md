# Fitness App Web Preview

This is a standalone web preview for the Fitness App. It provides a mock UI for previewing the app's interface without requiring Firebase or other backend services.

## How to Run

To run the web preview:

1. Navigate to this directory in your terminal:
   ```
   cd web_preview/fitness_app_web_preview
   ```

2. Run the Flutter web app:
   ```
   flutter run -d chrome
   ```

## Features

The web preview includes mock screens for:
- Login
- Sign Up
- Home
- Workout
- Profile

All Firebase functionality is mocked, so no actual authentication or data storage occurs.

## Purpose

This web preview is intended for UI development and testing only. It allows you to visualize and interact with the app's interface without needing to set up Firebase or other backend services.

## Note

This is separate from the main app to avoid Firebase Web compatibility issues. The main app is designed for iOS and Android platforms.

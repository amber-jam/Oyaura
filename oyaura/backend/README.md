# Oyaura Application Repository

Oyaura is a mobile application developed for productivity and wellness, featuring User Authentication, Mood Journals, and Goal Tracking.

## Architecture Update
This project has migrated to a Backend-as-a-Service (BaaS) architecture. The application now connects directly to a shared Supabase (PostgreSQL) cloud database via the Flutter client. 

**A local Node.js backend server is no longer required or supported.**

- **Supabase Dashboard:** [https://supabase.com/dashboard/project/zkxfwoliehxgrqybiwux/settings/general](https://supabase.com/dashboard/project/zkxfwoliehxgrqybiwux/settings/general)

## Local Development Setup

### 1. Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed and added to your system PATH.
- A compatible IDE (VS Code with Flutter/Dart extensions or Android Studio).

### 2. Installation
Clone the repository and navigate to the root project directory (where `pubspec.yaml` is located). Fetch the required Flutter dependencies:

```powershell
flutter pub get

3. Execution
To compile and run the application in development mode, execute the following command:

PowerShell
flutter run
When prompted, select a web browser (Chrome/Edge) or a connected mobile emulator. The web build is constrained to a mobile layout for accurate UI testing.
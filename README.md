# RickAndMorty iOS Application

This iOS application fetches data from the Rick and Morty API and displays a list of characters in a paginated manner. Users can filter characters by status (alive, dead, unknown) and view detailed information about each character.

## Features

### 1. **Character List Screen**
- Displays a paginated list of characters (20 characters per page).
- Each list item shows the character's:
  - Name
  - Image
  - Species
- Includes a filter to display characters by status (alive, dead, unknown).

### 2. **Character Details Screen**
- Displays detailed information about a selected character, including:
  - Name
  - Image
  - Species
  - Status
  - Gender

## Requirements
- iOS 15.6 or later
- Xcode 15 or later
- Swift 5.9 or later

## Architecture

The application is built using a **modular architecture** with the following components:

### 1. **Shared Module**
- Contains shared utilities, models, and error handling.
- Defines the `ResponseError` enum for consistent error handling across the app.

### 2. **Network Module**
- Handles API requests and responses.
- Maps API errors to `ResponseError` for consistent error handling.

### 3. **Feature Modules**
Each feature is implemented as a separate module following the **MVVM-C (Model-View-ViewModel-Coordinator)** design pattern. The main components of each feature are:

#### **Model**
- Represents the data (e.g., `Character`, `CharacterResponseModel`).

#### **View**
- Displays the UI (e.g., `CharacterListView`, `CharacterDetailView`).

#### **ViewModel**
- Handles business logic and data binding between the model and the view.
- Interacts with the network layer to fetch and filter data.

#### **Coordinator**
- Manages navigation between screens (e.g., push to `CharacterDetailView` when a character is selected).

## Installation

To get started with this application, follow these steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/ShoroukElgazar/RickAndMorty.git

2. Open the project in Xcode by navigating to the project directory and opening the .xcworkspace file:
   ```bash
    cd rick-and-morty-ios
    open RickAndMorty.xcworkspace
3. Build and run the project on a simulator or connected device.
 

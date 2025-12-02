# 🌤️ WeatherApp

![Status](https://img.shields.io/badge/Status-Work_in_Progress-yellow)
![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)
![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)
![License](https://img.shields.io/badge/License-MIT-blue.svg)

A clean and modern native iOS application developed in **Swift** to display real-time weather conditions and forecasts.

> **⚠️ Note:** This project is currently under **active development**. Some features may be incomplete or subject to change.

## 📖 Overview

This project is a personal weather application built to explore modern iOS development practices. The goal is to create a robust app that allows users to check current weather conditions, leveraging geolocation services and external weather APIs, while adhering to security best practices (managing API keys via `.xcconfig`).

<!--<p align="center">-->
<!--  <img src="path/to/screenshot.png" alt="App Screenshot" width="300">-->
<!--</p>-->

## ✨ Current Features

* 📍 **Geolocation:** Detection of the user's current location.
* ☁️ **Weather Data:** Fetches and displays current temperature and conditions using OpenWeatherMap.
* 🏙️ **City Management (CRUD):**
  * **Search & Add:** Search for any city globally and add it to your list.
  * **Persistence:** Saved cities remain available across app launches.
  * **Reorder:** Drag and drop to organize your favorite locations.
  * **Delete:** Remove cities you no longer need.
* 🔐 **Secure Configuration:** API Keys are managed via environment variables to prevent leaks.

## 🚧 Project Status & Roadmap

I am currently working on polishing the UI and adding more advanced features. Here is the plan:

* [ ] **Bug Fixing:** Resolve layout issues.
* [ ] **Error Handling:** Improve user feedback when the network is unavailable.
* [ ] **UI Polish:** Add custom icons and improve the overall design.

## 🛠️ Tech Stack

* **Language:** [Swift](https://developer.apple.com/swift/)
* **UI Framework:** SwiftUI
* **Networking:** URLSession
* **Persistence:** UserDefaults
* **Services:** CoreLocation
* **Configuration:** `.xcconfig` files for environment variables

## 🚀 Getting Started

Follow these steps to set up the project locally without build errors.

### Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/marrocumarco/WeatherApp.git
    ```

2. **Configuration (Important):**
    The project uses an `.xcconfig` file to manage secrets.
    * Locate the `Config.xcconfig.example` file in the Supporting Files folder.
    * Create a `Config.xcconfig` file.
    * Open the new file, copy the content from the example and replace `INSERT_YOUR_API_KEY_HERE` with your actual OpenWeatherMap API Key.

    > **Note:** The `Config.xcconfig` file is ignored by git to protect your API Key.

3. **Open the project:**
    * Double-click on `WeatherApp.xcodeproj`.
4. **Set Signing & Team (Required)**
    * Click on the WeatherApp project icon in the top-left Project Navigator.

    * Select the WeatherApp target from the main list.

    * Go to the "Signing & Capabilities" tab.

    * In the Team dropdown menu, select your own Personal Team (or add your Apple ID if prompted).
4.  **Run the App:**
    Select a simulator and press `Cmd + R`.

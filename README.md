
# 👨‍🍳 CookMate – Smart Recipe & Shopping Companion

**CookMate** is a modern iOS app built with SwiftUI and Firebase that helps users find delicious recipes and build personalized shopping lists — all in a seamless, beautifully designed interface.

---

## 🚀 Features

- 🔍 **Search Recipes** using Spoonacular API
- 📋 **View Detailed Recipes** with ingredients, instructions, and source link
- 🛒 **Add Ingredients to Shopping List** with 1 tap
- 🧾 **Smart Shopping List**:
  - Grouped by recipe
  - Supports checkmarks and delete
  - Syncs with Firestore
- 👤 **User Authentication** with Firebase Auth (Login/Register)
- 🌙 **Clean UI** using SwiftUI & MVVM architecture

---

## 🧠 Tech Stack

- `SwiftUI` + `MVVM`
- `Firebase Auth` + `Firestore`
- `Spoonacular API`
- `AsyncImage`, `.plist`-based API key management
- Secure secret handling via `.gitignore`

---


## 📸 Screenshots

| Home | Recipe List | Recipe Detail |
|------|-------------|----------------|
| ![Home](Screenshot/homescreen.png) | ![List](Screenshot/recipelist.png) | ![Detail](Screenshot/detailrecipe.png) |

| Shopping List | Profile | Login | Signup |
|---------------|---------|-------|--------|
| ![Shopping](Screenshot/shoppinglist.png) | ![Profile](Screenshot/profile.png) | ![Login](Screenshot/login.png) | ![Signup](Screenshot/signup.png) |



## 🔐 API Key Setup

To use this app:

1. Create a `Secrets.plist` file in the root directory
2. Add:
   ```xml
   <key>API_KEY</key>
   <string>your_api_key_here</string>
   ```

---

## 🛠 How to Run

1. **Clone the repository**  
   ```bash
   git clone https://github.com/urja1112/cookBook.git
Open the project in Xcode

Open cookBook.xcodeproj in Xcode 15 or later

Target the correct iOS version

Make sure the deployment target is iOS 16+

Configure Firebase

Add your GoogleService-Info.plist file to the project (this file is excluded from the repo for security reasons)

Set up Firebase Auth and Firestore in your Firebase console

Build and Run

Select a simulator or connected iPhone device

Press Cmd + R or click the Run button in Xcode

⚠️ Note: API keys and Firebase configurations are excluded from the repository. You must set them up locally to run the app successfully.


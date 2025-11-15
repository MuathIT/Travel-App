# 🗺️ Travel App

A Flutter app for exploring and saving your favorite trips.  
Users can browse trips (fetched from an API), add/remove favorites, and view them later in a dedicated favorites page.  
The app also integrates Firebase for authentication and data persistence.

---

## 🚀 Features
- 🔑 **Authentication** with Firebase (Login/Signup/Logout).
- 📋 **Trips List** – browse trips with images, descriptions, and ratings.
- ❤️ **Favorites** – add/remove trips from favorites using `like_button` package.
- 👤 **My Trips (Profile Replacement)** – view your trips, stats, and quick access to favorites.
- ☁️ **Firestore Sync** – favorites are stored per user in Firestore and update in real-time.
- 🎨 **Modern UI** – clean design with responsive layouts.

---

## 🖼️ Screenshots

| Take a look on the pics in the screenshots folder :) |

---

## 🛠️ Tech Stack
- **Flutter** (Dart)  
- **Firebase Authentication**  
- **Cloud Firestore**  
- **Bloc/Cubit State Management**  
- **like_button package** for favorites interaction  

---

## 📂 Project Structure

lib/
│── cubits/ # Cubits for state management
│── models/ # Data models (Trip)
│── pages/ # UI pages (Home, Favorites, Search, Splash, etc.)
│── widgets/ # Reusable widgets
│── main.dart # Entry point

---

## ⚡ Getting Started

### Prerequisites
- Install [Flutter](https://docs.flutter.dev/get-started/install)
- Setup a Firebase project and enable Authentication + Firestore.

### Installation
```bash
git clone https://github.com/your-username/trips_app.git
cd trips_app
flutter pub get
flutter run
```

---

## 🤝 Contributing

Contributions are welcome!
Feel free to fork this repo and submit a pull request.

## 📬 Contact  

If you have any questions, suggestions, or feedback, feel free to reach out:  

- GitHub: [MuathIT](https://github.com/MuathIT)  
- Email: m.alrsaini@gmail.com  
- LinkedIn: [Muath Al-Rsaini](https://www.linkedin.com/in/muath-al-rsaini-60322836b/)  

# 📦 Lost & Found Mobile Application

A **Flutter-based Lost & Found mobile application** designed to help users report, locate, and recover lost or found items efficiently using **real-time GPS tracking and map visualization**.  
The system integrates **Firebase services** for authentication and data storage, and **Google Maps** for location-based features.


 🚀 Key Features

### 1️⃣ User Authentication & Profile Management
- Secure **Email & Password authentication** using Firebase Authentication  
- User profile data (name & email) stored in **Cloud Firestore**
- Personalized greeting message displayed after successful login
- Users can update their password securely through the profile page


 2️⃣ Lost & Found Item Reporting
- Users can report **Lost** or **Found** items
- Each item includes:
  - Item name
  - Contact information
  - Status (Lost / Found)
  - GPS location selected via Google Maps
- Items are stored in **Cloud Firestore** and updated in real time


 3️⃣ Map & Location Features
- **Google Maps integration** using `google_maps_flutter`
- Displays:
  - Lost & Found item markers
  - Hazard markers
  - User’s current GPS location
- Automatically centers and zooms to relevant markers
- Supports real-time location visualization


 4️⃣ Hazard Reporting & Visualization
- Dedicated **Hazard feature** to improve user safety
- Hazards include:
  - Flood-prone areas
  - Road damage
  - Construction or dangerous zones
- Hazard data stored in **Cloud Firestore**
- Displayed on Google Maps using **distinct hazard markers**
- Helps users avoid unsafe locations when searching for items


 5️⃣ About Page
- Displays team member details:
  - Name
  - Role
  - Email
  - Profile image
- Includes a **clickable external GitHub repository link**
- Provides a brief description of the application


 6️⃣ Good UI & Design Practice
- Clean and consistent **Material Design**
- Card-based layout for better readability
- Bottom Navigation Bar for smooth navigation
- Responsive UI suitable for multiple screen sizes
- User-friendly icons and color scheme


7️⃣ Server-Side Web Application
- **Firebase Authentication** for secure user management
- **Cloud Firestore** as a server-side real-time database
- Web Admin Dashboard (for web platform)
- Firebase services act as the backend infrastructure


 🛠️ Technology Stack
- **Flutter**
- **Firebase Authentication**
- **Cloud Firestore**
- **Google Maps API**
- **Firebase Hosting**

👩‍💻 Development Team
- Wan Fatin Aisyah binti Wan Abd Malik  
- Nur Fatnin Insyirah binti Mohd Nazri  
- Syed Akmal Rizal bin Syed Shahrizal  
- Muhammad Hariz Danial bin Azman  
- Muhammad Adib Zuhair bin Roslee  

---

## 🔗 GitHub Repository
https://github.com/Twhzuww/lost_and_found_app

-

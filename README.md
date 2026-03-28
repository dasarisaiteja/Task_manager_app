# 📱 Flodo AI Task Management App

A full-stack Task Management application built using **Flutter (Frontend)** and **Django REST Framework (Backend)**.

---

## 🚀 Features

### ✅ Core Features

* Create, Read, Update, Delete (CRUD) tasks
* Task fields:

  * Title
  * Description
  * Due Date
  * Status (To-Do, In Progress, Done)
  * Blocked By (task dependency)

---

### 🧠 Smart UI Behavior

* Blocked tasks appear **greyed out**
* Smooth and responsive UI
* Loading indicator during API calls
* Prevents duplicate submissions

---

### 🔍 Search & Filter

* Search tasks by title
* Filter tasks by status

---

### ⚡ Stretch Goal Implemented

**Debounced Autocomplete Search**

* 300ms debounce using Timer
* Reduces unnecessary updates
* Improves performance and UX
* Matching text is highlighted in results

---

### 💾 Draft Persistence

* Task input is saved automatically
* Restored when user reopens form

---

## 🛠 Tech Stack

### Frontend

* Flutter (Dart)
* Provider (State Management)

### Backend

* Django
* Django REST Framework

### Database

* SQLite

---

## 📂 Project Structure

```
flodo-task-manager/
│
├── backend/        # Django API
├── frontend/       # Flutter App
├── README.md
```

---

## ⚙️ Setup Instructions

### 🔹 Backend Setup

```bash
cd backend
pip install -r requirements.txt

python manage.py makemigrations
python manage.py migrate
python manage.py runserver
```

Backend runs at:

```
http://127.0.0.1:8000/api/tasks/
```

---

### 🔹 Frontend Setup

```bash
cd frontend
flutter pub get
flutter run
```

---

### ⚠️ API URL Configuration

* For **Flutter Web (Chrome)**:

  ```
  http://127.0.0.1:8000/api/tasks/
  ```

* For **Android Emulator**:

  ```
  http://10.0.2.2:8000/api/tasks/
  ```

---

## ⏳ API Behavior

* Create & Update simulate **2-second delay**
* UI remains responsive
* Loading indicator shown
* Prevents multiple submissions

---

## 🎥 Demo Video

👉 [https://drive.google.com/file/d/1FQ_d9CyDv7a55Ck8ZTZr4-i9uJw8GAo_/view?usp=sharing]

---

## 🧠 Key Technical Decisions

* Used **Provider** for clean and scalable state management
* Implemented **debounced search** for better performance
* Designed RESTful backend using Django REST Framework
* Ensured smooth UX with async handling and loading states

---

## 🤖 AI Usage Report

### Tools Used

* ChatGPT, Cloude ai

### Helpful Prompts

* "Flutter provider CRUD API example"
* "Django REST API ViewSet example"
* "Debounce search in Flutter"

### Issue Faced

Debounce initially caused UI lag due to incorrect Timer handling.

### Fix

Cancelled previous Timer before creating a new one to ensure smooth updates.

---

## 📌 Track Selection

* **Track Chosen:** Track A (Full-Stack Builder)
* **Stretch Goal:** Debounced Autocomplete Search

---

## ⚠️ Known Notes

* Backend must be running before starting Flutter app
* Ensure correct API URL based on platform

---

## 👨‍💻 Author

**Dasari Sai Teja**

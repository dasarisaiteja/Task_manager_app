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
  * Blocked By (dependency on another task)

### 🧠 Smart UI Behavior

* Tasks that are **blocked** appear greyed out
* Smooth and responsive UI with loading states
* Prevents duplicate submissions during API calls

### 🔍 Search & Filter

* Search tasks by title
* Filter tasks by status

### ⚡ Stretch Goal Implemented

**Debounced Autocomplete Search**

* 300ms debounce implemented
* Reduces unnecessary API/UI updates
* Improves performance and UX
* Matching text is highlighted in results

### 💾 Draft Persistence

* Task input is preserved if user leaves screen accidentally

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

## ⏳ API Behavior

* All **Create & Update** operations simulate a **2-second delay**
* UI shows loading indicator during this time
* Prevents multiple submissions

---

## 🎥 Demo Video

👉 [Add your Google Drive link here]

---

## 🧠 Key Technical Decisions

* Used **Provider** for lightweight and scalable state management
* Implemented **debouncing using Timer** for efficient search
* Designed backend with **RESTful architecture**
* Ensured **non-blocking UI** during async operations

---

## 🤖 AI Usage Report

### Tools Used

* ChatGPT

### Helpful Prompts

* "How to implement debounce in Flutter using Provider?"
* "Django REST API CRUD setup"

### Issue Faced

* Initially, debounce caused UI lag due to incorrect Timer usage

### Fix

* Properly cancelled previous Timer before creating a new one

---

## 📌 Track Selection

* **Track Chosen:** Track A (Full-Stack Builder)
* **Stretch Goal:** Debounced Autocomplete Search

---

## 👨‍💻 Author

**Dasari Sai Teja**

---

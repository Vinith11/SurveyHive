# 🌍 Field Survey Data Collection App - SurveyHive 🛠️

Welcome to *SurveyHive*, a comprehensive field survey data collection app! This project consists of a **Flutter** frontend and a **Spring Boot** backend, providing efficient data collection, real-time synchronization, automated error checking, and advanced analytics for field surveys.

## 📋 Project Description

SurveyHive is designed to streamline the process of field survey data collection. The **Flutter frontend** offers a user-friendly interface for surveyors to create, manage, and submit surveys, even in offline conditions. The **Spring Boot backend** handles core functionalities like data storage, user authentication, real-time synchronization using WebSockets, automated error checking, and advanced analytics tools.

---

## 🛠 Tech Stack

### Frontend

- **Flutter**: For cross-platform mobile application development.
- **Dart**: Programming language used by Flutter.
- **Provider / Bloc**: For state management.
- **SQLite**: For local data storage in offline mode.

### Backend

- **Spring Boot**: For backend API development.
- **Hibernate**: For ORM.
- **MySQL**: For database management.
- **WebSockets**: For real-time data updates.
- **Docker**: For containerization.

---

## 📦 Prerequisites

### Frontend

- **Flutter SDK**: [Installation Guide](https://flutter.dev/docs/get-started/install)
- **Android Studio or Visual Studio Code**: For IDE support.
- **Android/iOS Device or Emulator**: To run the app.

### Backend

- **Java JDK**: Version 11 or higher [Download](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)
- **MySQL**: [Download](https://dev.mysql.com/downloads/)
- **Docker**: [Installation Guide](https://docs.docker.com/get-docker/)

---

## 🚀 Getting Started

### Step 1: Clone the Repository

```bash
git clone https://github.com/Vinith11/SurveyHack.git
cd SurveyHack
```

---

## 📱 Frontend Setup

### Step 2: Set Up Flutter Environment

1. **Install Flutter SDK**: Follow the [official guide](https://flutter.dev/docs/get-started/install) for your operating system.
2. **Set Up IDE**: Install Flutter and Dart plugins in Android Studio or Visual Studio Code.
3. **Connect Device/Emulator**: Ensure you have an Android/iOS device connected or an emulator running.

### Step 3: Navigate to Frontend Directory

```bash
cd frontend
```

### Step 4: Install Dependencies

```bash
flutter pub get
```

### Step 5: Configure Environment Variables

Create a `.env` file in the `lib` directory with the following content:

```env
API_BASE_URL=http://localhost:8080/api
WEBSOCKET_URL=ws://localhost:8080/ws
```

### Step 6: Run the Application

```bash
flutter run
```

---

## 🛠 Backend Setup

### Step 2: Set Up MySQL

1. Create a database named `survey_db`.
2. Update `src/main/resources/application.properties` with your MySQL credentials:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/survey_db
spring.datasource.username=your_mysql_username
spring.datasource.password=your_mysql_password
```

### Step 3: Build and Run the Backend

#### Using Maven

1. **Build the project**:

    ```bash
    ./mvnw clean install
    ```

2. **Run the application**:

    ```bash
    ./mvnw spring-boot:run
    ```

#### Using Docker

1. **Build and run the Docker container**:

    ```bash
    docker run --name SurveyHive -p 8080:8080 -d SurveyHive
    ```

### Step 4: Access the APIs

- **Swagger UI**: Access detailed API documentation at `http://localhost:8080/swagger-ui.html`.

- **Postman Documentation**: You can also find the API documentation at [SurveyHive Postman Docs](https://documenter.getpostman.com/view/29960479/2sAXxMhERD).

---

## 🌐 Features

### Frontend Features

- **User Authentication**: Sign up and log in with secure authentication.
- **Survey Creation**: Create new surveys with various question types.
- **Offline Support**: Collect data without an internet connection; sync when back online.
- **Real-time Updates**: Receive updates when surveys are modified.
- **Data Visualization**: View analytics and charts based on survey responses.

### Backend Features

- **API Services**: RESTful APIs for all functionalities.
- **WebSocket Communication**: For real-time data synchronization.
- **Data Validation**: Automated error checking for survey responses.
- **Scalability**: Designed to handle a large number of concurrent users.
- **Security**: Implemented using Spring Security.

---

## 🔒 Security

### Frontend

- **Input Validation**: All user inputs are validated to prevent injection attacks.
- **Secure Storage**: Sensitive data is stored securely using encryption.

### Backend

- **Spring Security**: Implemented for authentication and authorization.
- **JWT Tokens**: Used for secure user sessions.

---

## 🛠 Troubleshooting

### Frontend

- **Flutter SDK Issues**: Ensure that the Flutter SDK path is correctly set in your environment variables.
- **Dependency Conflicts**: Run `flutter pub outdated` to check for incompatible packages.
- **Device Connection**: Ensure your device/emulator is properly connected and recognized (`flutter devices`).

### Backend

- **Database Connection**: Ensure your MySQL server is running and the credentials in `application.properties` are correct.
- **Port Conflicts**: Ensure no other application is running on port `8080` or adjust the server port in `application.properties`.
- **Docker Issues**: Ensure Docker is running and you have the necessary permissions.

---

## 👥 Authors

- **Vinithkumar** - [GitHub](https://github.com/Vinith11)
- **Kartik** - [GitHub](https://github.com/kartik17k)
- **Pralhad** - [GitHub](https://github.com/Pralha17)

---

## 📚 Resources

- **Flutter Documentation**: [flutter.dev/docs](https://flutter.dev/docs)
- **Spring Boot Documentation**: [spring.io/projects/spring-boot](https://spring.io/projects/spring-boot)
- **MySQL Documentation**: [dev.mysql.com/doc](https://dev.mysql.com/doc)

---

## 🎉 Acknowledgements

- Special thanks to all contributors and testers who have helped improve this project.

---
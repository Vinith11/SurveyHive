
# 🌍 Field Survey Data Collection App - Backend 🛠️

Welcome to the backend of the **Field Survey Data Collection App**! This Spring Boot application powers the backend services for efficient data collection, real-time synchronization, automated error checking, and advanced analytics for field surveys.

## 📋 Project Description

The backend of the Field Survey Data Collection App is designed to handle the core functionalities required for field survey data collection. It provides RESTful APIs for managing surveys, responses, user authentication, real-time synchronization using WebSockets, automated error checking, and advanced analytics tools.

## 🛠 Tech Stack

- **Spring Boot**: For backend API development.
- **Hibernate**: For ORM.
- **MySQL**: For database management.
- **WebSockets**: For real-time data updates.
- **Docker**: For containerization.

## 📦 Prerequisites

- **Java JDK**: Version 11 or higher [Download](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)
- **MySQL**: [Download](https://dev.mysql.com/downloads/)
- **Docker**: [Installation Guide](https://docs.docker.com/get-docker/)
]
## 🚀 Getting Started

### Step 1: Clone the Repository

```bash
git clone https://github.com/Vinith11/SurveyHack.git
cd SurveyHack
```

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
    docker-compose up --build
    ```

### Step 4: Access the APIs

- **Swagger UI**: Access detailed API documentation at `http://localhost:8080/swagger-ui.html`.

## 🔍 Testing and Debugging

### Testing with Postman

Use Postman or any other API testing tool to test the endpoints:

- **User Authentication**:
    - `POST /api/auth/signup`
    - `POST /api/auth/login`

- **Survey Management**:
    - `GET /api/surveys`
    - `POST /api/surveys`
    - `PUT /api/surveys/{id}`
    - `DELETE /api/surveys/{id}`

- **Survey Responses**:
    - `GET /api/responses`
    - `GET /api/responses/survey/{surveyId}`
    - `POST /api/responses`
    - `PUT /api/responses/{id}`
    - `DELETE /api/responses/{id}`

- **Analytics**:
    - `GET /api/analytics/stats`
    - `GET /api/analytics/chart`

### Running Unit Tests

Run unit tests using Maven:

```bash
./mvnw test
```

## 🔒 Security

- **Spring Security**: Implemented for authentication and authorization.
- **HTTPS**: Ensure secure data transmission by configuring HTTPS.

## 🛠 Troubleshooting

- **Database Connection**: Ensure your MySQL server is running and the credentials in `application.properties` are correct.
- **Port Conflicts**: Ensure no other application is running on port `8080` or adjust the server port in `application.properties`.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Vinithkumar** - [GitHub](https://github.com/Vinith11)

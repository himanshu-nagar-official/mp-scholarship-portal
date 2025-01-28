# Madhya Pradesh Scholarship Portal

## Description
The **Madhya Pradesh Scholarship Portal** is a web application designed to simplify and streamline the scholarship application process for students. This portal helps students apply for scholarships, track application statuses, and institutes manage scholarship applications efficiently. The system is built to be secure, user-friendly, and accessible from various devices, including mobile phones, tablets, and computers. It supports student photo capturing through a webcam and includes a one-time password (OTP) security feature for password recovery. Additionally, the portal generates a PDF file for the scholarship application, making the submission process convenient and portable.

### Features
- **Student Registration & Authentication**: Allows students to register, log in, and submit scholarship applications.
- **Scholarship Application**: Provides a detailed scholarship form for students to fill out and submit for approval.
- **Application Tracking**: Enables students to track the status of their applications (approved/rejected).
- **Institute Dashboard**: Institutes can review, approve, or reject scholarship applications.
- **PDF Generation**: Generates a formatted PDF of the scholarship application for submission.
- **Webcam Integration**: Allows students to capture their photo directly from a webcam for the application.

---

## Prerequisites
Ensure the following tools are installed on your machine:
- **Java (Version 8 or above)**: Required for running the servlets and JSP components of the portal.
- **MySQL Database**: Used for storing student and scholarship data.
- **Apache Tomcat**: Servlet container to deploy the web application.
- **Web Browser**: Any modern browser such as Chrome, Firefox, or Safari.

---

## Project Structure

```
mp-scholarship-portal/
├── WEB-INF/
│   ├── classes/                        # Compiled .class files
│   ├── lib/                            # External libraries (e.g., JDBC, mail)
│   └── web.xml                         # Web configuration file
├── css/                                # Stylesheets for the portal
├── js/                                 # JavaScript files for functionality
├── jsp/                                # JSP pages for the application views
├── servlet/                            # Java servlets for business logic
│   ├── com/utils/db/                   # Database-related classes
├── static/images/                      # Static images for the portal
├── uploads/                            # Folder for uploaded files (e.g., student documents)
│   └── images/
├── .gitignore                          # Git ignore rules
└── README.md                           # Project documentation
```

---

## Installation & Setup

### Step 1: Clone the repository
Clone the project repository to your local machine:
```bash
git clone https://github.com/himanshu-nagar-official/mp-scholarship-portal.git
```

### Step 2: Set Up MySQL Database
- Import the necessary SQL schema from the `sql/` folder to set up the tables.

### Step 3: Set Up Apache Tomcat
- Download and install Apache Tomcat.
- Deploy the `mp-scholarship-portal` project in your Tomcat `webapps` folder.

### Step 4: Build and Run the Project
- Use an IDE like Eclipse or IntelliJ IDEA to run the project.
- Alternatively, compile and deploy the project manually by packaging the `war` file and deploying it to Tomcat.

### Step 5: Access the Portal
Once the project is running, navigate to:
```
http://localhost:8080/mp-scholarship-portal
```

---

## Modules and Functions

### Student Module
- **Student Registration**: Students can create an account, log in, and submit their scholarship application.
- **Password Recovery**: Students can reset their password using OTP verification.
- **Application Status Tracking**: Students can track the status of their scholarship application (approved/rejected).
- **Generate Application PDF**: Students can generate a PDF version of their scholarship application for submission.
- **Search and View Records**: Students can search their application records and view relevant institute and course details.

### Institute Module
- **Institute Authentication**: Institutes can log in to access their dashboard.
- **View Applications**: Institutes can view all applications submitted to them, including those pending approval.
- **Application Approval/Rejection**: Institutes can approve or reject scholarship applications based on eligibility.

---

## Limitations
- **Java-based**; requires a Java-compatible environment (Java 8+ and Apache Tomcat).
- The project does not yet support **multi-language** functionality (e.g., language selection for students).
- The photo capture feature for students requires a working webcam.

---

## Conclusion
The **Madhya Pradesh Scholarship Portal** offers a secure, efficient, and user-friendly platform for managing scholarship applications. It simplifies the entire process for students and institutes and reduces manual effort and paperwork.

# 🎬 Video & Category Management System (JPA + Servlet)

Một ứng dụng web quản lý danh mục và video được xây dựng trên nền tảng **Java Servlet**, **JSP** và **JPA (Hibernate)**. Hệ thống hỗ trợ phân quyền chặt chẽ (RBAC) cho Admin, Manager và User, tích hợp giao diện Dashboard hiện đại và trang chủ phong cách Gallery.

![Java](https://img.shields.io/badge/Java-17%2B-orange)
![JPA](https://img.shields.io/badge/JPA-Hibernate-green)
![Servlet](https://img.shields.io/badge/Servlet-Jakarta%20EE-blue)
![Database](https://img.shields.io/badge/Database-SQL%20Server-lightgrey)
![Frontend](https://img.shields.io/badge/Frontend-Bootstrap%205-purple)

## 🌟 Tính năng chính

### 1. Phân quyền (Role-Based Access Control)
Hệ thống phân chia 3 vai trò người dùng với quyền hạn khác nhau:
* **Admin (Role 3):**
    * Toàn quyền quản lý (CRUD) tất cả Category và Video trong hệ thống.
    * Truy cập trang quản trị (Admin Dashboard).
* **Manager (Role 2):**
    * Chỉ được quản lý (CRUD) các Category và Video **do chính mình tạo ra**.
    * Có giao diện quản trị riêng (Manager Dashboard).
* **User (Role 1):**
    * Xem danh sách Category dạng lưới (Gallery Style).
    * Xem danh sách Video thuộc từng Category.
    * Không có quyền truy cập trang quản trị.

### 2. Chức năng chi tiết
* **Authentication:** Đăng nhập, Đăng ký, Đăng xuất, "Remember Me" (Cookie), Quên mật khẩu.
* **Category Management:**
    * Thêm, Sửa, Xóa danh mục.
    * Upload ảnh đại diện cho danh mục.
* **Video Management:**
    * Thêm, Sửa, Xóa video.
    * Upload Poster và File Video (.mp4).
    * Tìm kiếm video theo tiêu đề.
    * Lọc video theo danh mục.
* **Profile:** Cập nhật thông tin cá nhân, đổi ảnh đại diện (Avatar).
* **Giao diện:**
    * Sử dụng **SiteMesh 3** để quản lý Layout (Decorator).
    * **Admin/Manager:** Giao diện Dashboard hiện đại, thống kê.
    * **User:** Giao diện Minimalist Luxury (giống Dior) với ảnh tràn màn hình.

## 🛠️ Công nghệ sử dụng

* **Backend:** Java Servlet, Jakarta EE.
* **ORM:** JPA 3.0 (Hibernate Implementation).
* **Database:** SQL Server.
* **Frontend:** JSP, JSTL, Bootstrap 5, FontAwesome.
* **Template Engine:** SiteMesh 3.
* **Build Tool:** Maven.
* **Server:** Apache Tomcat 10.1+.

## 🚀 Cài đặt và Chạy dự án

### 1. Yêu cầu hệ thống
* JDK 11 trở lên (khuyến nghị JDK 17).
* Apache Tomcat 10.1 (hỗ trợ Jakarta EE).
* Microsoft SQL Server.

### 2. Cấu hình Database
1.  Tạo database mới trong SQL Server tên là `jpact4st6` (hoặc tên tùy chọn).
2.  Mở file `src/main/resources/META-INF/persistence.xml`, cập nhật thông tin kết nối:
    ```xml
    <property name="jakarta.persistence.jdbc.url" value="jdbc:sqlserver://YOUR_SERVER;databaseName=jpact4st6;..." />
    <property name="jakarta.persistence.jdbc.user" value="sa" />
    <property name="jakarta.persistence.jdbc.password" value="your_password" />
    ```
3.  Ở lần chạy đầu tiên, Hibernate sẽ tự động tạo bảng (`hbm2ddl.auto` = `update`).

### 3. Cấu hình thư mục Upload
Dự án lưu trữ file (ảnh/video) ở thư mục ngoài server để tránh mất dữ liệu khi redeploy.
1.  Tạo thư mục trên ổ đĩa, ví dụ: `C:\upload`.
2.  Cập nhật đường dẫn trong file `ltweb.util.Constant.java`:
    ```java
    public static final String DIR = "C:\\upload";
    ```

### 4. Chạy ứng dụng
1.  Clone dự án về máy.
2.  Mở trong Eclipse/IntelliJ IDEA.
3.  Chuột phải project -> **Run As** -> **Run on Server**.
4.  Truy cập: `http://localhost:8080/JPAExample/`

## 👤 Tài khoản mặc định (Data Seeding)
Khi server khởi động lần đầu, hệ thống sẽ tự động tạo 2 tài khoản mẫu (admin và manager, còn user tạo bằng cách đăng kí tài khoản nhé):

| Role | Username | Password |
| :--- | :--- | :--- |
| **Admin** | `admin` | `123` |
| **Manager** | `manager` | `123` |

## 📂 Cấu trúc dự án

````
src/main/java
├── ltweb.config       \# Cấu hình JPA, DatabaseInitializer
├── ltweb.controller   \# Servlet Controllers (Admin, Manager, User)
├── ltweb.entity       \# JPA Entities (User, Category, Video)
├── ltweb.filter       \# AuthorizationFilter (Phân quyền), SiteMesh
├── ltweb.repository   \# Data Access Layer (DAO)
├── ltweb.service      \# Business Logic Layer
└── ltweb.util         \# Constants

src/main/webapp
├── common             \# Header, Footer (Admin/Web)
├── views              \# Các trang JSP (admin, user, manager)
├── WEB-INF
│    ├── decorators    \# Layouts (admin.jsp, web.jsp)
│    ├── sitemesh3.xml \# Cấu hình layout
│    └── web.xml       \# Cấu hình Servlet/Filter
````

## 🖼️ Screenshots

### 1. Giao diện User (Home - Gallery Style)
![User Home](https://via.placeholder.com/800x400?text=User+Gallery+Interface)

### 2. Giao diện Admin/Manager (Dashboard)
![Admin Dashboard](https://via.placeholder.com/800x400?text=Admin+Dashboard)

### 3. Quản lý Video (Có lọc và tìm kiếm)
![Video Management](https://via.placeholder.com/800x400?text=Video+List)

---
© 2025 Developed by QangLam - FIT HCMUTE

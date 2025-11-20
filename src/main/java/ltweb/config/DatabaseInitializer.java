package ltweb.config;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import ltweb.entity.User;
import ltweb.repository.UserRepository;
import ltweb.repository.impl.UserRepositoryImpl;

@WebListener
public class DatabaseInitializer implements ServletContextListener {
	
	UserRepository userRepo = new UserRepositoryImpl();
	
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		System.out.println("Database initialized.");
		
		if (userRepo.findByUsername("admin") == null) {
			// Tạo tài khoản admin mặc định nếu chưa tồn tại
			User admin = new User();
			admin.setUsername("admin");
            admin.setPassword("123");
            admin.setEmail("admin@gmail.com");
            admin.setFullname("Quản Trị Viên");
            admin.setPhone("0999999999");
            admin.setRoleid(3);
            admin.setCreateddate(new java.sql.Date(System.currentTimeMillis()));
            
            userRepo.insert(admin);
            System.out.println("Default admin account created.");
		}
		
		if (userRepo.findByUsername("manager") == null) {
			// Tạo tài khoản admin mặc định nếu chưa tồn tại
			User manager = new User();
			manager.setUsername("manager");
			manager.setPassword("123");
			manager.setEmail("managergpt@gmail.com");
			manager.setFullname("Quản lý GPT");
			manager.setPhone("0888888888");
			manager.setRoleid(2);
			manager.setCreateddate(new java.sql.Date(System.currentTimeMillis()));
            
            userRepo.insert(manager);
            System.out.println("Default manager account created.");
		}
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		System.out.println("Database connection closed.");
	}

}

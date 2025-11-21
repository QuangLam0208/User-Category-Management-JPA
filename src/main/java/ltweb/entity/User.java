package ltweb.entity;

import java.sql.Date;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name = "users")
public class User {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(columnDefinition="NVARCHAR(50)")
	private String email;
	
	@Column(columnDefinition="NVARCHAR(100)")
	private String fullname;
	
	@Column(columnDefinition="NVARCHAR(50)")
	private String username;
	
	@Column(columnDefinition="NVARCHAR(255)")
	private String password;
	
	@Column(columnDefinition="NVARCHAR(255)")
	private String images;
	
	@Column
	private int roleid;
	
	@Column
	private int active;
	
	@Column(columnDefinition="VARCHAR(20)")
	private String phone;
	
	@Column
	private Date createddate;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
	@ToString.Exclude
	private List<Category> categories;
}

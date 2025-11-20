package ltweb.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

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
	@Column(columnDefinition="NVARCHAR(50)")
	private String fullname;
	@Column(columnDefinition="NVARCHAR(50)")
	private String username;
	@Column(columnDefinition="NVARCHAR(50)")
	private String password;
}

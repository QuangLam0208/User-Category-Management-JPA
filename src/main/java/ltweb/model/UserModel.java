package ltweb.model;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class UserModel implements Serializable {

	private static final long serialVersionUID = 1L;

	private int id;

	private String email;

	private String fullname;
	
	private String username;

	private String password;
	
	private String images;
	
	private int roleid;
	
	private int active;
	
	private String phone;
	
	private Date createddate;
}

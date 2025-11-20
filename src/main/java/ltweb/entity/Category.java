package ltweb.entity;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

public class Category {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column
	private int id;
	
	@Column(columnDefinition="NVARCHAR(255)")
	private String name;
	
	@Column(columnDefinition="NVARCHAR(255)")
	private String images;
	
	@ManyToOne
	@JoinColumn(name = "userid")
	private User user;
}

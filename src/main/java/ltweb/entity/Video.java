package ltweb.entity;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name = "videos")
public class Video implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column
	private int id;
	
	@Column(columnDefinition="NVARCHAR(255)")
	private String title;
	
	@Column(columnDefinition="NVARCHAR(255)")
	private String poster;
	
	@Column
	private int views;
	
	@Column(columnDefinition="NVARCHAR(500)")
	private String description;
	
	@Column
	private int active;
	
	@ManyToOne
	@JoinColumn(name = "categoryid")
	private Category category;
}

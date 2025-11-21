package ltweb.entity;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
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
@Table(name = "category")
public class Category {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column
	private int id;
	
	@Column(columnDefinition="NVARCHAR(255)")
	private String name;
	
	@Column(columnDefinition="NVARCHAR(255)")
	private String images;
	
	@Column
	private int active;
	
	@ManyToOne
	@JoinColumn(name = "userid")
	private User user;
	
	@OneToMany(mappedBy = "category", fetch = FetchType.EAGER)
	@ToString.Exclude
	private List<Video> videos;
}

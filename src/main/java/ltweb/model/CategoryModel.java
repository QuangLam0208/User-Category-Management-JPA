package ltweb.model;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CategoryModel implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private int id;
	
	private String name;
	
	private String images;
	
	private int active;
	
	private int userid;
	
}

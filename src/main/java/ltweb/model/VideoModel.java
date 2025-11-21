package ltweb.model;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class VideoModel implements Serializable {

	private static final long serialVersionUID = 1L;

	private int id;

	private String title;

	private String poster;

	private int views;

	private String description;

	private int active;

	private int categoryid;

}

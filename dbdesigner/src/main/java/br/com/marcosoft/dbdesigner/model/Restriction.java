package br.com.marcosoft.dbdesigner.model;

import org.apache.commons.lang.builder.ToStringBuilder;

public class Restriction {
	private String type;
	private String columns;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getColumns() {
		return columns;
	}

	public void setColumns(String columns) {
		this.columns = columns;
	}
	
	@Override
	public String toString() {
		return new ToStringBuilder(this)
			.append(type)
			.append(columns)
			.toString();
	}
}

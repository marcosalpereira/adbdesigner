package br.com.marcosoft.dbdesigner.model;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

public class Restriction implements Serializable {
    private static final long serialVersionUID = 1390890516326650550L;

	private String name;
	private String type;
	private String columns;
	private Table table;

	public String getName() {
	    return name;
    }

	public void setName(String name) {
	    this.name = name;
    }

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

	public void setTable(Table table) {
		this.table = table;
    }

	public Table getTable() {
	    return table;
    }
}

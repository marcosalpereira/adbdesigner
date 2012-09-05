package br.com.marcosoft.dbdesigner.model;

import java.io.Serializable;

public class Index implements Serializable {

    private static final long serialVersionUID = 7595691409783362896L;
	private String name;
	private String columns;
	private boolean unique = false;
	private Table table;

	public Table getTable() {
		return table;
	}

	public void setTable(Table table) {
		this.table = table;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getColumns() {
		return columns;
	}

	public void setColumns(String columns) {
		this.columns = columns;
	}

	public boolean isUnique() {
		return unique;
	}

	public void setUnique(boolean unique) {
		this.unique = unique;
	}

	@Override
	public String toString() {
		return name;
	}
}

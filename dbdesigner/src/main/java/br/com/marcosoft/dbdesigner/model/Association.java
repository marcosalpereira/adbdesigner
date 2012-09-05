package br.com.marcosoft.dbdesigner.model;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

public class Association implements Serializable {
	private static final long serialVersionUID = 5520602823629349442L;
	private Table otherTable;
	private String columnsHere;
	private String columnsThere;
	private Table table;

	public Table getTable() {
		return table;
	}

	public void setTable(Table table) {
		this.table = table;
	}

	public Table getOtherTable() {
		return otherTable;
	}

	public void setOtherTable(Table otherTable) {
		this.otherTable = otherTable;
	}

	public String getColumnsHere() {
		return columnsHere;
	}

	public void setColumnsHere(String columnsHere) {
		this.columnsHere = columnsHere;
	}

	public String getColumnsThere() {
		return columnsThere;
	}

	public void setColumnsThere(String columnsThere) {
		this.columnsThere = columnsThere;
	}

	@Override
	public String toString() {
		return new ToStringBuilder(this).append(otherTable).append(columnsHere).toString();
	}
}

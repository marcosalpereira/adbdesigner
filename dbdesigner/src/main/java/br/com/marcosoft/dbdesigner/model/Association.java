package br.com.marcosoft.dbdesigner.model;

import org.apache.commons.lang.builder.ToStringBuilder;

public class Association {
	private Table otherTable;
	private String columnsHere;
	private String columnsThere;
	
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
		return new ToStringBuilder(this)
			.append(otherTable)
			.append(columnsHere)
			.toString();
	}
}

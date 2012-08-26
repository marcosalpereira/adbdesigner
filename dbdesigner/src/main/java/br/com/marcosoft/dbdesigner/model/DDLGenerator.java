package br.com.marcosoft.dbdesigner.model;

import java.util.Collection;
import java.util.Iterator;
import java.util.List;

public class DDLGenerator {
	
	private StringBuilder out;

	public DDLGenerator(StringBuilder out) {
		this.out = out;
	}

	public void generate(Collection<Table> tables) {
		for (Table table : tables) {
			generate(table);
		}
	}

	private void generate(Table table) {
		generateCreateTable(table);
		generateColumns(table.getColumns());
		out.append(")");
		
	}

	private void generateColumns(List<Column> columns) {
		for (Iterator<Column> iterator = columns.iterator(); iterator.hasNext();) {
			generateColumn(iterator.next());
			if (iterator.hasNext()) {
				out.append(",");
			}
		}
	}

	private void generateColumn(Column column) {
		out.append(column.getName());

		out.append(" ");
		out.append(column.getType());
		
		out.append(" ");
		if (column.getDecimals() != null) {
			out.append("(" + column.getLength() + "," + column.getDecimals() + ")");
		} else {
			out.append("(" + column.getLength() + ")");
		}
		
		if (column.getDefaultValue() != null) {
			out.append(" ");
			out.append(column.getDefaultValue());
		}

		if (column.isNullable()) {
			out.append(" NULL");
		} else {
			out.append(" NOT NULL");
		}
		
		if (column.isPk()) {
			out.append(" PRIMARY KEY");
		}
	}

	private void generateCreateTable(Table table) {
		out.append("CREATE TABLE " + table.getFullName() + " (");
	}
}

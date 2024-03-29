package br.com.marcosoft.dbdesigner.ddl.postgres;

import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import br.com.marcosoft.dbdesigner.model.Association;
import br.com.marcosoft.dbdesigner.model.Column;
import br.com.marcosoft.dbdesigner.model.Database;
import br.com.marcosoft.dbdesigner.model.Index;
import br.com.marcosoft.dbdesigner.model.Restriction;
import br.com.marcosoft.dbdesigner.model.Table;

public class DDLGenerator {

	private final StringBuilder out;

	public DDLGenerator(StringBuilder out) {
		this.out = out;
	}

	public void generate(Database database) {
		final Collection<Table> tables = database.getTables();

		for (final Table table : tables) {
			generateTable(table);
			out.append("\n");
		}
		for (final Table table : tables) {
			generateAssociations(table);
			out.append("\n");
		}

		generateEndScript(database);
	}

	private void generateEndScript(Database database) {
	    if (database.getEndScript() != null) {
			out.append("\n");
			out.append(database.getEndScript());
		}
    }

	private void generateAssociations(Table table) {
		final List<Association> associations = table.getAssociations();
		int i=1;
		for (final Association association : associations) {
			out.append("\n\nALTER TABLE " + table.getFullName());
			final String constraintName = "FK_" + table.getName() + "_" + i++;
			out.append("\n  ADD CONSTRAINT " + constraintName );
			out.append("\n      FOREIGN KEY (" + association.getColumnsHere() + ")");
			out.append("\n      REFERENCES " + association.getOtherTable().getFullName()
					+ " (" + association.getColumnsThere() + ");");
        }

    }

	private void generateTable(Table table) {
		generateCreateTable(table);
		generateColumns(table.getColumns());
		generatePrimaryKey(table);
		generateRestrictions(table);
		out.append("\n);");

		generateIndexes(table);

	}

	private void generateRestrictions(Table table) {
	    for (final Restriction restriction : table.getRestrictions()) {
	    	if ("unique".equals(restriction.getType())) {
				out.append("\n\t, CONSTRAINT " + restriction.getName()
						+ " UNIQUE (" + restriction.getColumns() + ")");
	    	}
	    }
    }

	private void generateIndexes(Table table) {
		if (!table.getIndexes().isEmpty()) {
			out.append("\n");
		}
	    for (final Index index : table.getIndexes()) {
			out.append("\nCREATE INDEX "
					+ index.getName() + " ON " + table.getFullName()
					+ "(" + index.getColumns() + ");");
	    }
	    if (!table.getIndexes().isEmpty()) {
			out.append("\n");
	    }
    }

	private void generatePrimaryKey(Table table) {
	    final String pks = table.getPrimaryKeys();
	    if (pks != null) {
	    	out.append("\n\t, PRIMARY KEY (" + pks + ")");
	    }
    }

	private void generateColumns(List<Column> columns) {
		out.append("\n\t  ");
		for (final Iterator<Column> iterator = columns.iterator(); iterator.hasNext();) {
			generateColumn(iterator.next());
			if (iterator.hasNext()) {
				out.append("\n\t, ");
			}
		}
	}

	private void generateColumn(Column column) {
		out.append(column.getName());

		out.append(" ");
		out.append(column.getType());

		if (column.getScale() != null) {
			out.append("(" + column.getPrecision() + "," + column.getScale() + ")");
		} else {
			if (column.isStringType()) {
				out.append("(" + column.getPrecision() + ")");
			} else {
				if (column.getPrecision() != null) {
					out.append(" " + column.getPrecision());
				}
			}
		}

		if (column.getDefaultValue() != null) {
			out.append(" DEFAULT ");
			out.append(column.getDefaultValue());
		}

		if (column.isNullable()) {
			out.append(" NULL");
		} else {
			out.append(" NOT NULL");
		}

		final Restriction uniqueRestriction = column.getUniqueRestriction();
		if (uniqueRestriction != null) {
			out.append(" CONSTRAINT " + uniqueRestriction.getName() + " UNIQUE");
		}

	}

	private void generateCreateTable(Table table) {
		out.append("CREATE TABLE " + table.getFullName() + " (");
	}
}

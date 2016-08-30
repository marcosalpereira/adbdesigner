package br.com.marcosoft.dbdesigner.action;

import java.awt.event.ActionEvent;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.swing.AbstractAction;
import javax.swing.JOptionPane;
import javax.xml.bind.JAXBException;

import br.com.marcosoft.dbdesigner.model.Association;
import br.com.marcosoft.dbdesigner.model.Column;
import br.com.marcosoft.dbdesigner.model.Database;
import br.com.marcosoft.dbdesigner.model.Index;
import br.com.marcosoft.dbdesigner.model.Restriction;
import br.com.marcosoft.dbdesigner.model.Table;
import br.com.marcosoft.dbdesigner.view.DBDesignerGraph;

@SuppressWarnings("serial")
public class SaveAction extends AbstractAction {

	public void actionPerformed(ActionEvent event) {
		final DBDesignerGraph dbDesignerGraph = (DBDesignerGraph) event.getSource();
		final Database database = dbDesignerGraph.getDatabase();

		try {
	        gravarXml(database);
        } catch (final Exception e) {
        	JOptionPane.showMessageDialog(null, e.getMessage());
        	e.printStackTrace();
        }

	}

	private void gravarXml(Database database) throws JAXBException, IOException {

		final String fileName = database.getFile().getAbsolutePath() + ".xml";
		System.out.println(fileName);
		final FileWriter fileWriter = new FileWriter(fileName);
		fileWriter.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
		beginTagDatabase(fileWriter, database);
		final List<Table> tables = new ArrayList<Table>(database.getTables());
		Collections.sort(tables, Table.ORDER_COMPARATOR);

		for (final Table table : tables) {
			beginTagTable(fileWriter, table);
			for (final Column column : table.getColumns()) {
				writeTagColumn(fileWriter, column);
			}
			endTagTable(fileWriter, table);

			for (final Index index : table.getIndexes()) {
				writeTagIndex(fileWriter, index);
            }

			for (final Restriction restriction : table.getRestrictions()) {
				writeTagRestriction(fileWriter, restriction);
			}
		}

		for (final Table table : tables) {
			for (final Association association : table.getAssociations()) {
				writeTagAssociation(fileWriter, association);
			}
		}

		endTagDatabase(fileWriter, database);

		fileWriter.close();
	}

	private void writeTagRestriction(FileWriter fileWriter, Restriction restriction) throws IOException {
		fileWriter.append("<restriction");
		writeAttribute(fileWriter, "type", restriction.getType());
		writeAttribute(fileWriter, "columns", restriction.getColumns());
		writeAttribute(fileWriter, "name", restriction.getName());
		writeAttribute(fileWriter, "table", restriction.getTable().getFullName());
		fileWriter.append(" />\n");
    }

	private void writeAttribute(FileWriter fileWriter, String name, boolean value) throws IOException {
		writeAttribute(fileWriter, name, value + "");
	}

	private void writeAttribute(FileWriter fileWriter, String name, Integer value) throws IOException {
		if (value == null) return;
		writeAttribute(fileWriter, name, value + "");
	}
	private void writeAttribute(FileWriter fileWriter, String name, String value) throws IOException {
		if (value == null) return;
		fileWriter.append(' ');
		fileWriter.append(name);
		fileWriter.append("=\"");
		fileWriter.append(value);
		fileWriter.append("\"");
    }

	private void writeTagAssociation(FileWriter fileWriter, Association association)
	        throws IOException {
		fileWriter.append("<association");
		writeAttribute(fileWriter, "other-table", association.getOtherTable().getFullName());
		writeAttribute(fileWriter, "table", association.getTable().getFullName());
		writeAttribute(fileWriter, "columns-here", association.getColumnsHere());
		writeAttribute(fileWriter, "columns-there", association.getColumnsThere());
		fileWriter.append(" />\n");
	}

	private void writeTagIndex(FileWriter fileWriter, Index index) throws IOException {
		fileWriter.append("<index");
		writeAttribute(fileWriter, "name", index.getName());
		writeAttribute(fileWriter, "table", index.getTable().getFullName());
		writeAttribute(fileWriter, "columns", index.getColumns());
		fileWriter.append(" />\n");
    }

	private void endTagTable(FileWriter fileWriter, Table table) throws IOException {
	    fileWriter.append("</table>\n");
    }

	private void writeTagColumn(FileWriter fileWriter, Column column) throws IOException {
		fileWriter.append("<column");
		writeAttribute(fileWriter, "name", column.getName());
		writeAttribute(fileWriter, "type", column.getType());
		if (column.isPk()) {
			writeAttribute(fileWriter, "pk", "true");
		}
		writeAttribute(fileWriter, "precision", column.getPrecision());
		writeAttribute(fileWriter, "scale", column.getScale());
		writeAttribute(fileWriter, "default", column.getDefaultValue());
		if (!column.isNullable()) {
			writeAttribute(fileWriter, "nullable", column.isNullable());
		}
		final Restriction uniqueRestriction = column.getUniqueRestriction();
		if (uniqueRestriction != null) {
			writeAttribute(fileWriter, "unique-restriction", uniqueRestriction.getName());
		}
		fileWriter.append(" />\n");
    }

	private void beginTagTable(FileWriter fileWriter, Table table) throws IOException {
		fileWriter.append("<table");
		writeAttribute(fileWriter, "name", table.getName());
		writeAttribute(fileWriter, "schema", table.getSchema());
		writeAttribute(fileWriter, "tags", table.getTags());
		writeAttribute(fileWriter, "order", table.getOrder());
		writeAttribute(fileWriter, "x", table.getX());
		writeAttribute(fileWriter, "y", table.getY());
		writeAttribute(fileWriter, "width", table.getWidth());
		fileWriter.append(">\n");
    }

	private void endTagDatabase(FileWriter fileWriter, Database database) throws IOException {
		fileWriter.append("</database>\n");
    }

	private void beginTagDatabase(FileWriter fileWriter, Database database) throws IOException {
		fileWriter.append("<database");
		final String endScript = database.getEndScript();
		if (endScript != null) {
			writeAttribute(fileWriter, "end-script",
					endScript
						.replaceAll("\r", "")
						.replaceAll("\n", "&#10;")
			);
		}
		fileWriter.append(">\n");
    }

}

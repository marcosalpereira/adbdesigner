package br.com.marcosoft.dbdesigner;

import java.io.File;
import java.io.IOException;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import br.com.marcosoft.dbdesigner.model.Association;
import br.com.marcosoft.dbdesigner.model.Column;
import br.com.marcosoft.dbdesigner.model.Database;
import br.com.marcosoft.dbdesigner.model.Index;
import br.com.marcosoft.dbdesigner.model.Restriction;
import br.com.marcosoft.dbdesigner.model.Table;

public class ParseDatabase {
	private Database database;
	private Table table;
	private Column column;

	public Database parse(File file) {
		// get a factory
		SAXParserFactory spf = SAXParserFactory.newInstance();
		try {

			// get a new instance of parser
			SAXParser sp = spf.newSAXParser();

			// parse the file and also register this class for call backs
			sp.parse(file, new Parser());

		} catch (SAXException se) {
			se.printStackTrace();
		} catch (ParserConfigurationException pce) {
			pce.printStackTrace();
		} catch (IOException ie) {
			ie.printStackTrace();
		}
		return database;
	}

	private class Parser extends DefaultHandler {

		private Restriction restriction;
		private Index index;
		private Association association;

		@Override
		public void startElement(String uri, String localName, String qName,
				Attributes attributes) throws SAXException {

			if (qName.equals("database")) {
				parseDatabaseElement(attributes);

			} else if (qName.equals("table")) {
				parseTableElement(attributes);

			} else if (qName.equals("column")) {
				parseColumnElement(attributes);

			} else if (qName.equals("association")) {
				parseAssociationElement(attributes);

			} else if (qName.equals("index")) {
				parseIndexElement(attributes);

			} else if (qName.equals("restriction")) {
				parseRestrictionElement(attributes);
			}
		}

		private void parseRestrictionElement(Attributes attributes) {
			restriction = new Restriction();
			table.getRestrictions().add(restriction);
			
			for (int i = 0; i < attributes.getLength(); i++) {
				String attributeName = attributes.getQName(i);
				String attributeValue = attributes.getValue(i);

				if ("type".equals(attributeName)) {
					restriction.setType(attributeName);

				} else if ("columns".equals(attributeName)) {
					restriction.setColumns(attributeValue);
				}
			}

		}

		private void parseIndexElement(Attributes attributes) {
			index = new Index();
			table.getIndexes().add(index);
			
			for (int i = 0; i < attributes.getLength(); i++) {
				String attributeName = attributes.getQName(i);
				String attributeValue = attributes.getValue(i);

				if ("name".equals(attributeName)) {
					index.setName(attributeValue);

				} else if ("columns".equals(attributeName)) {
					index.setColumns(attributeValue);
				}
			}
		}

		private void parseAssociationElement(Attributes attributes) {
			association = new Association();
			table.getAssociations().add(association);
			
			for (int i = 0; i < attributes.getLength(); i++) {
				String attributeName = attributes.getQName(i);
				String attributeValue = attributes.getValue(i);

				if ("otherTable".equals(attributeName)) {
					association.setOtherTable(database.findTable(attributeValue));

				} else if ("columnsHere".equals(attributeName)) {
					association.setColumnsHere(attributeValue);

				} else if ("columnsThere".equals(attributeName)) {
					association.setColumnsThere(attributeValue);
				}
			}
		}

		private void parseColumnElement(Attributes attributes) {
			column = new Column();
			table.getColumns().add(column);

			for (int i = 0; i < attributes.getLength(); i++) {
				String attributeName = attributes.getQName(i);
				String attributeValue = attributes.getValue(i);

				if ("name".equals(attributeName)) {
					column.setName(attributeValue);

				} else if ("order".equals(attributeName)) {
					column.setOrder(parseInt(attributeValue, 0));

				} else if ("default".equals(attributeName)) {
					column.setDefaultValue(attributeValue);

				} else if ("nullable".equals(attributeName)) {
					column.setNullable(parseBoolean(attributeValue, true));
					
				} else if ("pk".equals(attributeName)) {
					column.setPk(parseBoolean(attributeValue, false));

				} else if ("type".equals(attributeName)) {
					column.setType(attributeValue);

				} else if ("length".equals(attributeName)) {
					column.setLength(parseInt(attributeValue, null));

				} else if ("decimals".equals(attributeName)) {
					column.setDecimals(parseInt(attributeValue, null));
				}

			}

		}

		private boolean parseBoolean(String attributeValue, boolean errorValue) {
			try {
				return Boolean.parseBoolean(attributeValue);
			} catch (NumberFormatException e) {
				return errorValue;
			}
		}

		private void parseTableElement(Attributes attributes) {
			table = new Table();

			for (int i = 0; i < attributes.getLength(); i++) {
				String attributeName = attributes.getQName(i);
				String attributeValue = attributes.getValue(i);

				if ("name".equals(attributeName)) {
					table.setName(attributeValue);

				} else if ("schema".equals(attributeName)) {
					table.setSchema(attributeValue);

				} else if ("tags".equals(attributeName)) {
					table.setTags(attributeValue);

				} else if ("order".equals(attributeName)) {
					table.setOrder(parseInt(attributeValue, 0));
					
				} else if ("x".equals(attributeName)) {
					table.setX(parseInt(attributeValue, 0));

				} else if ("y".equals(attributeName)) {
					table.setY(parseInt(attributeValue, 0));
					
				}

			}
			database.addTable(table);

		}

		private int parseInt(String value, Integer errorValue) {
			try {
				return Integer.parseInt(value);
			} catch (NumberFormatException e) {
				return errorValue;
			}
		}

		private void parseDatabaseElement(Attributes attributes) {
			database = new Database();
		}

	}



}
package br.com.marcosoft.dbdesigner.model;

import java.io.File;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class Database {
	static {
		ToStringBuilder.setDefaultStyle(ToStringStyle.SHORT_PREFIX_STYLE);
	}

	private final Map<String, Table> tables = new HashMap<String, Table>();

	private final File file;

	private String endScript;

	public Database() {
		file = null;
	}

	public Database(File file) {
	    this.file = file;
    }

	public String getEndScript() {
	    return endScript;
    }

	public void setEndScript(String endScript) {
	    this.endScript = endScript;
    }

	public File getFile() {
	    return file;
    }

	public Collection<Table> getTables() {
		return Collections.unmodifiableCollection(tables.values());
	}

	@Override
	public String toString() {
		return tables.toString();
	}

	public void addTable(Table table) {
		tables.put(table.getFullName(), table);
	}

	public Table findTable(String name) {
		return tables.get(name);
	}

}

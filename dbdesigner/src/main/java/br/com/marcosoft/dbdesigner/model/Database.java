package br.com.marcosoft.dbdesigner.model;

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
	
	private Map<String, Table> tables = new HashMap<String, Table>();

	public Collection<Table> getTables() {
		return Collections.unmodifiableCollection(tables.values());
	}

	@Override
	public String toString() {
		return tables.toString();
	}
	
	public void addTable(Table table) {
		tables.put(table.getName(), table);
	}
	
	public Table findTable(String name) {
		return tables.get(name);
	}
	
}

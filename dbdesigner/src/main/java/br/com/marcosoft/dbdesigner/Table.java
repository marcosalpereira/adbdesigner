package br.com.marcosoft.dbdesigner;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class Table implements Comparable<Table> {
	private String name;
	private String id;
	private List<Table> associations = new ArrayList<Table>();
	private Map<String,String> attributes = new HashMap<String, String>();
	private final Set<Table> parents = new HashSet<Table>();

	public Table() {

	}
	public Table(String tableName, String id) {
		super();
		this.name = tableName;
		this.id = id;
	}
	public Map<String, String> getAttributes() {
		return attributes;
	}
	public void setAttributes(Map<String, String> attributes) {
		this.attributes = attributes;
	}
	public String getName() {
		return name;
	}
	public void setName(String tableName) {
		this.name = tableName;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public List<Table> getAssociations() {
		return associations;
	}
	public void setAssociations(List<Table> associations) {
		this.associations = associations;
	}

	public Set<Table> getParents() {
		return parents;
	}

	@Override
	public String toString() {
		return getUniqueIdentifier();
	}

	public String getUniqueIdentifier() {
		return this.name + "[" + this.id + "]";
	}



	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((getUniqueIdentifier() == null) ? 0 : getUniqueIdentifier().hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final Table other = (Table) obj;
		return getUniqueIdentifier().equals(other.getUniqueIdentifier());
	}

	public int compareTo(Table o) {
		return Integer.valueOf(getUniqueIdentifier()).compareTo(
				Integer.valueOf(o.getUniqueIdentifier()));
	}
	public boolean hasParent() {
		return !parents.isEmpty();
	}
	public void addAssociation(Table table) {
		this.associations.add(table);
		table.parents.add(this);
	}
}

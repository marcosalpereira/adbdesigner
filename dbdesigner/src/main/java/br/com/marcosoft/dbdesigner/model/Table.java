package br.com.marcosoft.dbdesigner.model;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

public class Table {
	private String name;
	private String schema = "public";
	private String tags;
	private List<Column> columns = new ArrayList<Column>();
	private List<Index> indexes = new ArrayList<Index>();
	private List<Association> associations = new ArrayList<Association>();
	private List<Restriction> restrictions = new ArrayList<Restriction>();

	private int order;
	private int x;
	private int y;

	public int getX() {
		return x;
	}

	public void setX(int x) {
		this.x = x;
	}

	public int getY() {
		return y;
	}

	public void setY(int y) {
		this.y = y;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Column> getColumns() {
		return columns;
	}

	public void setColumns(List<Column> coluns) {
		this.columns = coluns;
	}

	public String getSchema() {
		return schema;
	}

	public void setSchema(String schema) {
		this.schema = schema;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}

	public int getOrder() {
		return order;
	}

	public void setOrder(int order) {
		this.order = order;
	}

	public List<Index> getIndexes() {
		return indexes;
	}

	public void setIndexes(List<Index> indexes) {
		this.indexes = indexes;
	}

	public List<Association> getAssociations() {
		return associations;
	}

	public void setAssociations(List<Association> associations) {
		this.associations = associations;
	}

	public List<Restriction> getRestrictions() {
		return restrictions;
	}

	public void setRestrictions(List<Restriction> restrictions) {
		this.restrictions = restrictions;
	}

	@Override
	public String toString() {
		return name;
	}

	public String getFullName() {
		if (schema == null) {
			return "public." + name;
		}
		return schema + "." + name;
	}

	/**
	 * Retornar a chave primaria da tabela.
	 * @return as colunas da chave primaria separadas por virgula
	 */
	public String getPrimaryKeys() {
		String pks = null;
		for (final Column column : columns) {
	        if (column.isPk()) {
	        	if (pks == null) {
	        		pks = column.getName();
	        	} else {
	        		pks += "," + column.getName();
	        	}
	        }
        }
	    return pks;
    }



    /** {@inheritDoc} */
    @Override
    public boolean equals(Object obj) {
	    if (this == obj) {
		    return true;
	    }
	    if (obj instanceof Table) {
		    final Table that = (Table) obj;
		    return new EqualsBuilder()
		    	.append(schema, that.schema)
		    	.append(name, that.name)
		    	.isEquals();
	    }

	    return false;
    }

    /**{@inheritDoc}*/
    @Override
    public int hashCode() {
	    return new HashCodeBuilder(1, 3)
	    	.append(this.schema)
	    	.append(this.name)
	    	.toHashCode();
    }

}

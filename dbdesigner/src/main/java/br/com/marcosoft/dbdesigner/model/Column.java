package br.com.marcosoft.dbdesigner.model;

import java.io.Serializable;



public class Column implements Serializable {
    private static final long serialVersionUID = 8545514361781937944L;

	private String name;
	private String defaultValue;
	private boolean nullable = true;
	private boolean pk = false;
	private String type = "varchar";
	private Integer precision;
	private Integer scale;
	private Restriction uniqueRestriction;

	public Restriction getUniqueRestriction() {
		return uniqueRestriction;
	}

	public void setUniqueRestriction(Restriction restriction) {
		this.uniqueRestriction = restriction;
	}
	public void setPk(boolean pk) {
		this.pk = pk;
	}

	public boolean isPk() {
		return pk;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDefaultValue() {
		return defaultValue;
	}

	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
	}

	public boolean isNullable() {
		return nullable;
	}

	public void setNullable(boolean nullable) {
		this.nullable = nullable;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getPrecision() {
		return precision;
	}

	public void setPrecision(Integer precision) {
		this.precision = precision;
	}

	public Integer getScale() {
		return scale;
	}

	public void setScale(Integer scale) {
		this.scale = scale;
	}

	@Override
	public String toString() {
		return name;
	}

	public boolean isStringType() {
	    return type.toLowerCase().contains("char");
    }
}

package br.com.marcosoft.dbdesigner.model;

import java.util.ArrayList;
import java.util.List;


public class Column {
	private String name;
	private int order;
	private String defaultValue;
	private boolean nullable = true;
	private boolean pk = false;
	private String type = "varchar";
	private Integer length;
	private Integer decimals;
	private List<Restriction> restrictions = new ArrayList<Restriction>();

	public List<Restriction> getRestrictions() {
	    return restrictions;
    }

	public void setRestrictions(List<Restriction> restrictions) {
	    this.restrictions = restrictions;
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

	public int getOrder() {
		return order;
	}

	public void setOrder(int order) {
		this.order = order;
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

	public Integer getLength() {
		return length;
	}

	public void setLength(Integer length) {
		this.length = length;
	}

	public Integer getDecimals() {
		return decimals;
	}

	public void setDecimals(Integer decimals) {
		this.decimals = decimals;
	}

	@Override
	public String toString() {
		return name;
	}

	public boolean isStringType() {
	    return type.toLowerCase().contains("char");
    }
}

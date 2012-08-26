package br.com.marcosoft.dbdesigner;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

public class Model {
	private Map<String, Table> records = new HashMap<String, Table>();

	public Set<Table> getRecords() {
		Set<Table> ret = new HashSet<Table>(records.size());
		Set<Entry<String, Table>> entrySet = records.entrySet();
		for (Entry<String, Table> entry : entrySet) {
			ret.add(entry.getValue());
		}
		return ret;
	}

	public Table getRecord(String table, String id) {
		return records.get(table + id);
	}

	public Table addRecord(String table, String id) {
		String key = table + id;
		Table r = records.get(key);
		if (r == null) {
			r = new Table(table, id);
			records.put(key, r);
		}
		return r;
	}

	@Override
	public String toString() {
		return records.toString();
	}

	public List<Table> getRoots() {
		List<Table> roots = new ArrayList<Table>();
		Set<Entry<String, Table>> entrySet = records.entrySet();
		for (Entry<String, Table> entry : entrySet) {
			if (!entry.getValue().hasParent()) {
				roots.add(entry.getValue());
			}
		}
		return roots;
	}

}

package br.com.marcosoft.dbdesigner.view;

import java.util.HashMap;
import java.util.Map;

import br.com.marcosoft.dbdesigner.model.Association;
import br.com.marcosoft.dbdesigner.model.Database;
import br.com.marcosoft.dbdesigner.model.Table;

import com.mxgraph.layout.mxGraphLayout;
import com.mxgraph.layout.hierarchical.mxHierarchicalLayout;
import com.mxgraph.swing.mxGraphComponent;
import com.mxgraph.view.mxGraph;

@SuppressWarnings("serial")
public class Graph extends mxGraphComponent {
	private static final int NODE_WIDTH = 150;
	private static final double NODE_HEIGHT = 20;
	private final Map<Table, Object> map = new HashMap<Table, Object>();
	private final mxGraphLayout layout;

	public Graph(final Database database) {
		super(new mxGraph());
		setConnectable(false);
		layout = new mxHierarchicalLayout(graph);
		populateGraph(database);
		layoutGraph();
	}

	private void layoutGraph() {
		final Object cell = graph.getDefaultParent();
		layoutGraph(cell);
	}

	private void layoutGraph(final Object cell) {
	    graph.getModel().beginUpdate();
		layout.execute(cell);
		graph.getModel().endUpdate();
    }

	private void populateGraph(Database database) {
		final Object parent = graph.getDefaultParent();

		graph.getModel().beginUpdate();

		try {
			for (final Table table : database.getTables()) {
				final Object vertex = graph.insertVertex(parent, null, table.getName(), 0, 0,
				        NODE_WIDTH, NODE_HEIGHT);
				map.put(table, vertex);
			}
			for (final Table table : database.getTables()) {
				for (final Association association : table.getAssociations()) {
					final Object v1 = map.get(table);
					final Object v2 = map.get(association.getOtherTable());
					graph.insertEdge(v1, null, "", v1, v2);
				}
			}
		} finally {
			graph.getModel().endUpdate();
		}
	}

}

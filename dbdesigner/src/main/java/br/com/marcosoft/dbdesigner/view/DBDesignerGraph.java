package br.com.marcosoft.dbdesigner.view;

import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseWheelEvent;
import java.awt.event.MouseWheelListener;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import br.com.marcosoft.dbdesigner.model.Association;
import br.com.marcosoft.dbdesigner.model.Database;
import br.com.marcosoft.dbdesigner.model.Table;

import com.mxgraph.layout.mxGraphLayout;
import com.mxgraph.layout.hierarchical.mxHierarchicalLayout;
import com.mxgraph.model.mxCell;
import com.mxgraph.model.mxGeometry;
import com.mxgraph.model.mxGraphModel;
import com.mxgraph.model.mxGraphModel.mxGeometryChange;
import com.mxgraph.model.mxIGraphModel;
import com.mxgraph.swing.mxGraphComponent;
import com.mxgraph.swing.handler.mxKeyboardHandler;
import com.mxgraph.swing.handler.mxRubberband;
import com.mxgraph.swing.util.mxMorphing;
import com.mxgraph.util.mxEvent;
import com.mxgraph.util.mxEventObject;
import com.mxgraph.util.mxEventSource.mxIEventListener;
import com.mxgraph.view.mxGraph;

@SuppressWarnings("serial")
public class DBDesignerGraph extends mxGraphComponent {
	private static final int NODE_WIDTH = 170;
	private static final double NODE_HEIGHT = 20;
	private final Map<Table, Object> map = new HashMap<Table, Object>();
	private final mxGraphLayout layout;
	private Database database;
	private boolean filtering;
	private boolean dirty;

	public DBDesignerGraph() {
		super(new mxGraph());

		setConnectable(false);

		graph.setDisconnectOnMove(false);
		graph.setCellsDisconnectable(false);
		graph.setResetEdgesOnMove(true);
		graph.setDropEnabled(false);
		graph.setAutoSizeCells(true);

		getGraphHandler().setImagePreview(true);

		installZoomListener();

		new mxRubberband(this);
		new mxKeyboardHandler(this);

		layout = new mxHierarchicalLayout(graph);

		installMoveListener();

		installClickHandler();

	}

	private void installClickHandler() {
		getGraphControl().addMouseListener(new MouseAdapter() {

			@Override
			public void mouseReleased(MouseEvent e) {
				if (e.getClickCount() != 2) return;

				final mxCell cell = (mxCell) getCellAt(e.getX(), e.getY());
				if (cell != null && cell.isVertex()) {
					editTable(cell);
				}
			}

		});
	}

	private void editTable(mxCell cell) {
	}

	public void showOnlyCellsWithTheseTags(String tags) {
		this.filtering = true;
		final Set<Entry<Table, Object>> entrySet = map.entrySet();
		for (final Entry<Table, Object> entry : entrySet) {
			final Table table = entry.getKey();
			setVisible((mxCell) entry.getValue(), table.hasAnyOfThese(tags));
        }
		layoutGraph();
	}

	public void showAllCells() {
		this.filtering = false;
		restoreOriginalPositions();
		resetAllEdgesPoints();

	}

	private void restoreOriginalPositions() {
	    final Set<Entry<Table, Object>> entrySet = map.entrySet();
		for (final Entry<Table, Object> entry : entrySet) {
			final mxCell cell = (mxCell) entry.getValue();
			restoreOriginalPosition(cell, entry.getKey());
			setVisible(cell, true);
		}
    }

	private void resetAllEdgesPoints() {
	    final mxIGraphModel model = graph.getModel();
		model.beginUpdate();
		final Object[] vertices = graph.getChildEdges(graph.getDefaultParent());
		for (final Object object : vertices) {
	        final mxCell cell = (mxCell) object;
	        final mxGeometry geo = (mxGeometry) cell.getGeometry().clone();
	        geo.setPoints(null);
	        model.setGeometry(cell, geo);
        }
		model.endUpdate();
    }

	private void restoreOriginalPosition(mxCell cell, Table table) {
		final mxGeometry geometry = new mxGeometry(table.getX(), table.getY(), NODE_WIDTH, NODE_HEIGHT);
		final mxIGraphModel model = graph.getModel();

		model.beginUpdate();
		model.setGeometry(cell, geometry);
		model.endUpdate();
	}

	public Table getTableFromVertex(Object object) {
	    return (Table) ((mxCell) object).getValue();
    }

	private void setVisible(final mxCell cell, boolean visible) {
		if (cell.getValue() == null) return;
		final mxIGraphModel model = graph.getModel();
		for (int i=0; i<cell.getEdgeCount(); i++) {
			model.setVisible(cell.getEdgeAt(i), visible);
		}
        model.setVisible(cell, visible);
    }

	private void installMoveListener() {
	    graph.getModel().addListener(mxEvent.CHANGE, new mxIEventListener()
		{
			@SuppressWarnings("unchecked")
            public void invoke(Object sender, mxEventObject evt)
			{
				if (filtering) return;
				final Collection<Object> changes = (Collection<Object>) evt.getProperty("changes");
				for (final Object change : changes) {
					if (change instanceof mxGeometryChange) {
						final mxGeometryChange geometryChange = (mxGeometryChange) change;
						final mxCell cell = (mxCell) geometryChange.getCell();
						if (cell.isVertex()) {
							final Table table = (Table) cell.getValue();
							final mxGeometry geometry = geometryChange.getGeometry();
							table.setX((int)geometry.getX());
							table.setY((int)geometry.getY());
							dirty = true;
						}
					}
				}
			}
		});
    }

	private void installZoomListener() {
	    this.addMouseWheelListener(new MouseWheelListener() {
			public void mouseWheelMoved(MouseWheelEvent e) {
				if (e.isControlDown()) {
					if (e.getWheelRotation() < 0) {
						zoomIn();
					} else {
						zoomOut();
					}
				}
			}
		});
    }

	private void layoutGraph() {
		final Object cell = graph.getDefaultParent();
		layoutGraph(cell);
	}

	private void layoutGraph(final Object cell) {
		graph.getModel().beginUpdate();
		try {
			layout.execute(cell);
		} finally {
			final mxMorphing morph = new mxMorphing(this, 20, 1.2, 20);
			morph.addListener(mxEvent.DONE, new mxIEventListener() {
				public void invoke(Object sender, mxEventObject evt) {
					graph.getModel().endUpdate();
				}
			});
			morph.startAnimation();
		}

    }

	public void populateGraph(Database database) {

		graph.getModel().beginUpdate();

		((mxGraphModel) graph.getModel()).clear();

		final Object parent = graph.getDefaultParent();

		try {
			for (final Table table : database.getTables()) {
				final Object v1 = criarVertice(parent, table);
				for (final Association association : table.getAssociations()) {
					final Object v2 = criarVertice(parent, association.getOtherTable());
					criarAresta(parent, v1, v2);
				}
			}
		} finally {
			graph.getModel().endUpdate();
		}

		zoomAndCenter();
	}

	private void criarAresta(Object parent, Object verticeA, Object verticeB) {
		graph.insertEdge(parent, null, null, verticeA, verticeB);
    }

	private Object criarVertice(Object parent, Table table) {
	    Object vertex = map.get(table);
		if (vertex == null) {
			vertex = graph.insertVertex(parent, null, table, table.getX(), table.getY(),
					NODE_WIDTH, NODE_HEIGHT);
			map.put(table, vertex);
		}
		return vertex;
    }

	public Database getDatabase() {
	    return database;
    }

	public void setDatabase(Database database) {
		this.database = database;
	    populateGraph(database);
    }

	public Collection<Object> getVertexes() {
		return map.values();
	}

	public boolean isDirty() {
	    return dirty;
    }
}

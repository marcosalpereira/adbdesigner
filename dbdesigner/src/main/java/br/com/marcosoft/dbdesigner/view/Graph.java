package br.com.marcosoft.dbdesigner.view;

import java.awt.Color;
import java.awt.event.MouseEvent;
import java.awt.event.MouseWheelEvent;
import java.awt.event.MouseWheelListener;
import java.awt.geom.Rectangle2D;
import java.util.HashMap;
import java.util.Map;

import javax.swing.ToolTipManager;

import org.jgraph.JGraph;
import org.jgraph.graph.AttributeMap;
import org.jgraph.graph.DefaultEdge;
import org.jgraph.graph.DefaultGraphCell;
import org.jgraph.graph.DefaultGraphModel;
import org.jgraph.graph.GraphConstants;

import br.com.marcosoft.dbdesigner.model.Association;
import br.com.marcosoft.dbdesigner.model.Database;
import br.com.marcosoft.dbdesigner.model.Table;

public class Graph extends JGraph {
	private static final int NODE_WIDTH = 150;
	private static final double NODE_HEIGHT = 20;

	private static final long serialVersionUID = 1L;
	private final Map<Table, DefaultGraphCell> vertexes = new HashMap<Table, DefaultGraphCell>();
	private final Database database;


	public Graph(final Database database) {
		super(new DefaultGraphModel());
		this.database = database;

		// Switch off D3D because of Sun XOR painting bug
		// See http://www.jgraph.com/forum/viewtopic.php?t=4066
		System.setProperty("sun.java2d.d3d", "false");

		ToolTipManager.sharedInstance().registerComponent(this);

//		this.setGridVisible(true);
//		this.setGridMode(JGraph.LINE_GRID_MODE);
//		this.setGridSize(100);

		// Control-drag should clone selection
		this.setCloneable(true);

		// Enable edit without final RETURN keystroke
		this.setInvokesStopCellEditing(true);

		// When over a cell, jump to its default port (we only have one, anyway)
		this.setJumpToDefaultPort(true);

		this.setDisconnectable(false);

		this.addMouseWheelListener(new MouseWheelListener() {

			public void mouseWheelMoved(MouseWheelEvent e) {
				final int rotation = e.getWheelRotation();
				final double newScale = getScale() + rotation / 10.0;
				setScale(newScale);
			}
		});

		populateGraph();

	}

	@Override
	public boolean isEditable() {
		return false;
	}

	private  void populateGraph() {

		for (final Table table : database.getTables()) {
				final DefaultGraphCell cell = this.createVertex(table);
				for (final Association association : table.getAssociations()) {
					final DefaultGraphCell otherVertex = this.createVertex(association.getOtherTable());
					this.createEdge(cell, otherVertex);
				}
		}

	}

	@Override
	public String getToolTipText(MouseEvent e) {
		if (e != null) {
			final DefaultGraphCell c = (DefaultGraphCell) getFirstCellForLocation(
					e.getX(), e.getY());
			if (c != null) {
				return c.getAttributes().get("Tooltip") + "";
			}
		}
		return null;
	}

	@SuppressWarnings({ "rawtypes" })
	public void positionVertexAt(DefaultGraphCell cell, int x, int y){
		final AttributeMap attr = cell.getAttributes();
	    final Rectangle2D bounds = GraphConstants.getBounds(attr);
	    bounds.setRect(x, y, bounds.getWidth(), bounds.getHeight());
	    final Map map = new HashMap();
	    GraphConstants.setBounds(map, bounds);
	    getGraphLayoutCache().edit(new Object[] {cell}, map);
	}

	@SuppressWarnings("unchecked")
	public DefaultGraphCell createVertex(Table table) {
		DefaultGraphCell cell = vertexes.get(table);
		if (cell != null)
			return cell;

		// Create vertex with the given name
		cell = new DefaultGraphCell(table);
		vertexes.put(table, cell);

		cell.getAttributes()
			.put("record", table);

		// Set bounds
		GraphConstants.setBounds(cell.getAttributes(), new Rectangle2D.Double(
				0, 0, NODE_WIDTH, NODE_HEIGHT));

		// Set fill color
		GraphConstants.setGradientColor(cell.getAttributes(), Color.ORANGE);
		GraphConstants.setOpaque(cell.getAttributes(), true);

		GraphConstants.setBorderColor(cell.getAttributes(), Color.black);

		// Add a Floating Port
		cell.addPort();

		this.getGraphLayoutCache().insert(cell);

		return cell;
	}

	public void createEdge(DefaultGraphCell source,
			DefaultGraphCell target) {
		// Create Edge
		final DefaultEdge edge = new DefaultEdge();
		// Fetch the ports from the new vertices, and connect them with the edge
		edge.setSource(source.getChildAt(0));
		edge.setTarget(target.getChildAt(0));

		// Set Arrow Style for edge
		final int arrow = GraphConstants.ARROW_CLASSIC;
		GraphConstants.setLineEnd(edge.getAttributes(), arrow);
		GraphConstants.setEndFill(edge.getAttributes(), true);
		GraphConstants.setLineColor(edge.getAttributes(), Color.lightGray);

		this.getGraphLayoutCache().insert(edge);
	}

}

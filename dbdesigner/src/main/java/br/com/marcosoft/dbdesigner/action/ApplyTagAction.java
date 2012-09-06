package br.com.marcosoft.dbdesigner.action;

import java.awt.event.ActionEvent;

import javax.swing.AbstractAction;

import br.com.marcosoft.dbdesigner.model.Table;
import br.com.marcosoft.dbdesigner.view.DBDesignerGraph;
import br.com.marcosoft.dbdesigner.view.SelectTagsDialog;

@SuppressWarnings("serial")
public class ApplyTagAction extends AbstractAction {

	public void actionPerformed(ActionEvent event) {

		final String tags = new SelectTagsDialog().getTags();
		if (tags == null) return;

		final DBDesignerGraph dbDesignerGraph = (DBDesignerGraph) event.getSource();
		final Object[] selectionCells = dbDesignerGraph.getGraph().getSelectionCells();
		for (final Object object : selectionCells) {
			final Table table = dbDesignerGraph.getTableFromVertex(object);
			if (table != null) {
				table.setTags(tags);
			}
        }
    }

}

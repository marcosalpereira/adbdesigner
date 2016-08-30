package br.com.marcosoft.dbdesigner.action;

import java.awt.event.ActionEvent;
import java.util.List;

import javax.swing.AbstractAction;

import org.apache.commons.lang.StringUtils;

import br.com.marcosoft.dbdesigner.model.Table;
import br.com.marcosoft.dbdesigner.view.DBDesignerGraph;
import br.com.marcosoft.dbdesigner.view.SelectTagsDialog;

@SuppressWarnings("serial")
public class ApplyTagAction extends AbstractAction {

	public void actionPerformed(ActionEvent event) {

		final DBDesignerGraph dbDesignerGraph = (DBDesignerGraph) event.getSource();
		final List<String> tags = new SelectTagsDialog().getTags(dbDesignerGraph.getDatabase().getTableTags());
		if (tags.isEmpty()) return;

		final Object[] selectionCells = dbDesignerGraph.getGraph().getSelectionCells();
		for (final Object object : selectionCells) {
			final Table table = dbDesignerGraph.getTableFromVertex(object);
			if (table != null) {
				table.setTags(StringUtils.join(tags, ","));
			}
        }
    }

}

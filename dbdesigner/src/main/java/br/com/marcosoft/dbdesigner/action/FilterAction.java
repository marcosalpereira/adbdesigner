package br.com.marcosoft.dbdesigner.action;

import java.awt.event.ActionEvent;
import java.util.List;

import javax.swing.AbstractAction;

import org.apache.commons.lang.StringUtils;

import br.com.marcosoft.dbdesigner.view.DBDesignerGraph;
import br.com.marcosoft.dbdesigner.view.SelectTagsDialog;

@SuppressWarnings("serial")
public class FilterAction extends AbstractAction {

	public void actionPerformed(ActionEvent event) {
		final DBDesignerGraph dbDesignerGraph = (DBDesignerGraph) event.getSource();
		final List<String> tags = new SelectTagsDialog().getTags(dbDesignerGraph.getDatabase().getTableTags());
		//final String tags = JOptionPane.showInputDialog("diz", dbDesignerGraph.getDatabase().getTableTags());
		if (tags.isEmpty()) {
			dbDesignerGraph.showAllCells();
			return;
		}
		dbDesignerGraph.showOnlyCellsWithTheseTags(StringUtils.join(tags, ','));
    }

}

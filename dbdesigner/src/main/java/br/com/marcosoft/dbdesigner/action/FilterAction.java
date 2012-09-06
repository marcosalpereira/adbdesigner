package br.com.marcosoft.dbdesigner.action;

import java.awt.event.ActionEvent;

import javax.swing.AbstractAction;
import javax.swing.JOptionPane;

import br.com.marcosoft.dbdesigner.view.DBDesignerGraph;

@SuppressWarnings("serial")
public class FilterAction extends AbstractAction {

	public void actionPerformed(ActionEvent event) {
		final DBDesignerGraph dbDesignerGraph = (DBDesignerGraph) event.getSource();
		//final String tags = new SelectTagsDialog().getTags();
		final String tags = JOptionPane.showInputDialog("diz", dbDesignerGraph.getDatabase().getTableTags());
		if (tags == null) {
			dbDesignerGraph.showAllCells();
			return;
		}
		dbDesignerGraph.showOnlyCellsWithTheseTags(tags);
    }

}

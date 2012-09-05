package br.com.marcosoft.dbdesigner.view;

import javax.swing.BorderFactory;
import javax.swing.JToolBar;

import br.com.marcosoft.dbdesigner.DBDesigner;
import br.com.marcosoft.dbdesigner.action.NewTableAction;
import br.com.marcosoft.dbdesigner.action.SaveAction;

@SuppressWarnings("serial")
public class DBDesignerToolBar extends JToolBar {

	public DBDesignerToolBar(final DBDesigner dbDesigner, int orientation) {
		super(orientation);

		setBorder(BorderFactory.createCompoundBorder(BorderFactory.createEmptyBorder(3, 3, 3, 3),
		        getBorder()));
		setFloatable(false);

		add(dbDesigner.bind("Save", new SaveAction(), "/images/save.gif")).setToolTipText("Salvar");
		addSeparator();
		add(dbDesigner.bind("Print", new NewTableAction(), "/images/newTable.gif")).setToolTipText(
		        "Nova Tabela");

	}
}

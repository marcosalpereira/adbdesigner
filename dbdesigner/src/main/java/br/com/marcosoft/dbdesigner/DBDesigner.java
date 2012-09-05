/*
 * @(#)HelloWorld.java 3.3 23-APR-04
 *
 * Copyright (c) 2001-2004, Gaudenz Alder All rights reserved.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */
package br.com.marcosoft.dbdesigner;

import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.io.File;

import javax.swing.AbstractAction;
import javax.swing.Action;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JToolBar;
import javax.swing.UIManager;

import br.com.marcosoft.dbdesigner.model.Database;
import br.com.marcosoft.dbdesigner.view.DBDesignerToolBar;
import br.com.marcosoft.dbdesigner.view.DBDesignerGraph;

@SuppressWarnings("serial")
public class DBDesigner extends JFrame {
	private JToolBar toolBar;
	private DBDesignerGraph dBDesignerGraph;

	public static void main(String[] args) {
		args = new String[] { DBDesigner.class.getResource("/sgc.db.xml").getFile() };
		checkArgs(args);
		new DBDesigner().design(args[0]);
	}

	private static void checkArgs(String[] args) {

		if (args.length < 1) {
			throw new RuntimeException("Sintax error!\n" + sintax());
		}
		if (!(new File(args[0]).exists())) {
			throw new RuntimeException("File not found! [" + args[0] + "]\n" + sintax());
		}
	}

	private static String sintax() {
		return "Usage: " + DBDesigner.class.getName() + " <dbxml>";
	}

	public void design(String fileName) {
		final Database database = new ParseDatabase().parse(new File(fileName));

		initGUI();

		dBDesignerGraph.setDatabase(database);

		setVisible(true);
	}

	private void setLookAndFeel() {
		try {
	        UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (final Exception e) {
	        e.printStackTrace();
        }
    }

	private void initGUI() {
		setLookAndFeel();
		final GridBagLayout layout = new GridBagLayout();
		layout.rowWeights = new double[] { 0.0, 0.1 };
		layout.rowHeights = new int[] { 7, 7 };
		layout.columnWeights = new double[] { 0.1 };
		layout.columnWidths = new int[] { 7 };
		getContentPane().setLayout(layout);
		guiCriarToolbar();
		guiCriarGraph();
		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		pack();
		setExtendedState(javax.swing.JFrame.MAXIMIZED_BOTH);
	}

	private void guiCriarGraph() {
		dBDesignerGraph = new DBDesignerGraph();
		getContentPane().add(
		        dBDesignerGraph,
		        new GridBagConstraints(0, 1, 1, 1, 0.0, 0.0, GridBagConstraints.CENTER,
		                GridBagConstraints.BOTH, new Insets(0, 0, 0, 0), 0, 0));
	}

	private void guiCriarToolbar() {
		toolBar = new DBDesignerToolBar(this, JToolBar.HORIZONTAL);
		getContentPane().add(
		        toolBar,
		        new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0, GridBagConstraints.CENTER,
		                GridBagConstraints.BOTH, new Insets(0, 0, 0, 0), 0, 0));
		toolBar.setPreferredSize(new java.awt.Dimension(390, 25));
	}

	/**
	 *
	 * @param name
	 * @param action
	 * @return a new Action bound to the specified string name and icon
	 */
	public Action bind(String name, final Action action, String iconUrl) {
		final ImageIcon imageIcon = (iconUrl != null)
				? new ImageIcon(DBDesigner.class.getResource(iconUrl))
		        : null;

		final AbstractAction newAction = new AbstractAction(name, imageIcon) {
			public void actionPerformed(ActionEvent e) {
				action.actionPerformed(new ActionEvent(dBDesignerGraph, e.getID(), e.getActionCommand()));
			}
		};

		newAction.putValue(Action.SHORT_DESCRIPTION, action.getValue(Action.SHORT_DESCRIPTION));

		return newAction;
	}

}
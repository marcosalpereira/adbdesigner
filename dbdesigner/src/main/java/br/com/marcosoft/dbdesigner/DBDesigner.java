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

import java.io.File;

import javax.swing.JFrame;
import javax.swing.JScrollPane;

import br.com.marcosoft.dbdesigner.model.Database;
import br.com.marcosoft.dbdesigner.view.Graph;


public class DBDesigner {

	public static void main(String[] args) {
		args = new String[] { DBDesigner.class.getResource("/sgc.db.xml").getFile() };
		checkArgs(args);
		new DBDesigner().design(args[0]);
	}

	private static void checkArgs(String[] args) {

		if (args.length < 1) {
			throw new RuntimeException("Sintax error!\n" + sintax());
		}
		if (! (new File(args[0]).exists()) ) {
			throw new RuntimeException("File not found! [" + args[0] + "]\n" + sintax());
		}
	}

	private static String sintax() {
		return "Usage: " + DBDesigner.class.getName() + " <dbxml>";
	}

	public void design(String fileName) {
		final Database database = new ParseDatabase().parse(new File(fileName));

		final Graph graph = new Graph(database);

		// Show in Frame
		final JFrame frame = new JFrame();
		frame.getContentPane().add(new JScrollPane(graph));
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.pack();
		frame.setExtendedState(JFrame.MAXIMIZED_BOTH);
		frame.setVisible(true);
	}

}
package br.com.marcosoft.dbdesigner.view;

import javax.swing.JOptionPane;

public class SelectTagsDialog {
	private final String tags;

	public String getTags() {
	    return tags;
    }

	public SelectTagsDialog() {
	    tags = JOptionPane.showInputDialog("diz aí");
    }
}

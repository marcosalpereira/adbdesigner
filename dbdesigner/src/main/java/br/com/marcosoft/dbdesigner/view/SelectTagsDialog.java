package br.com.marcosoft.dbdesigner.view;

import java.awt.FlowLayout;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import javax.swing.DefaultComboBoxModel;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextField;
import javax.swing.WindowConstants;

import org.apache.commons.lang.StringUtils;

public class SelectTagsDialog {
	private SelectTagsDialogFrame frame;

	public static void main(String[] args) {
		System.out.println(new SelectTagsDialog().getTags(Arrays.asList("a")));
	}

	public List<String> getTags(Collection<String> tags) {
		frame = new SelectTagsDialogFrame();
		for (final String tag : tags) {
			frame.lstTagsModel.addElement(tag);
		}
		frame.setVisible(true);
		return frame.selectedTags;
    }

	@SuppressWarnings("serial")
    class SelectTagsDialogFrame extends JDialog {
		private final List<String> selectedTags = new ArrayList<String>();
		private JPanel jPanel1;
		private JScrollPane jScrollPane1;
		private JTextField txtNewTag;
		private JList lstTags;
		private JButton btnAddNewTag;
		private JLabel jLabel1;
		private JButton btnCancel;
		private JButton btnOk;
		private JPanel jPanel2;
		private DefaultComboBoxModel lstTagsModel;

		public SelectTagsDialogFrame() {
			super();
			initGUI();
		}

		private void initGUI() {
			try {
				final GridBagLayout thisLayout = new GridBagLayout();
				setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
				thisLayout.rowWeights = new double[] {0.0, 0.1, 0.0};
				thisLayout.rowHeights = new int[] {7, 7, 7};
				thisLayout.columnWeights = new double[] {0.1};
				thisLayout.columnWidths = new int[] {7};
				getContentPane().setLayout(thisLayout);
				{
					jPanel1 = new JPanel();
					final GridBagLayout jPanel1Layout = new GridBagLayout();
					getContentPane().add(jPanel1, new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0, GridBagConstraints.CENTER, GridBagConstraints.BOTH, new Insets(3, 3, 3, 3), 0, 0));
					jPanel1Layout.rowWeights = new double[] {0.0, 0.0};
					jPanel1Layout.rowHeights = new int[] {7, 7};
					jPanel1Layout.columnWeights = new double[] {0.1, 0.0};
					jPanel1Layout.columnWidths = new int[] {7, 7};
					jPanel1.setLayout(jPanel1Layout);
					{
						jLabel1 = new JLabel();
						jPanel1.add(jLabel1, new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0, GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(0, 0, 0, 0), 0, 0));
						jLabel1.setText("New Tag");
					}
					{
						txtNewTag = new JTextField();
						jPanel1.add(txtNewTag, new GridBagConstraints(0, 1, 1, 1, 0.0, 0.0, GridBagConstraints.CENTER, GridBagConstraints.BOTH, new Insets(0, 0, 0, 0), 0, 0));
					}
					{
						btnAddNewTag = new JButton();
						jPanel1.add(btnAddNewTag, new GridBagConstraints(1, 1, 1, 1, 0.0, 0.0, GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(0, 0, 0, 0), 0, 0));
						btnAddNewTag.setText("Add");
						btnAddNewTag.addActionListener(new ActionListener() {
							public void actionPerformed(ActionEvent evt) {
								btnAddNewTagActionPerformed(evt);
							}
						});
					}
				}
				{
					jScrollPane1 = new JScrollPane();
					getContentPane().add(jScrollPane1, new GridBagConstraints(0, 1, 1, 1, 0.0, 0.0, GridBagConstraints.CENTER, GridBagConstraints.BOTH, new Insets(3, 3, 3, 3), 0, 0));
					{
						lstTagsModel = new DefaultComboBoxModel(new String[] {});
						lstTags = new JList();
						jScrollPane1.setViewportView(lstTags);
						lstTags.setModel(lstTagsModel);
					}
				}
				{
					jPanel2 = new JPanel();
					final FlowLayout jPanel2Layout = new FlowLayout();
					jPanel2Layout.setAlignment(FlowLayout.RIGHT);
					jPanel2.setLayout(jPanel2Layout);
					getContentPane().add(jPanel2, new GridBagConstraints(0, 2, 1, 1, 0.0, 0.0, GridBagConstraints.CENTER, GridBagConstraints.BOTH, new Insets(3, 3, 3, 3), 0, 0));
					{
						btnOk = new JButton();
						jPanel2.add(btnOk);
						btnOk.setText("ok");
						btnOk.setPreferredSize(new java.awt.Dimension(69, 22));
						btnOk.addActionListener(new ActionListener() {
							public void actionPerformed(ActionEvent evt) {
								btnOkActionPerformed(evt);
							}
						});
					}
					{
						btnCancel = new JButton();
						jPanel2.add(btnCancel);
						btnCancel.setText("Cancelar");
						btnCancel.addActionListener(new ActionListener() {
							public void actionPerformed(ActionEvent evt) {
								btnCancelActionPerformed(evt);
							}
						});
					}
				}

				pack();
				setSize(400, 300);
				setTitle("Select tags");
				setModal(true);

			} catch (final Exception e) {
				e.printStackTrace();
			}
		}

		private void btnAddNewTagActionPerformed(ActionEvent evt) {
			final String text = StringUtils.trim(txtNewTag.getText());
			if (StringUtils.isBlank(text)) {
				if (selectedTags.isEmpty()) {
					JOptionPane.showMessageDialog(this, "Type a tag name");
					return;
				}
			}
			for (int i = 0; i<lstTagsModel.getSize(); i++) {
				if (text.equalsIgnoreCase((String) lstTagsModel.getElementAt(i))) {
					lstTags.setSelectedIndex(i);
					return;
				}
			}
			lstTagsModel.addElement(text);
			txtNewTag.setText("");
			txtNewTag.requestFocus();
		}

		private void btnOkActionPerformed(ActionEvent evt) {
			for (final int indice : lstTags.getSelectedIndices()) {
				selectedTags.add((String) lstTagsModel.getElementAt(indice));
			}
			if (selectedTags.isEmpty()) {
				JOptionPane.showMessageDialog(this, "Select at least one tag");
				return;
			}
			dispose();
		}

		private void btnCancelActionPerformed(ActionEvent evt) {
			dispose();
		}

	}

}

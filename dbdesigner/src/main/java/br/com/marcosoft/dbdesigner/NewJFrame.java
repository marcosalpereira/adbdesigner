package br.com.marcosoft.dbdesigner;
import java.awt.FlowLayout;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

import javax.swing.DefaultComboBoxModel;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextField;
import javax.swing.ListModel;
import javax.swing.SwingUtilities;
import javax.swing.WindowConstants;

/**
* This code was edited or generated using CloudGarden's Jigloo
* SWT/Swing GUI Builder, which is free for non-commercial
* use. If Jigloo is being used commercially (ie, by a corporation,
* company or business for any purpose whatever) then you
* should purchase a license for each developer using Jigloo.
* Please visit www.cloudgarden.com for details.
* Use of Jigloo implies acceptance of these licensing terms.
* A COMMERCIAL LICENSE HAS NOT BEEN PURCHASED FOR
* THIS MACHINE, SO JIGLOO OR THIS CODE CANNOT BE USED
* LEGALLY FOR ANY CORPORATE OR COMMERCIAL PURPOSE.
*/
public class NewJFrame extends javax.swing.JFrame {
	private JPanel jPanel1;
	private JScrollPane jScrollPane1;
	private JTextField txtNewTag;
	private JList lstTags;
	private JButton btnAddNewTag;
	private JLabel jLabel1;
	private JButton btnCancel;
	private JButton btnOk;
	private JPanel jPanel2;

	/**
	* Auto-generated main method to display this JFrame
	*/
	public static void main(String[] args) {
		SwingUtilities.invokeLater(new Runnable() {
			public void run() {
				final NewJFrame inst = new NewJFrame();
				inst.setLocationRelativeTo(null);
				inst.setVisible(true);
			}
		});
	}

	public NewJFrame() {
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
					final ListModel lstTagsModel = new DefaultComboBoxModel(new String[] {});
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
			this.addWindowListener(new WindowAdapter() {
				@Override
                public void windowClosing(WindowEvent evt) {
					thisWindowClosing(evt);
				}
			});
			pack();
			setSize(400, 300);
		} catch (final Exception e) {
		    //add your error handling code here
			e.printStackTrace();
		}
	}

	private void thisWindowClosing(WindowEvent evt) {
		System.out.println("this.windowClosing, event="+evt);
		dispose();
	}

	private void btnAddNewTagActionPerformed(ActionEvent evt) {
		System.out.println("btnAddNewTag.actionPerformed, event="+evt);
		//TODO add your code for btnAddNewTag.actionPerformed
	}

	private void btnOkActionPerformed(ActionEvent evt) {
		System.out.println("btnOk.actionPerformed, event="+evt);
		//TODO add your code for btnOk.actionPerformed
	}

	private void btnCancelActionPerformed(ActionEvent evt) {
		System.out.println("btnCancel.actionPerformed, event="+evt);
		//TODO add your code for btnCancel.actionPerformed
	}

}

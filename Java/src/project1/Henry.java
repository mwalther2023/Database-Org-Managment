package project1;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;

import javax.swing.JComboBox;
import javax.swing.JComponent;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTabbedPane;

public class Henry {
	public static void main(String[] args) {
		JFrame main = new JFrame("Main");
		main.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		main.setPreferredSize(new Dimension(500, 400));
		main.pack();
		

		
		JTabbedPane tab = new JTabbedPane();

		HenryDAO h = new HenryDAO();
		
		SearchByAuthorPanel a = new SearchByAuthorPanel(h);
		SearchByCategoryPanel c = new SearchByCategoryPanel(h);
		SearchByPublisherPanel p = new SearchByPublisherPanel(h);
		
		tab.addTab("Search By Author",a.getPanel());
		tab.addTab("Search By Category",c.getPanel()); //Throwing error when calling setVisible
		tab.addTab("Search By Publisher",p.getPanel()); //Throwing error when calling setVisible
		
		main.getContentPane().add(tab, BorderLayout.CENTER);
		main.setVisible(true);
	}
}

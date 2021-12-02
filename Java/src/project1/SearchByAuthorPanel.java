package project1;
import java.awt.Color;
import java.awt.Dimension;
import java.util.ArrayList;
import java.util.Vector;

import javax.swing.JComboBox;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.JTextField;

import java.awt.event.*;

@SuppressWarnings("rawtypes")
public class SearchByAuthorPanel extends JPanel implements ItemListener {
	private JPanel author;
	private JComboBox a;
	private JComboBox b;
	private JTextField p;
	private JList s;
	private String[] store;
	private String[] data;
	private String[] book;
	private String price;
	private HenryDAO h;

	SearchByAuthorPanel(HenryDAO h) {
		this.h = h;
		author = new JPanel();
		author.setBackground(Color.BLUE);

		data = h.getAuthors();
		a = new JComboBox(data);
		a.addItemListener(this);

		book = h.getBooks((String) a.getSelectedItem());
		b = new JComboBox(book);
		b.addItemListener(this);

		price = h.getPrice((String) b.getSelectedItem());
		p = new JTextField("$" + price);
		p.setEditable(false);

		store = h.getLocations((String) b.getSelectedItem());
		s = new JList(store);
//		s.setPreferredSize(new Dimension(200, 200));
		author.add(a);
		author.add(b);
		author.add(p, -1);
		author.add(s, -1);

	}

	public JPanel getPanel() {
		return author;
	}

	@Override
	public void itemStateChanged(ItemEvent e) {
		// TODO Auto-generated method stub
		if (e.getSource() == a) {
			updateBook();
			updatePrice();
			updateLocation();
		} else if (e.getSource() == b) {
			updateLocation();
			updatePrice();
		}
		author.revalidate();
		author.repaint();
	}

	public void updateBook() {
		book = h.getBooks((String) a.getSelectedItem());
		author.remove(b);
		b = new JComboBox(book);
		author.add(b);
		b.addItemListener(this);
	}

	public void updatePrice() {
		price = h.getPrice((String) b.getSelectedItem());
		author.remove(p);
		p = new JTextField("$" + price);
		author.add(p, -1);

	}

	public void updateLocation() {
		store = h.getLocations((String) b.getSelectedItem());
		author.remove(s);
		s = new JList(store);
//		s.setPreferredSize(new Dimension(200, 200));
		author.add(s, -1);
	}
}

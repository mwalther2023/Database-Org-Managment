package project1;
import java.awt.Color;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;

import javax.swing.JComboBox;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.JTextField;

public class SearchByCategoryPanel extends JPanel implements ItemListener{
	private JPanel category;
	private JComboBox a;
	private JComboBox b;
	private JTextField p;
	private JList s;
	private String[] store;
	private String[] data;
	private String[] book;
	private String price;
	private String author_box;
	private String book_box;
	private HenryDAO h;

	SearchByCategoryPanel(HenryDAO h) {
		this.h = h;
		category = new JPanel();
		category.setBackground(Color.GREEN);
		data = h.getCategories();

		a = new JComboBox(data);
		a.addItemListener(this);

		book = h.getBooksByCategory((String) a.getSelectedItem());
		b = new JComboBox(book);
		b.addItemListener(this);
		
		price = h.getPrice((String) b.getSelectedItem());
		p = new JTextField("$" + price);
		p.setEditable(false);

		store = h.getLocations((String) b.getSelectedItem());
		s = new JList(store);
		
		
		category.add(a);
		category.add(b);
		category.add(p, -1);
		category.add(s, -1);
		
	}

	public JPanel getPanel() {
		return category;
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
		category.revalidate();
		category.repaint();
	}

	public void updateBook() {
		book = h.getBooksByCategory((String) a.getSelectedItem());
		category.remove(b);
		b = new JComboBox(book);
		category.add(b);
		b.addItemListener(this);
	}

	public void updatePrice() {
		price = h.getPrice((String) b.getSelectedItem());
		category.remove(p);
		p = new JTextField("$" + price);
		category.add(p, -1);

	}

	public void updateLocation() {
		store = h.getLocations((String) b.getSelectedItem());
		category.remove(s);
		s = new JList(store);
		category.add(s, -1);
	}
}

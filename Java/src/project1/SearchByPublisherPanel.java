package project1;
import java.awt.Color;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;

import javax.swing.JComboBox;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.JTextField;

public class SearchByPublisherPanel extends JPanel implements ItemListener {
	private JPanel publisher;
	private JComboBox pub;
	private JComboBox b;
	private JTextField p;
	private JList s;
	private String[] store;
	private String[] data;
	private String[] book;
	private String price = "12.14";
	private String publisher_box;
	private String book_box;
	private HenryDAO h;

	SearchByPublisherPanel(HenryDAO h) {
		this.h = h;
		publisher = new JPanel();
		publisher.setBackground(Color.RED);
		data = h.getPublishers();

		pub = new JComboBox(data);
		pub.addItemListener(this);

		book = h.getPublisherBooks((String) pub.getSelectedItem());
		b = new JComboBox(book);
		b.addItemListener(this);
		
		price = h.getPrice((String) b.getSelectedItem());
		if (price == null)
			price = "0";
		p = new JTextField("$" + price);
		p.setEditable(false);

		store = h.getLocations((String) b.getSelectedItem());
		s = new JList(store);
		
		
		publisher.add(pub);
		publisher.add(b);
		publisher.add(p, -1);
		publisher.add(s, -1);
		
	}

	public JPanel getPanel() {
		return publisher;
	}

	@Override
	public void itemStateChanged(ItemEvent e) {
		// TODO Auto-generated method stub
		if (e.getSource() == pub) {
			updateBook();
			updatePrice();
			updateLocation();
		} else if (e.getSource() == b) {
			updateLocation();
			updatePrice();
		}
		publisher.revalidate();
		publisher.repaint();
	}

	public void updateBook() {
		book = h.getPublisherBooks((String) pub.getSelectedItem());
		publisher.remove(b);
		b = new JComboBox(book);
		publisher.add(b);
		b.addItemListener(this);
	}

	public void updatePrice() {
		price = h.getPrice((String) b.getSelectedItem());
		publisher.remove(p);
		if(price == null) {
			price = "0";
		}
		p = new JTextField("$" + price);
		publisher.add(p, -1);

	}

	public void updateLocation() {
		store = h.getLocations((String) b.getSelectedItem());
		publisher.remove(s);
		s = new JList(store);
		publisher.add(s, -1);
	}
}
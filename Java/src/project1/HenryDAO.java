package project1;

import java.sql.*;
import java.util.ArrayList;

public class HenryDAO {
	private Connection conn = null;

	HenryDAO() {
		String db_url = "jdbc:mysql://localhost/comp3421";
		String user = "root";
		String pass = "password";
//		System.out.println("DAO Constructor");

		try {
			conn = DriverManager.getConnection(db_url, user, pass);
		} catch (SQLException e) {
			// TODO Auto-generated catch blocke.printStackTrace();}
		}

	}

	public String[] getAuthors() {

		ArrayList<String> a = new ArrayList<String>();
		try {

			Statement stmt = conn.createStatement();

			String sql = "SELECT AUTHOR_FIRST, AUTHOR_LAST FROM henry_author";

			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {

				String s = rs.getString("AUTHOR_FIRST") + " " + rs.getString("AUTHOR_LAST");
				a.add(s);

			}
		} catch (SQLException e) {

		}

		return GetStringArray(a);
	}
	
	public String[] getBooks(String author) {
		ArrayList<String> a = new ArrayList<String>();
		try {
			String name[] = author.split(" ");

			Statement stmt = conn.createStatement();

			String sql = "SELECT TITLE FROM henry_author JOIN henry_wrote ON henry_author.AUTHOR_NUM = henry_wrote.AUTHOR_NUM JOIN henry_book ON henry_book.BOOK_CODE = henry_wrote.BOOK_CODE WHERE (AUTHOR_FIRST LIKE \"%"
					+ name[0] + "%\" && AUTHOR_LAST LIKE \"%" + name[1] + "%\") GROUP BY TITLE";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				String s = rs.getString("Title");
				a.add(s);
			}
		} catch (SQLException e) {

		}

		return GetStringArray(a);
	}

	public String getPrice(String bookTitle) {

		String s = null;
		try {
			Statement stmt = conn.createStatement();

			String sql = "SELECT price FROM henry_book WHERE TITLE LIKE \"" + bookTitle + "\"";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				s = rs.getString("price");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return s;

	}

	public String[] getLocations(String title) {
		ArrayList<String> a = new ArrayList<String>();
		try {
			Statement stmt = conn.createStatement();

			String sql = "SELECT CONCAT(Branch_name, \"     \", on_hand)as request FROM henry_book JOIN henry_inventory on henry_book.book_code = henry_inventory.BOOK_CODE join henry_branch on henry_inventory.BRANCH_NUM = henry_branch.BRANCH_NUM WHERE TITLE like \""
					+ title + "\"";

			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				String s = rs.getString("request");
				a.add(s);
			}
		} catch (SQLException e) {

		}

		return GetStringArray(a);
	}

	public String[] GetStringArray(ArrayList<String> arr) {

		// declaration and initialise String Array
		String str[] = new String[arr.size()];

		// ArrayList to Array Conversion
		for (int j = 0; j < arr.size(); j++) {

			// Assign each value to String array
			str[j] = arr.get(j);
		}

		return str;
	}
	public String[] getCategories() {

		ArrayList<String> a = new ArrayList<String>();
		try {

			Statement stmt = conn.createStatement();

			String sql = "SELECT TYPE FROM henry_book";

			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {

				String s = rs.getString("TYPE");
				a.add(s);

			}
		} catch (SQLException e) {

		}

		return GetStringArray(a);
	}
	public String[] getBooksByCategory(String category) {
        ArrayList<String> a = new ArrayList<String>();
        try {
            String type[] = category.split(" ");

            Statement stmt = conn.createStatement();

            String sql = "SELECT TITLE FROM henry_book WHERE TYPE LIKE \"%"+ type[0] + "%\" GROUP BY TITLE";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                String s = rs.getString("Title");
                a.add(s);
            }
        } catch (SQLException e) {

        }

        return GetStringArray(a);
    }
	
	public String[] getPublishers() {

		ArrayList<String> a = new ArrayList<String>();
		try {

			Statement stmt = conn.createStatement();

			String sql = "SELECT publisher_name FROM henry_publisher";

			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {

				String s = rs.getString("publisher_name");
				a.add(s);

			}
		} catch (SQLException e) {

		}

		return GetStringArray(a);
	}
	
	public String[] getPublisherBooks(String name) {
		ArrayList<String> a = new ArrayList<String>();
		try {

			Statement stmt = conn.createStatement();

			String sql = "SELECT TITLE FROM henry_publisher JOIN henry_book  on henry_publisher.PUBLISHER_CODE = henry_book.PUBLISHER_CODE WHERE publisher_name like '" + name + "'";
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {

				String s = rs.getString("TITLE");
				a.add(s);

			}
		} catch (SQLException e) {

		}

		return GetStringArray(a);
	}
	
	
	
}

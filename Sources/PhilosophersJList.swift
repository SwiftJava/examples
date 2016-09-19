//
//  PhilosophersJList.swift
//  SwiftJava
//
//  Created by John Holdsworth on 28/07/2016.
//  Copyright © 2016 John Holdsworth. All rights reserved.
//

// Original Java Version: http://java.happycodings.com/swing/code2.html

import java_lang
import java_awt
import javax_swing

var philosophers: DefaultListModel!
var list2: JList!

class PhilosophersJList: JFrame {

    init()
    {
        let frame = try! JFrame("Favorite Philosophers")
        super.init(javaObject: frame.takeJavaObject)

        // create a DefaultListModel to store philosophers
        philosophers = DefaultListModel()
        philosophers.addElement( JavaString("Socrates") )
        philosophers.addElement( JavaString("Plato") )
        philosophers.addElement( JavaString("Aristotle") )
        philosophers.addElement( JavaString("St. Thomas Aquinas") )
        philosophers.addElement( JavaString("Soren Kierkegaard") )
        philosophers.addElement( JavaString("Immanuel Kant") )
        philosophers.addElement( JavaString("Friedrich Nietzsche") )
        philosophers.addElement( JavaString("Hannah Arendt") )

        // create a JList for philosophers DefaultListModel
        list2 = JList( philosophers )

        // allow user to select only one philosopher at a time
        //list.setSelectionMode(ListSelectionModel.SINGLE_SELECTION )

        // create JButton for adding philosophers
        let addButton = JButton( "Add Philosopher" )

        class MyActionListener: ActionListenerBase {
            override func actionPerformed( e: ActionEvent? ) {
                // prompt user for new philosopher's name
                if let name = try! JOptionPane.showInputDialog(
                    /*PhilosophersJList.this,*/ JavaString("Enter Name") ) {

                // add new philosopher to model
                philosophers.addElement( JavaString(name) )
                }
            }
        }

        addButton.addActionListener( MyActionListener() )

        // create JButton for removing selected philosopher
        let removeButton = JButton( "Remove Selected Philosopher" )

        class MyActionListener2: ActionListenerBase {
            override func actionPerformed( e: ActionEvent? ) {
                // remove selected philosopher from model
                _ = philosophers.removeElement(
                    list2.getSelectedValue() )
            }
        }

        removeButton.addActionListener( MyActionListener2() )

        // lay out GUI components
        let inputPanel = JPanel()
        _ = inputPanel.add( addButton )
        _ = inputPanel.add( removeButton )

        let container = getContentPane()!
        container.add( list2, JavaString(BorderLayout.CENTER) )
        container.add( inputPanel, JavaString(BorderLayout.NORTH) )

        setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE )
        setSize( 400, 300 )
        setVisible( true )

    } // end PhilosophersJList constructor

    required init(javaObject: jobject?) {
        fatalError("init(javaObject:) has not been implemented")
    }
}


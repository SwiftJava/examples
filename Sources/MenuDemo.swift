//
//  MenuDemo.swift
//  SwiftJava
//
//  Created by John Holdsworth on 29/07/2016.
//  Copyright © 2016 John Holdsworth. All rights reserved.
//

// Original Java Version: http://java.happycodings.com/swing/code29.html

import java_lang
import java_awt
import javax_swing

public class MenuDemo {

    public static func main() {
        let win = MenuDemoGUI()
        win.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE)
        win.setVisible(true)
    }
}


///// MenuDemoGUI
class MenuDemoGUI: JFrame {

    let m_editArea = JTextArea(20, 50)
    let m_fileMenu = JMenu("File")// declare and create new menu
    let m_openItem = JMenuItem("Open") // create new menu item
    let m_quitItem = JMenuItem("Quit") // another menu item
    let m_editMenu = JMenu("Edit")
    let m_copyItem = JMenuItem("Copy")
    let m_pasteItem = JMenuItem("Paste")

    init() {
        super.init(javaObject: nil)
        JFrame().withJavaObject {
            self.javaObject = $0
        }

        //... Add listeners to menu items
        m_openItem.addActionListener(OpenAction())
        m_quitItem.addActionListener(QuitAction())
        // Copy and Paste don't have listeners yet, so disable them for now.
        m_copyItem.setEnabled(false)
        m_pasteItem.setEnabled(false)

        //... Menubar, menus, menu items.  Use indentation to show structure.
        let menubar = JMenuBar()  // declare and create new menu bar
        _ = menubar.add(m_fileMenu)        // add the menu to the menubar
        _ = m_fileMenu.add(m_openItem) // add the menu item to the menu
        _ = m_fileMenu.addSeparator()  // add separator line to menu
        _ = m_fileMenu.add(m_quitItem)
        _ = menubar.add(m_editMenu)
        _ = m_editMenu.add(m_copyItem)
        _ = m_editMenu.add(m_pasteItem)

        //... Content pane: create, layout, add components
        let content = JPanel()
        content.setLayout( BorderLayout())
        content.add(m_editArea, JavaString(BorderLayout.CENTER))

        //... Set JFrame's menubar, content pane, and title.
        self.setContentPane(content)       // Set windows content pane..
        self.setJMenuBar(menubar)          // Set windows menubar.
        self.pack()
        self.setTitle("MenuDemo")
    }//endconstructor

    required init(javaObject: jobject?) {
        fatalError("init(javaObject:) has not been implemented")
    }

    //// OpenAction
    class OpenAction: ActionListenerBase {
        override func actionPerformed(e: ActionEvent?) {
            try! JOptionPane.showMessageDialog(nil, JavaString("Sorry, can't open anything"))
        }
    }

    /// QuitAction
    class QuitAction: ActionListenerBase {
        override func actionPerformed(e: ActionEvent?) {
            System.exit(0)  // terminate this program
        }
    }
}

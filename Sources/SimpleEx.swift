//
//  SimpleEx.swift
//  SwiftJava
//
//  Created by John Holdsworth on 28/07/2016.
//  Copyright © 2016 John Holdsworth. All rights reserved.
//

// Original Java Version: http://zetcode.com/tutorials/javaswingtutorial/firstprograms/

import java_lang
import java_awt
import javax_swing

public class SimpleEx : JFrame {

    public init() {
        super.init(javaObject: nil)
        JFrame().withJavaObject {
            self.javaObject = $0
        }
        initUI()
    }

    required public init(javaObject: jobject?) {
        fatalError("init(javaObject:) has not been implemented")
    }

    private func initUI() {

        let quitButton = JButton("Quit")

        class MyActionListener: ActionListenerBase {
            override func actionPerformed(arg0 event: ActionEvent?) {
                System.exit(0)
            }
        }

        quitButton.addActionListener(MyActionListener())

        createLayout(quitButton)

        setTitle("Simple example")
        setSize(300, 200)
        setLocationRelativeTo(nil)
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE)
    }

    func createLayout(_ arg: JComponent) {

        let pane = getContentPane()!
        let gl = GroupLayout(arg0: pane)
        pane.setLayout(gl)

        gl.setAutoCreateContainerGaps(true)

        gl.setHorizontalGroup(gl.createSequentialGroup()
            .addComponent(arg)
        )

        gl.setVerticalGroup(gl.createSequentialGroup()
            .addComponent(arg)
        )
    }

}


//
//  FocusTest.swift
//  SwiftJava
//
//  Created by John Holdsworth on 28/07/2016.
//  Copyright © 2016 John Holdsworth. All rights reserved.
//

import java_lang
import java_awt
import javax_swing


public class FocusTest: JFrame {

    var jtf1: JTextField!, jtf2: JTextField!, jtf3: JTextField!
    var p: JPanel!

    public init()
    {
        super.init(javaObject: nil)
        JFrame().withJavaObject {
            self.javaObject = $0
        }

        jtf1 = JTextField(10)
        jtf2 = JTextField(10)
        jtf3 = JTextField(10)

        jtf1.addKeyListener(MyKeyListener( ft: self ))

        p = JPanel()
        _ = p.add(jtf1)
        _ = p.add(jtf2)
        _ = p.add(jtf3)

        _ = getContentPane().add(p)
    }

    required public init(javaObject: jobject?) {
        fatalError("init(javaObject:) has not been implemented")
    }

    class MyKeyListener: KeyListenerBase {

        var ft: FocusTest

        init( ft: FocusTest) {
            self.ft = ft
            super.init()
        }

        required init(javaObject: jobject!) {
            fatalError("init(javaObject:) has not been implemented")
        }

        internal override func keyPressed(e: KeyEvent?)
        {
            if(e?.getKeyCode() == KeyEvent.VK_ENTER)
            {
                Swift.print("ll")
                ft.jtf3.requestFocus()
            }
        }
    }
}

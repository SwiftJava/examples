//
//  AWTGraphicsDemo.swift
//  SwiftJava
//
//  Created by John Holdsworth on 29/07/2016.
//  Copyright © 2016 John Holdsworth. All rights reserved.
//

// Original Java Version: http://www.tutorialspoint.com/awt/awt_line2d_class.htm

import java_lang
import java_awt

public class AWTGraphicsDemo: FrameBase {

    public static func main(){
        let awtGraphicsDemo = AWTGraphicsDemo()
        awtGraphicsDemo.setVisible(true)
    }

    public init(){
        super.init(javaObject: nil)
        withExtendedLifetime(FrameBase()) {
            javaObject = $0.javaObject
        }
        prepareGUI()
    }

    required public init(javaObject: jobject!) {
        fatalError("init(javaObject:) has not been implemented")
    }

    private func prepareGUI(){
        setSize(400,400)
        class MyWindowAdapter: WindowAdapterBase {
            override func windowClosing( e: WindowEvent? ) {
                System.exit( 0 )
            }
        }
        addWindowListener(MyWindowAdapter())
    }

    override public func paint(arg0: Graphics?) {
        let g = arg0!
        let shape = Line2D_Double()
        shape.setLine(250,250,150,150)
        let g2 = Graphics2D(casting: g)!
        g2.draw (shape)
        let font = Font("Serif", Font.PLAIN, 24)
        g2.setFont(font)
        g.drawString("Welcome to TutorialsPoint", 50, 70)
        g2.drawString("Line2D.Line", 100, 120)  
    }
}

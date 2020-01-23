//
//  PopupTest.swift
//  SwiftJava
//
//  Created by John Holdsworth on 29/07/2016.
//  Copyright © 2016 John Holdsworth. All rights reserved.
//

// Original Java Version: http://java.happycodings.com/swing/code43.html

import java_lang
import java_awt
import javax_swing

var popupTest: PopupTest!

public class PopupTest: JFrameBase
{
    public static func main()
    {
        let app = PopupTest()

        class MyWindowAdapter: WindowAdapterBase {
            override func windowClosing( e: WindowEvent? )
            {
                System.exit( 0 )
            }
        }
        app.addWindowListener( MyWindowAdapter() )
    }

    private var items: [JRadioButtonMenuItem]!
    var popupMenu: JPopupMenu!

    public init()
    {
        super.init(javaObject: nil)
        inherit(try! JFrameBase("Using JPopupMenus"))
        popupTest = self

        popupMenu = JPopupMenu()
        let handler = ItemHandler()
        let colors = ["Blue", "Yellow", "Red"]
        let colorGroup = ButtonGroup()
        items = [JRadioButtonMenuItem]( repeating: JRadioButtonMenuItem(), count: colors.count )

        // construct each menu item and add to popup menu also
        // enable event handling for each menu item
        for i in 0..<items.count
        {
            items[ i ] = JRadioButtonMenuItem( colors[ i ] )
            _ = popupMenu.add( items[ i ] )
            colorGroup.add( items[ i ] )
            items[ i ].addActionListener( handler )
        }

        getContentPane().setBackground( Color.white )

        // define a MouseListener for the window that displays
        // a JPopupMenu when the popup trigger event occurs

        class MyMouseAdapter: MouseAdapterBase {
            override func mousePressed( e: MouseEvent? )
            {
                checkForTriggerEvent( e )
            }

            override func mouseReleased( e: MouseEvent? )
            {
                checkForTriggerEvent( e )
            }

            private func checkForTriggerEvent( _ e: MouseEvent? )
            {
                if ( e!.isPopupTrigger() ) {
                    popupTest.popupMenu.show( e!.getComponent(), e!.getX(), e!.getY() )
                }
            }
        }

        addMouseListener( MyMouseAdapter() )
        setSize( 300, 200 )
        show()
    }

    required public init(javaObject: jobject?) {
        fatalError("init(javaObject:) has not been implemented")
    }

    private class ItemHandler: ActionListenerBase
    {
        override func actionPerformed( e: ActionEvent? )
        {
            let colorValues = [Color.blue, Color.yellow, Color.red]

            // determine which menu item was selected
            for i in 0..<popupTest.items.count {
                if ( e!.getSource().equals(popupTest.items[ i ]) )
                {
                    popupTest.getContentPane().setBackground( colorValues[ i ] )
                    popupTest.repaint()
                    return
                }
            }
        }
    }
}

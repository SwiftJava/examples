//
//  main.swift
//  examples
//
//  Created by John Holdsworth on 20/07/2016.
//  Copyright (c) 2016 John Holdsworth. All rights reserved.
//

import java_lang
import java_util
import java_awt
import javax_swing

print( String(describing: Runtime.getRuntime().javaObject) )
print( String(describing: Runtime.getRuntime().maxMemory()) )
let e = java_lang.Exception("JKKH")
print( String(describing: e.javaObject) )
print( String(describing: ClassNotFoundException(casting: e)) )
print( String(describing: Throwable(casting: e)) )
print( String(describing: Exception(casting: e)) )
print( String(describing: JavaClass(casting: e)) )
print( String(describing: System.getenv("HOME")) )
print( System.getProperty("java.class.path") )
print( System.getProperty("java.version") )
print( System.getProperty("java.vendor") )
print( System.getProperty("java.home") )
print( "\(System.getProperty("xx"))" )

let imagePath = System.getProperty("user.home")+"/Untitled.png"

JNI.background {
    let f = try! Frame( "Hello World" )

    class MyWidowListener: WindowListenerBase {
        override func windowClosing( e: WindowEvent? ) {
            Runtime.getRuntime().exit(0)
        }
    }

    f.addWindowListener(MyWidowListener())

    let b = try! Button("click me")
    b.setBounds(30,50,80,30)

    class MyActionListener: ActionListenerBase {
        override func actionPerformed( e:ActionEvent?) {
            print("here!")
        }
    }

    b.addActionListener( MyActionListener() )

    _ = f.add(b)
    f.setSize(300,300)

    f.setLayout( nil )
    f.setVisible(true)
}

JNI.background {
    _ = SimpleJTreeExample( "Simple JTree Example" )
}

JNI.background {
    let frame = try! Frame("ImageCanvas")
    frame.setLayout(BorderLayout())
    _ = frame.add("Center", ImageCanvas(imagePath))
    frame.resize(400,400)
    frame.show()
}

Thread( {
    let ex = SimpleEx()
    ex.setVisible(true)
} ).start()

JNI.background {
    _ = PhilosophersJList()
}

JNI.background {
    let ft = FocusTest()
    ft.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE)
    ft.setSize(200,200)
    ft.setVisible(true)
}

var tt: TextTest!

JNI.background {
    let tt = TextTest(imagePath)
    tt.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE)
    tt.setSize(750,600)
    tt.setVisible(true)
}

JNI.background {
    let f =  try! JFrame("AutoCompleteComboBox")
    f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE)
    f.setSize(200,300)
    let cp = f.getContentPane()!
    cp.setLayout(nil)
    //        let names = ["Beate", "Claudia", "Fjodor", "Fred", "Friedrich",    "Fritz", "Frodo", "Hermann", "Willi"]
    //        cBox = AutoComplete(items: names.map { JavaString( $0 ) })
    let locales = JavaLocale.getAvailableLocales()!//
    cBox = AutoComplete(items: locales)
    cBox.setBounds(50,50,100,21)
    cBox.setEditable(true)
    _ = cp.add(cBox)
    f.setVisible(true)
}

JNI.background {
    let tes = TableColumnColor()
    tes.setVisible(true)
    tes.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE)
}

JNI.background {
    let win = MenuDemoGUI()
    win.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE)
    win.setVisible(true)
}

JNI.background {
    let app = PopupTest()

    class MyWindowAdapter: WindowAdapterBase {
        override func windowClosing( e: WindowEvent? )
        {
            System.exit( 0 )
        }
    }
    app.addWindowListener( MyWindowAdapter() )
}

JNI.background {
    let awtGraphicsDemo = AWTGraphicsDemo()
    awtGraphicsDemo.setVisible(true)
}

JNI.background {
    _ = TableColorSelection()
}

//JNI.background {
//    sleep(5)
//    System.gc()
//}

JNI.run()

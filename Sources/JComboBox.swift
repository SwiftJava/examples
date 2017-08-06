//
//  JComboBox.swift
//  SwiftJava
//
//  Created by John Holdsworth on 28/07/2016.
//  Copyright © 2016 John Holdsworth. All rights reserved.
//

// Original Java Version: http://java.happycodings.com/swing/code5.html

import java_lang
import java_util
import java_awt
import javax_swing

private func +(left: String!, right: UInt16) -> String {
    var left = left ?? ""
    left.append( String( UnicodeScalar(right)! ) )
    return left
}

var cBox: AutoComplete!

class AutoComplete: JComboBox
{

    static func main() {
        let f =  try! JFrame("AutoCompleteComboBox")
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE)
        f.setSize(200,300)
        let cp = f.getContentPane()!
        cp.setLayout(nil)
//        let names = ["Beate", "Claudia", "Fjodor", "Fred", "Friedrich",	"Fritz", "Frodo", "Hermann", "Willi"]
//        cBox = AutoComplete(items: names.map { JavaString( $0 ) })
        let locales = JavaLocale.getAvailableLocales()!//
        cBox = AutoComplete(items: locales)
        cBox.setBounds(50,50,100,21)
        cBox.setEditable(true)
        _ = cp.add(cBox)
        f.setVisible(true)
    }

    private var searchFor: String!
    private var lap: jlong!

    class CBDocument: PlainDocumentBase {
        override func insertString( offs:Int,  str: String? ,  a: AttributeSet?) throws {
            if (str==nil) { return }
            try super.insertString(offs:offs, str: str, a: a)
            if(!cBox.isPopupVisible() && JavaString(str).length() != 0) { cBox.fireActionEvent() }
        }
    }

    class MyJComboBox_KeySelectionManager: JComboBox_KeySelectionManagerBase {

        override func selectionForKey(  aKey: UInt16,  aModel: ComboBoxModel? ) -> Int {
            let now = java_util.Date().getTime()
            if ( cBox.searchFor != nil  && aKey == UInt16(KeyEvent.VK_BACK_SPACE) && JavaString(cBox.searchFor).length()>0 )
            {
                cBox.searchFor = JavaString(cBox.searchFor).substring(0, JavaString(cBox.searchFor).length() - 1)
            }
            else
            {
                //	System.out.println(lap)
                // Kam nie hier vorbei.
                if(cBox.lap + 1000 < now) {
                    cBox.searchFor = "" + aKey
                }
                else {
                    cBox.searchFor = cBox.searchFor + aKey
                }
            }
            cBox.lap = now
            var current: String!
            for i in 0..<aModel!.getSize()
            {
                current = JavaString(aModel!.getElementAt(index: i).toString()).toLowerCase()
                if (JavaString(JavaString(current).toLowerCase()).startsWith(JavaString(cBox.searchFor).toLowerCase())) { return i }
            }
            return -1
        }

    }

    init(items: [JavaObject])
    {
        super.init(javaObject: nil)
        JComboBox(items).withJavaObject {
            self.javaObject = $0
        }
        lap = java_util.Date().getTime()
        setKeySelectionManager(MyJComboBox_KeySelectionManager())
        if(getEditor() != nil)
        {
            if let tf = JTextField(casting: getEditor().getEditorComponent())
            {
                tf.setDocument( CBDocument() )

                class MyActionListener: ActionListenerBase {

                    override func actionPerformed(e: ActionEvent?)
                    {
                        let tf = JTextField(casting: cBox.getEditor().getEditorComponent())!
                        let text = tf.getText()!
                        let aModel = cBox.getModel()!
                        var current: String
                        for i  in 0..<aModel.getSize()
                        {
                            current = aModel.getElementAt(index: i).toString()
                            if(JavaString(JavaString(current).toLowerCase()).startsWith(JavaString(text).toLowerCase()))
                            {
                                tf.setText(current)
                                tf.setSelectionStart(JavaString(text).length())
                                tf.setSelectionEnd(JavaString(current).length())
                                break
                            }
                        }
                    }
                }

                addActionListener(MyActionListener())
            }

        }
    }

    required init(javaObject: jobject?) {
        fatalError("init(javaObject:) has not been implemented")
    }

    override func fireActionEvent()
    {
        super.fireActionEvent()
    }
}

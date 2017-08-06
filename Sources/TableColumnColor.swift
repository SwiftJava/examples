//
//  TableColumnColor.swift
//  SwiftJava
//
//  Created by John Holdsworth on 28/07/2016.
//  Copyright © 2016 John Holdsworth. All rights reserved.
//

// Original Java Version: http://java.happycodings.com/swing/code8.html

import java_lang
import java_awt
import javax_swing

func objectArray( _ stringArray: [String] ) -> [JavaObject] {
    return stringArray.map { JavaString($0) }
}

public class TableColumnColor: JFrameBase
{
    static var tes: TableColumnColor!

    public static func main() {
        tes = TableColumnColor()
        tes.setVisible(true)
        tes.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE)
    }

    let columnNames = objectArray( ["Column1", "Column2","Column3"] )
    var data = [
        objectArray( ["copy.gif", "Image1", "dd"] ),
        objectArray( ["save.gif", "Image2", "dd"] ),
        objectArray( ["script.gif", "Image3", "dd"] ),
        objectArray( ["task.gif", "Image4", "dd"] ),
    ]

    public init()
    {
        super.init(javaObject: nil)
        inherit(JFrameBase())

        let dtm = DefaultTableModel(data,columnNames)

        class MyJTable: JTableBase {

            init( _ model: TableModel ) {
//                super.init(model)
                super.init(javaObject:nil)
                inherit(JTableBase(model))
            }

            required init(javaObject: jobject!) {
                super.init( javaObject: javaObject )
            }

            override func prepareRenderer( arg0: TableCellRenderer?, arg1: Int, arg2: Int ) -> Component!
            {
                let renderer = arg0, row = arg1, column = arg2
                let component = super.prepareRenderer( arg0: renderer, arg1: row, arg2: column)!

                if(column == 0)
                {
                    component.setBackground(Color.yellow)
                }
                if(column == 1)
                {
                    component.setBackground(Color.red)
                }
                if(column == 2)
                {
                    component.setBackground(Color.pink)
                }

                return component
            }
        }

        let table = MyJTable(dtm)

        let scroll = JScrollPane(table)
        setContentPane(scroll)
        setBounds(100,50,300,150)
    }

    required public init(javaObject: jobject?) {
        fatalError("init(javaObject:) has not been implemented")
    }

}

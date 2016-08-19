//
//  TableColorSelection.swift
//  SwiftJava
//
//  Created by John Holdsworth on 09/08/2016.
//  Copyright © 2016 John Holdsworth. All rights reserved.
//

// Original Java Version: http://java.happycodings.com/swing/code10.html

import java_lang
import java_util
import java_awt
import javax_swing

private var table: JTable!

public class TableColorSelection: JFrame {
    let columns = ["mon","tue","wed"].map { JavaString($0) }
    static public let givenColor = Color(255,128,54)

    public func main(arg: [String]) {
        _ = TableColorSelection()
    }

    public init() {
        class MyDefaultTableModel: DefaultTableModelBase {
            override public func isCellEditable(row: Int, column: Int) -> Bool {
                return false;
            }
        }

        let model = MyDefaultTableModel(columns.map { JavaObject(casting:$0)! },0)
        model.addRow(["1","2","3"].map { JavaString($0) })
        model.addRow(["4","5","6"].map { JavaString($0) })
        model.addRow(["7","8","9"].map { JavaString($0) })

        let defaultOffDays = ["3","6","9"].map { JavaString($0) }

        table = MT( model, defaultOffDays )
        table.setCellSelectionEnabled(true)
        table.setSelectionMode(ListSelectionModelForward.SINGLE_SELECTION)

        let scroller = JScrollPane(table)

        scroller.setBounds(10,10,300,200)

        let panel = JPanel()

        panel.setLayout(nil)
        _ = panel.add(scroller)

        super.init( javaObject: JFrame().javaObject )

        _ = getContentPane().add(panel);
        setSize(400,400);
        setVisible(true);
    }

    required public init(javaObject: jobject?) {
        fatalError("init(javaObject:) has not been implemented")
    }
}

class MT: JTableBase {
    public init( _ dm: TableModel, _ defaultOffDays: [JavaObject] ) {
        super.init(javaObject: JTableBase(dm).javaObject)
        setDefaultRenderer(JavaObject().getClass(), MyCellRenderer(defaultOffDays))
    }

    required init(javaObject: jobject?) {
        fatalError("init(javaObject:) has not been implemented")
    }

    override public func changeSelection( arg0: Int, arg1: Int, arg2: Bool, arg3: Bool ) {
        let r = arg0, c = arg1, toggle = arg2, extend = arg3
        super.changeSelection(arg0: r, arg1: c, arg2: toggle, arg3: extend)

        let renderer = MyCellRenderer(casting: getDefaultRenderer(JavaObject().getClass()))

        let val = getValueAt(r,c)!

        if (renderer.isRed(val)) {
            renderer.makeBlue(val)
        }
        else {
            renderer.clearValue()
        }
    }

    class MyCellRenderer: DefaultTableCellRendererBase {
        let selectedValues = java_util.ArrayList()
        var v: JavaObject! = nil

        public init( _ defaultOffDays: [JavaObject] ) {
            for i in 0..<defaultOffDays.count {
                _ = selectedValues.add(defaultOffDays[i])
            }
            super.init( javaObject: DefaultTableCellRendererBase().javaObject )
        }

        public init( casting object: TableCellRenderer, _ file: StaticString = #file, _ line: Int = #line ) {
            super.init( javaObject: object.javaObject )
        }

        required init(javaObject: jobject?) {
            fatalError("init(javaObject:) has not been implemented")
        }

        override public func getTableCellRendererComponent( table: JTable?, value: JavaObject?,
                                                   isSelected: Bool, hasFocus: Bool,
                                                   row: Int, column: Int ) -> Component {
            let label = JLabel(casting: super.getTableCellRendererComponent(table: table, value: value, isSelected: isSelected,
                                                                            hasFocus: hasFocus, row: row, column: column) )

            setHorizontalAlignment(javax_swing.SwingConstantsForward.CENTER);
            setText(value?.toString());

            if (isSelected && v != nil && !(v.equals(value))) {
                setForeground(Color.RED)

                if (!selectedValues.contains(value)) {
                    //value already remembered, and reselected, make FG blue
                    _ = selectedValues.add(value)
                }
            }
            else {
                //not selected
                setForeground(selectedValues.contains(value) ? Color.RED : Color.BLUE)
            }
            return Component( casting: label! )!
        }

        public func isRed( _ value: JavaObject ) -> Bool {
            // System.out.println("isRed: " + selectedValues.contains(value));
            return selectedValues.contains(value)
        }
        public func makeBlue( _ value: JavaObject ) {
            v = value
            _ = selectedValues.remove(value)
        }
        public func clearValue() {
            v = nil
        }
    }
}

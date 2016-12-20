//
//  TestText.swift
//  SwiftJava
//
//  Created by John Holdsworth on 28/07/2016.
//  Copyright © 2016 John Holdsworth. All rights reserved.
//

// Original Java Version: http://java.happycodings.com/swing/code4.html

import java_lang
import java_awt
import javax_swing

class TextTest: JFrame {

    static func main() {
        let tt = TextTest(imagePath)
        tt.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE)
        tt.setSize(750,600)
        tt.setVisible(true)
    }

    var s: String!
    var img: ImageIcon!
    var image: Image!
    var p: JPanel!
    var label: JLabel!
    var text: JLabel!

    init( _ imagePath: String )
    {
        super.init(javaObject: nil)
        JFrame().withJavaObject {
            self.javaObject = $0
        }

        s = "Hi"
        let f = Font("Serif",Font.BOLD,12)
        text = JLabel("Hi")
        text.setFont(f)

        let mt = MediaTracker(arg0: self)
        image = Toolkit.getDefaultToolkit().createImage(imagePath)
        mt.addImage(image,0)
        do { try mt.waitForID(0) }
        catch let ie as InterruptedException {
            ie.printStackTrace()
        }
        catch {}
        let width = image.getWidth(nil)
        let height = image.getHeight(nil)
        if width < 0 { return }
        let bimg = BufferedImage(width, height, BufferedImage.TYPE_INT_RGB)
        _ = bimg.createGraphics().drawImage(image, 0, 0, self)
        bimg.getGraphics().setFont(f)
        bimg.getGraphics().drawString(s,250,100)

        img = ImageIcon(bimg)
        label = JLabel(img)
        p = JPanel()
        _ = p.add(label)
        _ = getContentPane().add(p)
    }

    required init(javaObject: jobject?) {
        fatalError("init(javaObject:) has not been implemented")
    }
}

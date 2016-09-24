//
//  ImageCanvas.swift
//  SwiftJava
//
//  Created by John Holdsworth on 28/07/2016.
//  Copyright © 2016 John Holdsworth. All rights reserved.
//

// Original Java Version: http://www.rgagnon.com/javadetails/java-0229.html

import java_lang
import java_awt

class ImageCanvas: CanvasBase {
    var image: Image!

    static func main( _ imagePath: String ) {
        let frame = try! Frame("Image")
        frame.setLayout(BorderLayout())
        _ = frame.add("Center", ImageCanvas(imagePath))
        frame.resize(400,400)
        frame.show()
    }

    init(_ imagePath: String) {
        super.init(javaObject: nil)
        CanvasBase().withJavaObject {
            self.javaObject = $0
        }
        let media = MediaTracker(comp: self)
        image = Toolkit.getDefaultToolkit().getImage(imagePath)
        media.addImage(image, 0)
        do {
            try media.waitForID(0)
        }
        catch {}
    }

    init(imageProducer:ImageProducer) {
        super.init(javaObject: nil)
        CanvasBase().withJavaObject {
            self.javaObject = $0
        }
        image = createImage(imageProducer)
    }

    required init(javaObject: jobject?) {
        fatalError("init(javaObject:) has not been implemented")
    }

    override func paint( g: Graphics? ) {
        _ = g?.drawImage(image, 0,0, self)
    }

}


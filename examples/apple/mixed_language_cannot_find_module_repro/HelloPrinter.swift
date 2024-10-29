import Foundation
import Printer
import Renderer

@objc(HelloPrinterSwift)
public class HelloPrinter: NSObject {
    @objc public static func print(_ name: NSString) {
        Printer(prefix: "***").print("Hello \(name)" as NSString)
    }
}

extension HelloPrinter: RenderProtocol {
  public func render(_ name: NSString) {
    HelloPrinter.print(name)
  }
}
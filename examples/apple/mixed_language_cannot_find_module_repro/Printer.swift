import Foundation
import Renderer

@objc(PrinterSwift)
public class Printer: NSObject {
  private let renderer: Renderer

  @objc public init(prefix: NSString) {
    self.renderer = Renderer(prefix: prefix)
  }

  @objc public func print(_ message: NSString) {
    renderer.render(message)
  }
}

extension Printer: RenderProtocol {
  public func render(_ message: NSString) {
    print(message)
  }
}
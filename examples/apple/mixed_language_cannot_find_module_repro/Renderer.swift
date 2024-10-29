import Foundation

@objc(RendererSwift)
public class Renderer: NSObject {
  private let prefix: String

  @objc public init(prefix: NSString) {
    self.prefix = prefix as String
  }

  @objc public func render(_ message: NSString) {
    print("\(prefix)\(message as String)")
  }
}

@objc(RendererSwiftProtocol)
public protocol RenderProtocol: NSObjectProtocol {
    func render(_ message: NSString)
}
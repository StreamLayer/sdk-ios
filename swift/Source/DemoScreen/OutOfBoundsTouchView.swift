import UIKit

final class OutOfBoundsTouchView: UIView {
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    if isHidden || alpha == 0 { return super.hitTest(point, with: event) }
    for member in subviews.reversed() {
        let subPoint = member.convert(point, from: self)
        guard let result = member.hitTest(subPoint, with: event) else { continue }
        return result
    }
    
    return super.hitTest(point, with: event)
  }
}

import UIKit

class FontManager: NSObject {
    
    static let sharedInstance = FontManager()
    
    public func black(size: CGFloat) -> UIFont {
        return UIFont(name: "Rubik-Black", size: size)!
    }
    
    public func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "Rubik-Bold", size: size)!
    }
    
    public func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "Rubik-Regular", size: size)!
    }
    
    public func medium(size: CGFloat) -> UIFont {
        return UIFont(name: "Rubik-Medium", size: size)!
    }
    
    public func light(size: CGFloat) -> UIFont {
        return UIFont(name: "Rubik-Light", size: size)!
    }
    
}

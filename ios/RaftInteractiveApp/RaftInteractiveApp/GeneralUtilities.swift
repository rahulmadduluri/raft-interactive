import UIKit

enum Environment {
    case dev
    case prod
}

class GeneralUtilities {
    
    static let categoryType = "categories"
    static let userType = "users"
    static let serviceType = "services"
    static let portfolioType = "portfolios"
    
    static let raftColor: UIColor = UIColor(hexString: "3D00EB")
    
    fileprivate static let baseURLDevelopment = "http://localhost:8080"
    fileprivate static let baseURLProduction = "https://raft.one"
    fileprivate static let baseURLWebsocketDevelopment = "ws://localhost:8080"
    fileprivate static let baseURLWebsocketProduction = "wss://raft.one"
    
    static func urlForPhotoURI(type: String, uri: String) -> URL {
        let urlString = baseURL() + "/static/" + type + "/" + uri
        let url = URL(string: urlString)!
        return url
    }
    
    static func env() -> Environment {
        return Environment.dev
    }
    
    static func baseURL() -> String {
        if env() == .prod {
            return baseURLProduction
        } else {
            return baseURLDevelopment
        }
    }
    
    static func baseURLWebsocket() -> String {
        if env() == .prod {
            return baseURLWebsocketProduction
        } else {
            return baseURLWebsocketDevelopment
        }
    }
}

extension Array {
    
    func shiftRight(amount: Int) -> Array<Element> {
        
        // 1
        guard self.count > 0, (amount % self.count) != 0 else { return self }
        
        // 2
        let moduloShiftAmount = amount % self.count
        let negativeShift = amount < 0
        let effectiveShiftAmount = negativeShift ? moduloShiftAmount + self.count : moduloShiftAmount
        
        // 3
        let shift: (Int) -> Int = { return $0 + effectiveShiftAmount >= self.count ? $0 + effectiveShiftAmount - self.count : $0 + effectiveShiftAmount }
        
        // 4
        return self.enumerated().sorted(by: { shift($0.offset) < shift($1.offset) }).map { $0.element }
        
    }
    
    mutating func shiftRightInPlace(amount: Int) {
        self = shiftRight(amount: amount)
    }
}

extension UIColor {
    
    convenience init(hexString: String) {
        
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (0, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    var toHex: String? {
        return toHex()
    }
    
    // MARK: - From UIColor to String
    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
}

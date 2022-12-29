//
//  ExtensionTool.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/8/12.
//

import UIKit
import Foundation
import Alertift
import ZKProgressHUD
import SwifterSwift


public class Once {
    var already: Bool = false

    public init() {}

    public func run(_ block: () -> Void) {
        guard !already else {
            return
        }

        block()
        already = true
    }
}


extension UIView {
    func changeToImage() -> UIImage {
        let size = self.bounds.size
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        self.layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func changeToTranslucentImage() -> UIImage {
        let size = self.bounds.size
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}


//extension UIApplication {
//    public static var rootController: UIViewController? {
//        if #available(iOS 13.0, *) {
//            return shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
//        } else {
//            return shared.keyWindow?.rootViewController
//        }
//
//    }
//}



public struct HUD {
    public static func show() {
        guard !ZKProgressHUD.isShowing else { return }
        ZKProgressHUD.show()
    }

    public static func hide() {
        ZKProgressHUD.dismiss()
    }
    
    public static func message(string: String) {
        hide()
        ZKProgressHUD.showMessage(string)
    }
    
    public static func error(_ value: String? = nil) {
        hide()
        ZKProgressHUD.showError(value, autoDismissDelay: 2.0)
    }

    public static func success(_ value: String? = nil) {
        hide()
        ZKProgressHUD.showSuccess(value, autoDismissDelay: 2.0)
    }
    
    public static func progress(_ value: CGFloat?) {
        ZKProgressHUD.showProgress(value)
    }
    
    public static func progress(_ value: CGFloat?, status: String? = nil) {
        
        ZKProgressHUD.showProgress(value, status: status, onlyOnceFont: UIFont(name: "Avenir-Black", size: 14))
    }
}

public extension UIApplication {
    @discardableResult
    func openURL(url: URL) -> Bool {
        guard UIApplication.shared.canOpenURL(url) else { return false }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        return true
    }

    @discardableResult
    func openURL(url: String?) -> Bool {
        guard let str = url, let url = URL(string: str) else { return false }
        return openURL(url: url)
    }
}

//public struct Alert {
//    public static func error(_ value: String?, title: String? = "Error", success: (() -> Void)? = nil) {
//
//        HUD.hide()
//        Alertift
//            .alert(title: title, message: value)
//            .action(.cancel("OK"), handler: { _, _, _ in
//                success?()
//            })
//            .show(on: UIApplication.rootController?.visibleVC, completion: nil)
//    }
//
//    public static func message(_ value: String?, success: (() -> Void)? = nil) {
//
//        HUD.hide()
//        Alertift
//            .alert(message: value)
//            .action(.cancel("OK"), handler: { _, _, _ in
//                success?()
//            })
//            .show(on: UIApplication.rootController?.visibleVC, completion: nil)
//    }
//}

//public extension UIViewController {
//    var rootVC: UIViewController? {
//        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
//    }
//
//    var visibleVC: UIViewController? {
//        return topMost(of: rootVC)
//    }
//
//    var visibleTabBarController: UITabBarController? {
//        return topMost(of: rootVC)?.tabBarController
//    }
//
//    var visibleNavigationController: UINavigationController? {
//        return topMost(of: rootVC)?.navigationController
//    }
//
//    private func topMost(of viewController: UIViewController?) -> UIViewController? {
//        if let presentedViewController = viewController?.presentedViewController {
//            return topMost(of: presentedViewController)
//        }
//
//        // UITabBarController
//        if let tabBarController = viewController as? UITabBarController,
//            let selectedViewController = tabBarController.selectedViewController {
//            return topMost(of: selectedViewController)
//        }
//
//        // UINavigationController
//        if let navigationController = viewController as? UINavigationController,
//            let visibleViewController = navigationController.visibleViewController {
//            return topMost(of: visibleViewController)
//        }
//
//        return viewController
//    }
//
//    func present(_ controller: UIViewController) {
//        self.modalPresentationStyle = .fullScreen
//
//        present(controller, animated: true, completion: nil)
//    }
//
//    func pushVC(_ controller: UIViewController ,animate: Bool) {
//        if let navigationController = self.navigationController {
//            navigationController.pushViewController(controller, animated: animate)
//        } else {
//            present(controller, animated: animate, completion: nil)
//        }
//    }
//
//    func popVC() {
//        if let navigationController = self.navigationController {
//            navigationController.popViewController(animated: true)
//        } else {
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
//
//    func presentDissolve(_ controller: UIViewController, completion: (() -> Void)? = nil) {
//        controller.modalPresentationStyle = .overFullScreen
//        controller.modalTransitionStyle = .crossDissolve
//        present(controller, animated: true, completion: completion)
//    }
//
//    func presentFullScreen(_ controller: UIViewController, completion: (() -> Void)? = nil) {
//        controller.modalPresentationStyle = .fullScreen
//        controller.modalTransitionStyle = .crossDissolve
//        present(controller, animated: true, completion: completion)
//    }
//}



extension UITextView {
    
    private struct RuntimeKey {
        static let hw_placeholderLabelKey = UnsafeRawPointer.init(bitPattern: "hw_placeholderLabelKey".hashValue)
        /// ...其他Key声明
    }
    /// 占位文字
    @IBInspectable public var placeholder: String {
        get {
            return self.placeholderLabel.text ?? ""
        }
        set {
            self.placeholderLabel.text = newValue
        }
    }
    
    /// 占位文字颜色
    @IBInspectable public var placeholderColor: UIColor {
        get {
            return self.placeholderLabel.textColor
        }
        set {
            self.placeholderLabel.textColor = newValue
        }
    }
    
    private var placeholderLabel: UILabel {
        get {
            var label = objc_getAssociatedObject(self, UITextView.RuntimeKey.hw_placeholderLabelKey!) as? UILabel
            if label == nil { // 不存在是 创建 绑定
                if (self.font == nil) { // 防止没大小时显示异常 系统默认设置14
                    self.font = UIFont.systemFont(ofSize: 14)
                }
                label = UILabel.init(frame: self.bounds)
                label?.numberOfLines = 0
                label?.font = UIFont.systemFont(ofSize: 14)//self.font
                label?.textColor = UIColor.lightGray
                label?.textAlignment = self.textAlignment
                self.addSubview(label!)
                self.setValue(label!, forKey: "_placeholderLabel")
                objc_setAssociatedObject(self, UITextView.RuntimeKey.hw_placeholderLabelKey!, label!, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                self.sendSubviewToBack(label!)
            } else {
                label?.font = self.font
                label?.textColor = label?.textColor.withAlphaComponent(0.6)
            }
            return label!
        }
        set {
            objc_setAssociatedObject(self, UITextView.RuntimeKey.hw_placeholderLabelKey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

@objc
public class HUDClass: NSObject {
    @objc
    public static func show() {
        guard !ZKProgressHUD.isShowing else { return }
        ZKProgressHUD.show()
    }

    @objc
    public static func hide() {
        ZKProgressHUD.dismiss()
    }
}
extension UIDevice {
  
   ///The device model name, e.g. "iPhone 6s", "iPhone SE", etc
   var modelName: String {
       var systemInfo = utsname()
       uname(&systemInfo)
       
       let machineMirror = Mirror(reflecting: systemInfo.machine)
       let identifier = machineMirror.children.reduce("") { identifier, element in
           guard let value = element.value as? Int8, value != 0 else {
               return identifier
           }
           return identifier + String(UnicodeScalar(UInt8(value)))
       }
       
       switch identifier {
       case "iPad1,1":            return "iPad"
       case "iPad2,1":            return "iPad 2"
       case "iPad3,1":            return "iPad (3rd generation)"
       case "iPad3,4":            return "iPad (4th generation)"
       case "iPad6,11":           return "iPad (5th generation)"
       case "iPad7,5":            return "iPad (6th generation)"
       case "iPad7,11":           return "iPad (7th generation)"
       case "iPad11,6":           return "iPad (8th generation)"
       case "iPad12,1":           return "iPad (9th generation)"
       case "iPad4,1":            return "iPad Air"
       case "iPad5,3":            return "iPad Air 2"
       case "iPad11,3":           return "iPad Air (3rd generation)"
       case "iPad13,1":           return "iPad Air (4th generation)"
       case "iPad13,16":          return "iPad Air (5th generation)"
       case "iPad6,7":            return "iPad Pro (12.9-inch)"
       case "iPad6,3":            return "iPad Pro (9.7-inch)"
       case "iPad7,1":            return "iPad Pro (12.9-inch) (2nd generation)"
       case "iPad7,3":            return "iPad Pro (10.5-inch)"
       case "iPad8,1":            return "iPad Pro (11-inch)"
       case "iPad8,5":            return "iPad Pro (12.9-inch) (3rd generation)"
       case "iPad8,9":            return "iPad Pro (11-inch) (2nd generation)"
       case "iPad8,11":           return "iPad Pro (12.9-inch) (4th generation)"
       case "iPad13,4":           return "iPad Pro (11-inch) (3rd generation)"
       case "iPad13,8":           return "iPad Pro (12.9-inch) (5th generation)"
       case "iPad2,5":            return "iPad mini"
       case "iPad4,4":            return "iPad mini 2"
       case "iPad4,7":            return "iPad mini 3"
       case "iPad5,1":            return "iPad mini 4"
       case "iPad11,1":           return "iPad mini (5th generation)"
       case "iPad14,1":           return "iPad mini (6th generation)"
       case "iPhone1,1":          return "iPhone"
       case "iPhone1,2":          return "iPhone 3G"
       case "iPhone2,1":          return "iPhone 3GS"
       case "iPhone3,1":          return "iPhone 4"
       case "iPhone4,1":          return "iPhone 4S"
       case "iPhone5,1":          return "iPhone 5"
       case "iPhone5,3":          return "iPhone 5c"
       case "iPhone6,1":          return "iPhone 5s"
       case "iPhone7,2":          return "iPhone 6"
       case "iPhone7,1":          return "iPhone 6 Plus"
       case "iPhone8,1":          return "iPhone 6s"
       case "iPhone8,2":          return "iPhone 6s Plus"
       case "iPhone8,4":          return "iPhone SE (1st generation)"
       case "iPhone9,1":          return "iPhone 7"
       case "iPhone9,2":          return "iPhone 7 Plus"
       case "iPhone10,1":         return "iPhone 8"
       case "iPhone10,2":         return "iPhone 8 Plus"
       case "iPhone10,3":         return "iPhone X"
       case "iPhone11,8":         return "iPhone XR"
       case "iPhone11,2":         return "iPhone XS"
       case "iPhone11,6":         return "iPhone XS Max"
       case "iPhone12,1":         return "iPhone 11"
       case "iPhone12,3":         return "iPhone 11 Pro"
       case "iPhone12,5":         return "iPhone 11 Pro Max"
       case "iPhone12,8":         return "iPhone SE (2nd generation)"
       case "iPhone13,1":         return "iPhone 12 mini"
       case "iPhone13,2":         return "iPhone 12"
       case "iPhone13,3":         return "iPhone 12 Pro"
       case "iPhone13,4":         return "iPhone 12 Pro Max"
       case "iPhone14,4":         return "iPhone 13 mini"
       case "iPhone14,5":         return "iPhone 13"
       case "iPhone14,2":         return "iPhone 13 Pro"
       case "iPhone14,3":         return "iPhone 13 Pro Max"
       case "iPhone14,6":         return "iPhone SE (3rd generation)"
       case "iPhone14,7":         return "iPhone 14"
       case "iPhone14,8":         return "iPhone 14 Plus"
       case "iPhone15,2":         return "iPhone 14 Pro"
       case "iPhone15,3":         return "iPhone 14 Pro Max"
       case "iPod1,1":            return "iPod touch"
       case "iPod2,1":            return "iPod touch (2nd generation)"
       case "iPod3,1":            return "iPod touch (3rd generation)"
       case "iPod4,1":            return "iPod touch (4th generation)"
       case "iPod5,1":            return "iPod touch (5th generation)"
       case "iPod7,1":            return "iPod touch (6th generation)"
       case "iPod9,1":            return "iPod touch (7th generation)"

       case "i386", "x86_64":     return "Simulator"
       default:                   return identifier
       }
   }
}




public extension String {
    
    var toDictionary: [String:AnyObject]? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.init(rawValue: 0)]) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    var toArray: [[String: AnyObject]]? {
        if let jsonData:Data = self.data(using: String.Encoding.utf8) {
            do {
                 let array = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [[String: AnyObject]]
                return array
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
     
}

public extension Dictionary {
    var toDictionary: String {
        var result:String = ""
        do {
            //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                result = JSONString
            }
            
        } catch {
            result = ""
        }
        return result
    }
     
    
}

public extension Array {
    
    var toString: String {
        var result:String = ""
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                result = JSONString
            }
            
        } catch {
            result = ""
        }
        return result
    }
     
}
 


public extension UIView {
    @discardableResult
    func crop() -> Self {
        contentMode()
        clipsToBounds()
        return self
    }

    @discardableResult
    func alpha(_ value: CGFloat) -> Self {
        alpha = value
        return self
    }

    @discardableResult
    func hidden(_ value: Bool = true) -> Self {
        isHidden = value
        return self
    }
    
    @discardableResult
    func show(_ value: Bool = true) -> Self {
        isHidden = !value
        return self
    }

    @discardableResult
    func cornerRadius(_ value: CGFloat, masksToBounds: Bool = true) -> Self {
        layer.cornerRadius = value
        layer.masksToBounds = masksToBounds
        return self
    }

    @discardableResult
    func borderColor(_ value: UIColor, width: CGFloat = UIScreen.minLineWidth) -> Self {
        layer.borderColor = value.cgColor
        layer.borderWidth = width
        return self
    }

    @discardableResult
    func contentMode(_ value: UIView.ContentMode = .scaleAspectFill) -> Self {
        contentMode = value
        return self
    }

    @discardableResult
    func clipsToBounds(_ value: Bool = true) -> Self {
        clipsToBounds = value
        return self
    }

    @discardableResult
    func tag(_ value: Int) -> Self {
        tag = value
        return self
    }

    @discardableResult
    func tintColor(_ value: UIColor) -> Self {
        tintColor = value
        return self
    }

    @discardableResult
    func backgroundColor(_ value: UIColor) -> Self {
        backgroundColor = value
        return self
    }

    @discardableResult
    func isUserInteractionEnabled(_ value: Bool = true) -> Self {
        isUserInteractionEnabled = value
        return self
    }
}

public extension UIFont {
    enum FontNames: String {
        case AvenirNextCondensedDemiBold = "AvenirNextCondensed-DemiBold"
        case AvenirNextDemiBold = "AvenirNext-DemiBold "
        case AvenirNextBold = "AvenirNext-Bold"
        case AvenirHeavy = "Avenir-Heavy"
        case AvenirMedium = "Avenir-Medium"
        case GillSans
        case GillSansSemiBold = "GillSans-SemiBold"
        case GillSansSemiBoldItalic = "GillSans-SemiBoldItalic"
        case GillSansBold = "GillSans-Bold"
        case GillSansBoldItalic = "GillSans-BoldItalic"
        case MontserratMedium = "Montserrat-Medium"
        case MontserratSemiBold = "Montserrat-SemiBold"
        case MontserratBold = "Montserrat-Bold"
        case MontserratRegular = "Montserrat-Regular"
    }

    static func custom(_ value: CGFloat, name: FontNames) -> UIFont {
        return UIFont(name: name.rawValue, size: value) ?? UIFont.systemFont(ofSize: value)
    }
}

public extension UILabel {
    @discardableResult
    func text(_ value: String?) -> Self {
        text = value
        return self
    }

    @discardableResult
    func color(_ value: UIColor) -> Self {
        textColor = value
        return self
    }

    @discardableResult
    func font(_ value: CGFloat, _ bold: Bool = false) -> Self {
        font = bold ? UIFont.boldSystemFont(ofSize: value) : UIFont.systemFont(ofSize: value)
        return self
    }

    @discardableResult
    func font(_ value: CGFloat, _ name: UIFont.FontNames) -> Self {
        font = UIFont(name: name.rawValue, size: value)
        return self
    }
    
    @discardableResult
    func fontName(_ value: CGFloat, _ name: String) -> Self {
        font = UIFont(name: name, size: value)
        return self
    }
    
    @discardableResult
    func numberOfLines(_ value: Int = 0) -> Self {
        numberOfLines = value
        return self
    }

    @discardableResult
    func adjustsFontSizeToFitWidth(_ value: Bool = true) -> Self {
        adjustsFontSizeToFitWidth = value
        return self
    }
    
    
    @discardableResult
    func textAlignment(_ value: NSTextAlignment) -> Self {
        textAlignment = value
        return self
    }

    @discardableResult
    func lineBreakMode(_ value: NSLineBreakMode = .byTruncatingTail) -> Self {
        lineBreakMode = value
        return self
    }
}

public extension UIButton {
    @discardableResult
    func title(_ value: String?, _ state: UIControl.State = .normal) -> Self {
        setTitle(value, for: state)
        return self
    }

    @discardableResult
    func titleColor(_ value: UIColor, _ state: UIControl.State = .normal) -> Self {
        setTitleColor(value, for: state)
        return self
    }

    @discardableResult
    func image(_ value: UIImage?, _ state: UIControl.State = .normal) -> Self {
        setImage(value, for: state)
        return self
    }

    @discardableResult
    func backgroundImage(_ value: UIImage?, _ state: UIControl.State = .normal) -> Self {
        setBackgroundImage(value, for: state)
        return self
    }

    @discardableResult
    func backgroundColor(_ value: UIColor, _ state: UIControl.State = .normal) -> Self {
        setBackgroundColor(value, for: state)
        return self
    }

    @discardableResult
    func font(_ value: CGFloat, _ bold: Bool = false) -> Self {
        titleLabel?.font(value, bold)
        return self
    }
    @discardableResult
    func font(_ value: CGFloat, _ name: String) -> Self {
        titleLabel?.fontName(value, name)
        return self
    }
    @discardableResult
    func font(_ value: CGFloat, _ name: UIFont.FontNames) -> Self {
        titleLabel?.font(value, name)
        return self
    }

    @discardableResult
    func lineBreakMode(_ value: NSLineBreakMode = .byTruncatingTail) -> Self {
        titleLabel?.lineBreakMode(value)
        return self
    }

    @discardableResult
    func isEnabled(_ value: Bool = false) -> Self {
        isEnabled = value
        return self
    }

    @discardableResult
    func showsTouch(_ value: Bool = true) -> Self {
        showsTouchWhenHighlighted = value
        return self
    }
}

public extension UIImageView {
    @discardableResult
    func image(_ value: String?, _: Bool = false) -> Self {
        guard let value = value else { return self }
        image = UIImage(named: value) ?? UIImage.named(value)
        return self
    }
    
    func image(_ valueImg: UIImage?) -> Self {
        guard let valueImg = valueImg else { return self }
        image = valueImg
        return self
    }
    
    
}
 


 

public extension UIImage {
    static func named(_ value: String?) -> UIImage? {
        guard let value = value else { return nil }
        return UIImage(named: value) ?? UIImage(namedInBundle: value)
    }

    convenience init?(namedInBundle name: String) {
        let path = Bundle.main.path(forResource: "BachCore", ofType: "bundle") ?? ""
        self.init(named: name, in: Bundle(path: path), compatibleWith: nil)
    }
    
    func original() -> UIImage {
        return self.original
    }
    
}

public extension UIView {
    var safeArea: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return safeAreaInsets
        } else {
            return .zero
        }
    }

    @discardableResult
    func gradientBackground(_ colorOne: UIColor, _ colorTwo: UIColor,
                            startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0),
                            endPoint: CGPoint = CGPoint(x: 0.0, y: 1.0)) -> CAGradientLayer {
        
        let gradient = layer.sublayers?.filter { $0 is CAGradientLayer }.first as? CAGradientLayer
        
        if let gradient = gradient {
            gradient.frame = bounds
            return gradient
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        layer.insertSublayer(gradientLayer, at: 0)
//        layer.addSublayer(gradientLayer)
        return gradientLayer
    }
}

public extension UIScreen {
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }

    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
}



public extension UIImage {
    static func with(
        color: UIColor,
        size: CGSize = CGSize(sideLength: 1),
        opaque: Bool = false,
        scale: CGFloat = 0
    ) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)

        UIGraphicsBeginImageContextWithOptions(rect.size, opaque, scale)
        defer { UIGraphicsEndImageContext() }

        guard let context = UIGraphicsGetCurrentContext() else { return nil }

        context.setFillColor(color.cgColor)
        context.fill(rect)

        return UIGraphicsGetImageFromCurrentImageContext()
    }

    func tinted(with color: UIColor, opaque: Bool = false) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, opaque, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }

        guard
            let context = UIGraphicsGetCurrentContext(),
            let cgImage = self.cgImage
        else { return nil }

        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1, y: -1)

        let rect = CGRect(origin: .zero, size: size)

        context.setBlendMode(.normal)
        context.draw(cgImage, in: rect)

        context.setBlendMode(.sourceIn)
        context.setFillColor(color.cgColor)
        context.fill(rect)

        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

public extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        setBackgroundImage(UIImage.with(color: color), for: state)
    }
}

public extension CGSize {
    init(sideLength: Int) {
        self.init(width: sideLength, height: sideLength)
    }

    init(sideLength: Double) {
        self.init(width: sideLength, height: sideLength)
    }

    init(sideLength: CGFloat) {
        self.init(width: sideLength, height: sideLength)
    }

    var longSide: CGFloat {
        return max(width, height)
    }

    var shortSide: CGFloat {
        return min(width, height)
    }
}

public typealias ButtonActionBlock = (UIButton) -> Void

var ActionBlockKey: UInt8 = 02

private class ActionBlockWrapper: NSObject {
    let block: ButtonActionBlock

    init(block: @escaping ButtonActionBlock) {
        self.block = block
    }
}



public extension UIDevice {
    static var isPad: Bool {
        return current.userInterfaceIdiom == .pad
    }

    static var isPhone: Bool {
        return current.userInterfaceIdiom == .phone
    }
}
 

public protocol ViewChainable {}

public extension ViewChainable where Self: AnyObject {
    @discardableResult
    func config(_ config: (Self) -> Void) -> Self {
        config(self)
        return self
    }

    @discardableResult
    func set<T>(_ keyPath: ReferenceWritableKeyPath<Self, T>, to value: T) -> Self {
        self[keyPath: keyPath] = value
        return self
    }
}


extension UIView: ViewChainable {
    @discardableResult
    public func config(cornerRadius: CGFloat, masksToBounds: Bool = true) -> Self {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = masksToBounds

        return self
    }

    @discardableResult
    public func configBorder(color: UIColor, width: CGFloat? = nil) -> Self {
        layer.borderColor = color.cgColor
        if let borderWidth = width {
            layer.borderWidth = borderWidth
        }

        return self
    }

    @discardableResult
    public func configShadow(
        color: UIColor?,
        radius: CGFloat? = nil,
        opacity: Float? = nil,
        offset: CGSize? = nil,
        path: CGPath? = nil
    ) -> Self {
        layer.shadowColor = color?.cgColor

        if let radius = radius {
            layer.shadowRadius = radius
        }

        if let opacity = opacity {
            layer.shadowOpacity = opacity
        }

        if let offset = offset {
            layer.shadowOffset = offset
        }

        if let path = path {
            layer.shadowPath = path
        }

        return self
    }

    @discardableResult
    public func adhere(toSuperview superview: UIView) -> Self {
        superview.addSubview(self)
        return self
    }

    @discardableResult
    public func adhere(toSuperview superview: UIView, below siblingView: UIView) -> Self {
        superview.insertSubview(self, belowSubview: siblingView)
        return self
    }

    @discardableResult
    public func adhere(toSuperview superview: UIView, above siblingView: UIView) -> Self {
        superview.insertSubview(self, aboveSubview: siblingView)
        return self
    }

    @discardableResult
    public func layout(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }

    @discardableResult
    public func layout(x: CGFloat? = nil, y: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil) -> Self {
        var newFrame = frame

        if let x = x {
            newFrame.origin.x = x
        }
        if let y = y {
            newFrame.origin.y = y
        }
        if let width = width {
            newFrame.size.width = width
        }
        if let height = height {
            newFrame.size.height = height
        }

        return layout(newFrame)
    }
}


extension UIColor {

    var hexString: String? {
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
             
            let multiplier = CGFloat(255.999999)
             
            guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
                return nil
            }
             
            if alpha == 1.0 {
                return String(
                    format: "#%02lX%02lX%02lX",
                    Int(red * multiplier),
                    Int(green * multiplier),
                    Int(blue * multiplier)
                )
            }
            else {
                return String(
                    format: "#%02lX%02lX%02lX%02lX",
                    Int(red * multiplier),
                    Int(green * multiplier),
                    Int(blue * multiplier),
                    Int(alpha * multiplier)
                )
            }
        }
}

extension UIImage {
    
    class func createImage(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
        //            self.init(cgImage: (image?.cgImage)!)
    }

    
    func scaleImage(scaleSize: CGFloat) -> UIImage  {
        let reSize = CGSize(width: self.size.width * scaleSize,  height: self.size.height * scaleSize)
        return  reSizeImage(reSize: reSize)
    }
    
    func reSizeImage(reSize: CGSize) -> UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize, false,UIScreen.main.scale);
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage();
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    func myImageWithTintColor(color: UIColor, rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: rect.size.width, height: rect.size.height), false, 0.0)
        color.setFill()
        UIRectFill(rect)
        
        self.draw(in: rect, blendMode: .screen, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return tintedImage
    }
    
    /**
     * 改变UIimage 的 imageOrientation 为 .up
     */
    func fixOrientation() -> UIImage {
        if self.imageOrientation == .up {
            return self
        }
        
        var transform = CGAffineTransform.identity
        
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: .pi)
            break
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
            break
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: -.pi / 2)
            break
            
        default:
            break
        }
        
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
            
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1)
            break
            
        default:
            break
        }
        
        let ctx = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: self.cgImage!.bitmapInfo.rawValue)
        ctx?.concatenate(transform)
        
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.height), height: CGFloat(size.width)))
            break
            
        default:
            ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.width), height: CGFloat(size.height)))
            break
        }
        
        let cgimg: CGImage = (ctx?.makeImage())!
        let img = UIImage(cgImage: cgimg)
        
        return img
    }
    
    func originImageToScaleSize(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage ?? UIImage()
    }
}


public extension UIViewController {
    var rootVC: UIViewController? {
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
    }

    var visibleVC: UIViewController? {
        return topMost(of: rootVC)
    }

    var visibleTabBarController: UITabBarController? {
        return topMost(of: rootVC)?.tabBarController
    }

    var visibleNavigationController: UINavigationController? {
        return topMost(of: rootVC)?.navigationController
    }

    private func topMost(of viewController: UIViewController?) -> UIViewController? {
        if let presentedViewController = viewController?.presentedViewController {
            return topMost(of: presentedViewController)
        }

        // UITabBarController
        if let tabBarController = viewController as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController {
            return topMost(of: selectedViewController)
        }

        // UINavigationController
        if let navigationController = viewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return topMost(of: visibleViewController)
        }

        return viewController
    }

    func present(_ controller: UIViewController) {
        self.modalPresentationStyle = .fullScreen
        
        present(controller, animated: true, completion: nil)
    }
    
    func pushVC(_ controller: UIViewController ,animate: Bool) {
        if let navigationController = self.navigationController {
            navigationController.pushViewController(controller, animated: animate)
        } else {
            present(controller, animated: animate, completion: nil)
        }
    }
    
    func popVC() {
        if let navigationController = self.navigationController {
            navigationController.popViewController()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func presentDissolve(_ controller: UIViewController, completion: (() -> Void)? = nil) {
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: completion)
    }
    
    func presentFullScreen(_ controller: UIViewController, completion: (() -> Void)? = nil) {
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: completion)
    }
}



extension Timer {
    // MARK: Schedule timers

    /// Create and schedule a timer that will call `block` once after the specified time.

    @discardableResult
    class func after(_ interval: TimeInterval, _ block: @escaping () -> Void) -> Timer {
        let timer = Timer.new(after: interval, block)
        timer.start()
        return timer
    }

    /// Create and schedule a timer that will call `block` repeatedly in specified time intervals.

    @discardableResult
    class func every(_ interval: TimeInterval, _ block: @escaping () -> Void) -> Timer {
        let timer = Timer.new(every: interval, block)
        timer.start()
        return timer
    }

    /// Create and schedule a timer that will call `block` repeatedly in specified time intervals.
    /// (This variant also passes the timer instance to the block)

    @nonobjc @discardableResult
    class func every(_ interval: TimeInterval, _ block: @escaping (Timer) -> Void) -> Timer {
        let timer = Timer.new(every: interval, block)
        timer.start()
        return timer
    }

    // MARK: Create timers without scheduling

    /// Create a timer that will call `block` once after the specified time.
    ///
    /// - Note: The timer won't fire until it's scheduled on the run loop.
    ///         Use `NSTimer.after` to create and schedule a timer in one step.
    /// - Note: The `new` class function is a workaround for a crashing bug when using convenience initializers (rdar://18720947)

    class func new(after interval: TimeInterval, _ block: @escaping () -> Void) -> Timer {
        return CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent() + interval, 0, 0, 0) { _ in
            block()
        }
    }

    /// Create a timer that will call `block` repeatedly in specified time intervals.
    ///
    /// - Note: The timer won't fire until it's scheduled on the run loop.
    ///         Use `NSTimer.every` to create and schedule a timer in one step.
    /// - Note: The `new` class function is a workaround for a crashing bug when using convenience initializers (rdar://18720947)

    class func new(every interval: TimeInterval, _ block: @escaping () -> Void) -> Timer {
        return CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent() + interval, interval, 0, 0) { _ in
            block()
        }
    }

    /// Create a timer that will call `block` repeatedly in specified time intervals.
    /// (This variant also passes the timer instance to the block)
    ///
    /// - Note: The timer won't fire until it's scheduled on the run loop.
    ///         Use `NSTimer.every` to create and schedule a timer in one step.
    /// - Note: The `new` class function is a workaround for a crashing bug when using convenience initializers (rdar://18720947)

    @nonobjc class func new(every interval: TimeInterval, _ block: @escaping (Timer) -> Void) -> Timer {
        var timer: Timer!
        timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent() + interval, interval, 0, 0) { _ in
            block(timer)
        }
        return timer
    }

    // MARK: Manual scheduling

    /// Schedule this timer on the run loop
    ///
    /// By default, the timer is scheduled on the current run loop for the default mode.
    /// Specify `runLoop` or `modes` to override these defaults.

    func start(runLoop: RunLoop = .current, modes: RunLoop.Mode...) {
        let modes = modes.isEmpty ? [.default] : modes

        for mode in modes {
            runLoop.add(self, forMode: mode)
        }
    }
}

// MARK: - Time extensions

extension Double {
    var millisecond: TimeInterval { return self / 1000 }
    var milliseconds: TimeInterval { return self / 1000 }
    var ms: TimeInterval { return self / 1000 }

    var second: TimeInterval { return self }
    var seconds: TimeInterval { return self }

    var minute: TimeInterval { return self * 60 }
    var minutes: TimeInterval { return self * 60 }

    var hour: TimeInterval { return self * 3600 }
    var hours: TimeInterval { return self * 3600 }

    var day: TimeInterval { return self * 3600 * 24 }
    var days: TimeInterval { return self * 3600 * 24 }
}


public extension UIApplication {
    static var topSafeAreaHeight: CGFloat {
        var topSafeAreaHeight: CGFloat = 0
         if #available(iOS 11.0, *) {
               let window = UIApplication.shared.windows[0]
               let safeFrame = window.safeAreaLayoutGuide.layoutFrame
               topSafeAreaHeight = safeFrame.minY
             }
        return topSafeAreaHeight
    }
    
    static var bottomSafeAreaHeight: CGFloat {
           var bottomSafeAreaHeight: CGFloat = 0
            if #available(iOS 11.0, *) {
                  let window = UIApplication.shared.windows[0]
                  let safeFrame = window.safeAreaLayoutGuide.layoutFrame
                 bottomSafeAreaHeight = UIScreen.height - safeFrame.height - UIApplication.topSafeAreaHeight
                }
           return bottomSafeAreaHeight
       }
}

public extension Int {
    func k() -> String {
        if self >= 1000 {
            var sign: String {
                return self >= 0 ? "" : "-"
            }
            let abs = Swift.abs(self)
            if abs >= 1000, abs < 1_000_000 {
                return String(format: "\(sign)%.2fK", abs.double / 1000.0)
            }
            return String(format: "\(sign)%.2fM", abs.double / 1_000_000.0)
        }
        return string
    }
}


public extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }

    class var className: String {
        return String(describing: self)
    }
}

public extension Bundle {
    var icon: UIImage {
        guard
            let infoDictionary = infoDictionary,
            let iconsDictionary = infoDictionary["CFBundleIcons"] as? [String: Any],
            let primaryIconsDictionary = iconsDictionary["CFBundlePrimaryIcon"] as? [String: Any],
            let iconFiles = primaryIconsDictionary["CFBundleIconFiles"] as? [Any],
            let lastIconName = iconFiles.last as? String,
            let lastIcon = UIImage(named: lastIconName)
        else {
            assertionFailure("没有设置 AppIcon.")
            return UIImage()
        }

        return lastIcon
    }

    var shortVersion: String {
        guard
            let infoDictionary = infoDictionary,
            let version = infoDictionary["CFBundleShortVersionString"] as? String
        else {
            assertionFailure("get app version failure.")
            return ""
        }
        return version
    }

    var buildNumber: String {
        guard
            let infoDictionary = infoDictionary,
            let buildNumber = infoDictionary["CFBundleVersion"] as? String
        else {
            assertionFailure("get buildNumber failure.")
            return ""
        }
        return buildNumber
    }
}

public protocol Then {}
extension Then {
    @discardableResult
    public func then(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Then {}



protocol UIViewLoading {}

/// Extend UIView to declare that it includes nib loading functionality
extension UIView: UIViewLoading {}

/// Protocol implementation
extension UIViewLoading where Self: UIView {
    static func loadFromNib(nibNameOrNil: String? = nil) -> Self {
        let nibName = nibNameOrNil ?? className
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! Self
    }
}

extension UIApplication {
    public static var rootController: UIViewController? {
        if #available(iOS 13.0, *) {
            return shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        } else {
            return shared.keyWindow?.rootViewController
        }
        
    }
}


public extension UIView {
    func setAnchorPoint(anchorPoint: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * anchorPoint.x, y: bounds.size.height * anchorPoint.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position: CGPoint = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = anchorPoint
    }
}



public extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}

public extension UIImage {
    func toCIImage() -> CIImage? {
        return ciImage ?? CIImage(cgImage: cgImage!)
    }

    func scaled(length: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: length, height: length), false, 0)
        draw(in: CGRect(x: 0, y: 0, width: length, height: length))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    var averageColor: UIColor? {
        guard let inputImage = self.ciImage ?? CIImage(image: self) else { return nil }
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: CIVector(cgRect: inputImage.extent)])
        else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [CIContextOption.workingColorSpace: kCFNull])
        let outputImageRect = CGRect(x: 0, y: 0, width: 1, height: 1)

        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: outputImageRect, format: CIFormat.RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}

public extension CIImage {
    func toUIImage() -> UIImage {
        /* If need to reduce the process time, than use next code. But ot produce a bug with wrong filling in the simulator.
         return UIImage(ciImage: self)
         */
        let context: CIContext = CIContext(options: nil)
        let cgImage: CGImage = context.createCGImage(self, from: extent)!
        let image: UIImage = UIImage(cgImage: cgImage)
        return image
    }

    func toCGImage() -> CGImage? {
        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(self, from: self.extent) {
            return cgImage
        }
        return nil
    }
}


public extension UIScreen {
    static var isWidthLessThen4_7inch: Bool {
        return UIScreen.main.bounds.width < 375
    }

    static var isHeightLessThen4_7inch: Bool {
        return UIScreen.main.bounds.height < 667
    }

    static var isLessThen4_7inch: Bool {
        return isWidthLessThen4_7inch || isHeightLessThen4_7inch
    }

    static var minLineWidth: CGFloat {
        return 1 / UIScreen.main.scale
    }
}

 
 

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func newSubstring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func newSubstring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func newSubstring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    func tojson() -> [String: Any]? {
        let data = Data(self.utf8)
        
        do {
            // make sure this JSON is in the format we expect
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                return json
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        return nil
    }

}

// Defines types of hash string outputs available
public enum HashOutputType {
    // standard hex string output
    case hex
    // base 64 encoded string output
    case base64
}


public struct Alert {
    public static func error(_ value: String?, title: String? = "Error", success: (() -> Void)? = nil) {
        if UIApplication.rootController?.visibleVC is UIAlertController {
            return
        }
        HUD.hide()
        Alertift
            .alert(title: title, message: value)
            .action(.cancel("OK"), handler: { _, _, _ in
                success?()
                
            })
            .show(on: UIApplication.rootController?.visibleVC, completion: nil)
    }

    public static func message(_ value: String?, success: (() -> Void)? = nil) {
        if UIApplication.rootController?.visibleVC is UIAlertController {
            return
        }
        HUD.hide()
        Alertift
            .alert(message: value)
            .action(.cancel("OK"), handler: { _, _, _ in
                success?()
                
            })
            .show(on: UIApplication.rootController?.visibleVC, completion: nil)
    }
}










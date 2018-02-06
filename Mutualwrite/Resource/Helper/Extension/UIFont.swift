//
//  UIFont.swift
//  TestSlim
//
//  Created by sasawat sankosik on 11/4/17.
//  Copyright © 2017 ssankosik. All rights reserved.
//

import UIKit
//struct Roboto {
//  static let regular = "Roboto-Regular"
//  static let bold = "Roboto-Bold-Bold"
//  static let italic = "Roboto-Italic"
//  static let boldItalic = "Roboto-BoldItalic"
//  static let lightItalic = "Roboto-LightItalic"
//  static let light = "SCAssetTH-Light"
//}
//
//extension UIFontDescriptor.AttributeName {
//  static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
//}
//
//extension UIFont {
//
//  class func mySystemFont(ofSize size: CGFloat) -> UIFont {
//    return UIFont(name: Roboto.regular, size: size)!
//  }
//
//  class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
//    return UIFont(name: Roboto.bold, size: size)!
//  }
//
//  class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
//    return UIFont(name: Roboto.italic, size: size)!
//  }
//
//  class func boldItalicSystemFont(ofSize size: CGFloat) -> UIFont {
//    return UIFont(name: Roboto.boldItalic, size: size)!
//  }
//
//  class func lightItalicSystemFont(ofSize size: CGFloat) -> UIFont {
//    return UIFont(name: Roboto.lightItalic, size: size)!
//  }
//
//  class func lightSystemFont(ofSize size: CGFloat) -> UIFont {
//    return UIFont(name: Roboto.light, size: size)!
//  }
//
//  convenience init(myCoder aDecoder: NSCoder) {
//    if let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor {
//      if let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String {
//        var fontName = ""
//        switch fontAttribute {
//        case "CTFontRegularUsage":
//          fontName = Roboto.regular
//        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
//          fontName = Roboto.bold
//        case "CTFontObliqueUsage":
//          fontName = Roboto.italic
//        default:
//          fontName = Roboto.regular
//        }
//        self.init(name: fontName, size: fontDescriptor.pointSize)!
//      }
//      else {
//        self.init(myCoder: aDecoder)
//      }
//    }
//    else {
//      self.init(myCoder: aDecoder)
//    }
//  }
//
//  class func overrideInitialize() {
//    if self == UIFont.self {
//      let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:)))
//      let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:)))
//      method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
//
//      let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:)))
//      let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:)))
//      method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
//
//      let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:)))
//      let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:)))
//      method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
//
//      let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))) // Trick to get over the lack of UIFont.init(coder:))
//      let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:)))
//      method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
//    }
//  }
//}
//

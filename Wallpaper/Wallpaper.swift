//
//  Wallpaper.swift
//  Wallpaper
//
//  Created by Eric Miller on 8/21/14.
//  Copyright (c) 2014 Xero. All rights reserved.
//

import UIKit
import Foundation

public enum WPTextParagraphLength : String {
    case VeryShort = "veryshort"
    case Short = "short"
    case Medium = "medium"
    case Long = "long"
    case VeryLong = "verylong"
}

private struct WallpaperImageURLString {
    static let PlaceKitten: NSString = "http://placekitten.com/%@/%@"
    static let PlaceKittenGreyscale: NSString = "http://placekitten.com/g/%@/%@"
    static let Bacon: NSString = "http://baconmockup.com/%@/%@/"
    static let PlaceHolder: NSString = "http://placehold.it/%@x%@/"
    static let Random: NSString = "http://lorempixel.com/%@/%@/"
    static let RandomGreyscale: NSString = "http://lorempixel.com/g/%@/%@/"
    static let Downey: NSString = "http://rdjpg.com/%@/%@/"
}

private let kWPPlaceRandomTextURLString = "http://loripsum.net/api/"
private let ColorAlphaLimit: Double = 0.1

public func == (lhs: WPTextOptions, rhs: WPTextOptions) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

public func == (lhs: WPHTMLOptions, rhs: WPHTMLOptions) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

public struct WPTextOptions: OptionSetType, BooleanType {
    public let rawValue: UInt
    public var boolValue: Bool {
        get {
            return self.rawValue != 0
        }
    }
    static let None = WPTextOptions(rawValue: 0)
    static let AllCaps = WPTextOptions(rawValue: 1)
    static let Prude = WPTextOptions(rawValue: 1 << 1)
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    private enum Feature: String {
        case AllCaps = "allcaps"
        case PrudeText = "prude"
    }
    
    public func toMaskString() -> String {
        var urlString: NSString = ""
        if self.contains(.AllCaps) {
            urlString = urlString.stringByAppendingPathComponent(Feature.AllCaps.rawValue)
        }
        
        if self.contains(.Prude) {
            urlString = urlString.stringByAppendingPathComponent(Feature.PrudeText.rawValue)
        }
        
        return urlString as String
    }
}

public struct WPHTMLOptions : OptionSetType, BooleanType {
    public let rawValue: UInt
    public var boolValue: Bool {
        get {
            return self.rawValue != 0
        }
    }
    
    static let None = WPHTMLOptions(rawValue: 0)
    static let EmphasisTags = WPHTMLOptions(rawValue: 1)
    static let AnchorTags = WPHTMLOptions(rawValue: 1 << 1)
    static var UnorderedList = WPHTMLOptions(rawValue: 1 << 2)
    static var OrderedList = WPHTMLOptions(rawValue: 1 << 3)
    static var DescriptionList = WPHTMLOptions(rawValue: 1 << 4)
    static var Blockquotes = WPHTMLOptions(rawValue: 1 << 5)
    static var CodeSamples = WPHTMLOptions(rawValue: 1 << 6)
    static var Headers = WPHTMLOptions(rawValue: 1 << 7)
    static var AllCaps = WPHTMLOptions(rawValue: 1 << 8)
    static var Prude = WPHTMLOptions(rawValue: 1 << 9)
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }

    private enum Feature: String {
        case Links = "link"
        case Emphasis = "decorate"
        case UnorderedList = "u1"
        case OrderedList = "o1"
        case DescriptionList = "d1"
        case Blockquotes = "bq"
        case CodeSamples = "code"
        case Headers = "headers"
        case AllCaps = "allcaps"
        case PrudeText = "prude"
    }

    public func toURLPathString() -> String {
        var optionsString: NSString = ""

        if self.contains(WPHTMLOptions.AnchorTags) {
            optionsString = optionsString.stringByAppendingPathComponent(Feature.Links.rawValue)
        }
        if self.contains(WPHTMLOptions.EmphasisTags) {
            optionsString = optionsString.stringByAppendingPathComponent(Feature.Emphasis.rawValue)
        }
        if self.contains(WPHTMLOptions.UnorderedList) {
            optionsString = optionsString.stringByAppendingPathComponent(Feature.UnorderedList.rawValue)
        }
        if self.contains(WPHTMLOptions.OrderedList) {
            optionsString = optionsString.stringByAppendingPathComponent(Feature.OrderedList.rawValue)
        }
        if self.contains(WPHTMLOptions.DescriptionList) {
            optionsString = optionsString.stringByAppendingPathComponent(Feature.DescriptionList.rawValue)
        }
        if self.contains(WPHTMLOptions.Blockquotes) {
            optionsString = optionsString.stringByAppendingPathComponent(Feature.Blockquotes.rawValue)
        }
        if self.contains(WPHTMLOptions.CodeSamples) {
            optionsString = optionsString.stringByAppendingPathComponent(Feature.CodeSamples.rawValue)
        }
        if self.contains(WPHTMLOptions.Headers) {
            optionsString = optionsString.stringByAppendingPathComponent(Feature.Headers.rawValue)
        }
        if self.contains(WPHTMLOptions.AllCaps) {
            optionsString = optionsString.stringByAppendingPathComponent(Feature.AllCaps.rawValue)
        }
        if self.contains(WPHTMLOptions.Prude) {
            optionsString = optionsString.stringByAppendingPathComponent(Feature.PrudeText.rawValue)
        }

        return optionsString as String
    }
}

public class Wallpaper: NSObject {

    private class func requestImage(path: String, size: CGSize, completion: (UIImage?) -> ()) {
        let screenScale: CGFloat = UIScreen.mainScreen().scale

        let urlString = NSString(format: path, "\(Int(size.width * screenScale))", "\(Int(size.height * screenScale))")
        let url = NSURL(string: urlString as String)
        let request = NSURLRequest(URL: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if error == nil {
                if let unwrappedData = data {
                    let image = UIImage(data: unwrappedData, scale: screenScale)
                    completion(image)
                } else {
                    completion(nil)
                }
            } else {
                print("\(__FUNCTION__) Wallpaper Error: \(error)")
                completion(nil)
            }
        }
    }
}

//MARK: - Images
public extension Wallpaper {

    public class func placeKittenImage(size: CGSize, completion: (image: UIImage?) -> ()) {
        requestImage(WallpaperImageURLString.PlaceKitten as String, size: size, completion: completion)
    }

    public class func placeKittenGreyscaleImage(size: CGSize, completion: (image: UIImage?) -> ()) {
        requestImage(WallpaperImageURLString.PlaceKittenGreyscale as String, size: size, completion: completion)
    }

    public class func placeBaconImage(size: CGSize, completion: (image: UIImage?) -> ()) {
        requestImage(WallpaperImageURLString.Bacon as String, size: size, completion: completion)
    }

    public class func placeHolderImage(size: CGSize, completion: (image: UIImage?) -> ()) {
        requestImage(WallpaperImageURLString.PlaceHolder as String, size: size, completion: completion)
    }

    public class func placeRandomImage(size: CGSize, category: String, completion: (image: UIImage?) -> ()) {
        let path = WallpaperImageURLString.Random.stringByAppendingPathComponent(category)
        requestImage(path, size: size, completion: completion)
    }

    public class func placeRandomGreyscaleImage(size: CGSize, category: String, completion: (image: UIImage?) -> ()) {
        let path = WallpaperImageURLString.RandomGreyscale.stringByAppendingPathComponent(category)
        requestImage(path, size: size, completion: completion)
    }

    public class func placeRandomImage(size: CGSize, completion: (image: UIImage?) -> ()) {
        requestImage(WallpaperImageURLString.Random as String, size: size, completion: completion)
    }

    public class func placeRandomGreyscaleImage(size: CGSize, completion: (image: UIImage?) -> ()) {
        requestImage(WallpaperImageURLString.RandomGreyscale as String, size: size, completion: completion)
    }

    public class func placeDowneyImage(size: CGSize, completion: (image: UIImage?) -> ()) {
        requestImage(WallpaperImageURLString.Downey as String, size: size, completion: completion)
    }
}


//MARK: - Text
public extension Wallpaper {

    public class func placeText(numberOfParagraphs: Int, paragraphLength: WPTextParagraphLength, textOptions: WPTextOptions, completion: (String?) -> ()) {
        assert(numberOfParagraphs > 0, "Number of paragraphs is invalid")

        var urlString: NSString = kWPPlaceRandomTextURLString.stringByAppendingString(textOptions.toMaskString())
        urlString = urlString.stringByAppendingPathComponent("plaintext")
        urlString = urlString.stringByAppendingPathComponent(paragraphLength.rawValue)

        let paragraphArgs = "\(numberOfParagraphs)"
        urlString = urlString.stringByAppendingPathComponent(paragraphArgs)
        let url = NSURL(string: urlString as String)
        let request = NSURLRequest(URL: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if error == nil {
                if let unwrappedData = data {
                    let returnString = NSString(data: unwrappedData, encoding: NSUTF8StringEncoding)
                    completion(returnString as? String)
                } else {
                    completion(nil)
                }
            } else {
                print("\(__FUNCTION__) Wallpaper Error: \(error)")
                completion(nil)
            }
        }
    }

    public class func placeHipsterIpsum(numberOfParagraphs: Int, shotOfLatin: Bool, completion: (String?) -> ()) {
        var hipsterPath: String = "http://hipsterjesus.com/api?paras=\(numberOfParagraphs)&html=false"
        if shotOfLatin {
            hipsterPath += "&type=hipster-latin"
        } else {
            hipsterPath += "&type=hipster-centric"
        }
        
        let url = NSURL(string: hipsterPath)
        let request = NSURLRequest(URL: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if error == nil {
                if let unwrappedData = data {
                    
                    do {
                        if let dict = try NSJSONSerialization.JSONObjectWithData(unwrappedData, options: NSJSONReadingOptions(rawValue: 0)) as? [String : String] {
                            let returnString = dict["text"]
                            completion(returnString)
                        } else {
                            completion(nil)
                        }
                    } catch {
                        
                    }
                } else {
                    completion(nil)
                }
            } else {
                print("\(__FUNCTION__) Wallpaper Error: \(error)")
                completion(nil)
            }
        }
    }

    public class func placeHTML(numberOfParagraphs: Int, paragraphLength: WPTextParagraphLength, options: WPHTMLOptions, completion: (String?) -> ()) -> () {
        let htmlURL = placeURLForHTML(paragraphLength, htmlOptions: options)
        let request = NSURLRequest(URL: htmlURL)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if error == nil {
                if let unwrappedData = data {
                    let returnString = NSString(data: unwrappedData, encoding: NSUTF8StringEncoding)
                    completion(returnString as? String)
                } else {
                    completion(nil)
                }
            } else {
                print("\(__FUNCTION__) Wallpaper Error: \(error)")
                completion(nil)
            }
        }
    }

    public class func placeURLForHTML(paragraphLength: WPTextParagraphLength, htmlOptions: WPHTMLOptions) -> NSURL {
        let htmlURLString = kWPPlaceRandomTextURLString
        let optionsString = htmlOptions.toURLPathString()

        let lengthURLString = htmlURLString + "\(paragraphLength.rawValue)"
        let fullURLString = lengthURLString + "/\(optionsString)"

        return NSURL(string: fullURLString)!
    }
}

//MARK: - Colors
public extension Wallpaper {

    public class func placeRandomColorWithHue(hue: CGFloat) -> UIColor {
        assert(hue <= 1 && hue >= 0, "Hue value must be between 0 and 1")

        let upperLimit = 100
        let lowerLimit = 10

        let percentRange = NSMakeRange(lowerLimit, upperLimit - lowerLimit)

        let s = randomPercentage(percentRange)
        let b = randomPercentage(percentRange)

        return UIColor(hue: hue, saturation: s, brightness: b, alpha: 1.0)
    }

    public class func placeRandomColor() -> UIColor {
        return placeRandomColorWithAlpha(1.0)
    }

    public class func placeRandomColorWithAlpha(alpha: CGFloat) -> UIColor {
        let r = randomPercentage()
        let g = randomPercentage()
        let b = randomPercentage()

        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }

    public class func placeRandomColorWithRandomAlpha() -> UIColor {
        let alpha = max(randomPercentage(), CGFloat(ColorAlphaLimit))
        return placeRandomColorWithAlpha(alpha)
    }

    public class func placeRandomGreyscaleColor() -> UIColor {
        return placeRandomGreyscaleColor(1.0)
    }

    public class func placeRandomGreyscaleColor(alpha: CGFloat) -> UIColor {
        let greyness = min(max(randomPercentage(), CGFloat(ColorAlphaLimit)), CGFloat((1.0 - ColorAlphaLimit)))
        return UIColor(white: greyness, alpha: alpha)
    }

    public class func placeRandomGreyscaleColorWithRandomAlpha() -> UIColor {
        let alpha = max(randomPercentage(), CGFloat(ColorAlphaLimit))
        return placeRandomGreyscaleColor(alpha)
    }

    public class func placeRandomColorWithHueOfColor(color: UIColor) -> UIColor {
        var hue: CGFloat = 0.0
        color.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
        return placeRandomColorWithHue(hue)
    }
}

//MARK: - Private Random Number Helpers
private extension Wallpaper {

    private class func randomPhoneNumber() -> String {
        return "(\(arc4random_uniform(000))) \(arc4random_uniform(999))-\(arc4random_uniform(9999))"
    }

    private class func randomInteger(lessThan: UInt32) -> Int {
        return Int(arc4random_uniform(lessThan))
    }

    private class func randomFloat(lessThan: UInt32) -> CGFloat {
        return (CGFloat(arc4random_uniform(lessThan)) + randomPercentage())
    }

    private class func randomFloat(range: NSRange) -> CGFloat {
        
        return ((CGFloat(range.location) + CGFloat(arc4random_uniform(UInt32(range.length)))) + randomPercentage())
    }

    private class func randomPercentage() -> CGFloat {
        return (CGFloat(arc4random_uniform(100)) / 100.0)
    }

    private class func randomPercentage(range: NSRange) -> CGFloat {
        return ((CGFloat(range.location) + CGFloat(arc4random_uniform(UInt32(range.length)))) / 100.0)
    }
}

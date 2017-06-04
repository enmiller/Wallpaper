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

public struct WPTextOptions: OptionSet {
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
        var urlString: String = ""
        if self.contains(.AllCaps) {
            urlString = (urlString as NSString).appendingPathComponent(Feature.AllCaps.rawValue)
        }
        
        if self.contains(.Prude) {
            urlString = (urlString as NSString).appendingPathComponent(Feature.PrudeText.rawValue)
        }
        
        return urlString
    }
}

public struct WPHTMLOptions : OptionSet {
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
        var optionsString: String = ""
        
        if self.contains(WPHTMLOptions.AnchorTags) {
            optionsString = (optionsString as NSString).appendingPathComponent(Feature.Links.rawValue)
        }
        if self.contains(WPHTMLOptions.EmphasisTags) {
            optionsString = (optionsString as NSString).appendingPathComponent(Feature.Emphasis.rawValue)
        }
        if self.contains(WPHTMLOptions.UnorderedList) {
            optionsString = (optionsString as NSString).appendingPathComponent(Feature.UnorderedList.rawValue)
        }
        if self.contains(WPHTMLOptions.OrderedList) {
            optionsString = (optionsString as NSString).appendingPathComponent(Feature.OrderedList.rawValue)
        }
        if self.contains(WPHTMLOptions.DescriptionList) {
            optionsString = (optionsString as NSString).appendingPathComponent(Feature.DescriptionList.rawValue)
        }
        if self.contains(WPHTMLOptions.Blockquotes) {
            optionsString = (optionsString as NSString).appendingPathComponent(Feature.Blockquotes.rawValue)
        }
        if self.contains(WPHTMLOptions.CodeSamples) {
            optionsString = (optionsString as NSString).appendingPathComponent(Feature.CodeSamples.rawValue)
        }
        if self.contains(WPHTMLOptions.Headers) {
            optionsString = (optionsString as NSString).appendingPathComponent(Feature.Headers.rawValue)
        }
        if self.contains(WPHTMLOptions.AllCaps) {
            optionsString = (optionsString as NSString).appendingPathComponent(Feature.AllCaps.rawValue)
        }
        if self.contains(WPHTMLOptions.Prude) {
            optionsString = (optionsString as NSString).appendingPathComponent(Feature.PrudeText.rawValue)
        }
        
        return optionsString
    }
}

public class Wallpaper: NSObject {
    
    fileprivate class func requestImage(at path: String, size: CGSize, completion: @escaping (UIImage?) -> (Void)) {
        let screenScale: CGFloat = UIScreen.main.scale
        
        let urlString = String(format: path, "\(Int(size.width * screenScale))", "\(Int(size.height * screenScale))")
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) -> Void in
            if error == nil {
                if let unwrappedData = data {
                    let image = UIImage(data: unwrappedData, scale: screenScale)
                    completion(image)
                } else {
                    completion(nil)
                }
            } else {
                print(String(format:"%@ %@ %@", #function, "Wallpaper Error:", String(describing: error)))
                completion(nil)
            }
        }
    }
}

//MARK: - Images
public extension Wallpaper {
    
    public class func placeKittenImage(size: CGSize, completion: @escaping (_ image: UIImage?) -> (Void)) {
        requestImage(at: WallpaperImageURLString.PlaceKitten as String, size: size, completion: completion)
    }
    
    public class func placeKittenGreyscaleImage(size: CGSize, completion: @escaping (_ image: UIImage?) -> (Void)) {
        requestImage(at: WallpaperImageURLString.PlaceKittenGreyscale as String, size: size, completion: completion)
    }
    
    public class func placeBaconImage(size: CGSize, completion: @escaping (_ image: UIImage?) -> (Void)) {
        requestImage(at: WallpaperImageURLString.Bacon as String, size: size, completion: completion)
    }
    
    public class func placeHolderImage(size: CGSize, completion: @escaping (_ image: UIImage?) -> (Void)) {
        requestImage(at: WallpaperImageURLString.PlaceHolder as String, size: size, completion: completion)
    }
    
    public class func placeRandomImage(size: CGSize, category: String, completion: @escaping (_ image: UIImage?) -> (Void)) {
        let path = (WallpaperImageURLString.Random as NSString).appendingPathComponent(category)
        requestImage(at: path, size: size, completion: completion)
    }
    
    public class func placeRandomGreyscaleImage(size: CGSize, category: String, completion: @escaping (_ image: UIImage?) -> (Void)) {
        let path = (WallpaperImageURLString.RandomGreyscale as NSString).appendingPathComponent(category)
        requestImage(at: path, size: size, completion: completion)
    }
    
    public class func placeRandomImage(size: CGSize, completion: @escaping (_ image: UIImage?) -> (Void)) {
        requestImage(at: WallpaperImageURLString.Random as String, size: size, completion: completion)
    }
    
    public class func placeRandomGreyscaleImage(size: CGSize, completion: @escaping (_ image: UIImage?) -> (Void)) {
        requestImage(at: WallpaperImageURLString.RandomGreyscale as String, size: size, completion: completion)
    }
    
    public class func placeDowneyImage(size: CGSize, completion: @escaping (_ image: UIImage?) -> (Void)) {
        requestImage(at: WallpaperImageURLString.Downey as String, size: size, completion: completion)
    }
}


//MARK: - Text
public extension Wallpaper {
    
    public class func placeText(numberOfParagraphs: Int, paragraphLength: WPTextParagraphLength, textOptions: WPTextOptions, completion: @escaping (String?) -> (Void)) {
        assert(numberOfParagraphs > 0, "Number of paragraphs is invalid")
        
        var urlString: String = kWPPlaceRandomTextURLString.appending(textOptions.toMaskString())
        urlString = (urlString as NSString).appendingPathComponent("plaintext")
        urlString = (urlString as NSString).appendingPathComponent(paragraphLength.rawValue)
        
        let paragraphArgs = "\(numberOfParagraphs)"
        urlString = (urlString as NSString).appendingPathComponent(paragraphArgs)
        let url = URL(string: urlString as String)
        let request = URLRequest(url: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) -> Void in
            if error == nil {
                if let unwrappedData = data {
                    let returnString = String(data: unwrappedData, encoding: .utf8)
                    completion(returnString)
                } else {
                    completion(nil)
                }
            } else {
                print(String(format:"%@ %@ %@", #function, "Wallpaper Error:", String(describing: error)))
                completion(nil)
            }
        }
    }
    
    public class func placeHipsterIpsum(numberOfParagraphs: Int, shotOfLatin: Bool, completion: @escaping (String?) -> (Void)) {
        var hipsterPath: String = "http://hipsterjesus.com/api?paras=\(numberOfParagraphs)&html=false"
        if shotOfLatin {
            hipsterPath += "&type=hipster-latin"
        } else {
            hipsterPath += "&type=hipster-centric"
        }
        
        let url = URL(string: hipsterPath)
        let request = URLRequest(url: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) -> Void in
            if error == nil {
                if let unwrappedData = data {
                    if let JSONDict = try? JSONSerialization.jsonObject(with: unwrappedData, options: []),
                        let dict = JSONDict as? [String : AnyObject]
                    {
                        let returnString = dict["text"] as? String
                        completion(returnString)
                    } else {
                        completion(nil)
                    }
                }
            } else {
                print(String(format:"%@ %@ %@", #function, "Wallpaper Error:", String(describing: error)))
                completion(nil)
            }
        }
    }
    
    public class func placeHTML(numberOfParagraphs: Int, paragraphLength: WPTextParagraphLength, options: WPHTMLOptions, completion: @escaping (String?) -> (Void)) -> () {
        let htmlURL = placeURLForHTML(paragraphLength: paragraphLength, htmlOptions: options)
        let request = URLRequest(url: htmlURL)
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) -> Void in
            if error == nil {
                if let unwrappedData = data {
                    let returnString = String(data: unwrappedData, encoding: .utf8)
                    completion(returnString)
                } else {
                    completion(nil)
                }
            } else {
                print(String(format:"%@ %@ %@", #function, "Wallpaper Error:", String(describing: error)))
                completion(nil)
            }
        }
    }
    
    public class func placeURLForHTML(paragraphLength: WPTextParagraphLength, htmlOptions: WPHTMLOptions) -> URL {
        let htmlURLString = kWPPlaceRandomTextURLString
        let optionsString = htmlOptions.toURLPathString()
        
        let lengthURLString = htmlURLString + "\(paragraphLength.rawValue)"
        let fullURLString = lengthURLString + "/\(optionsString)"
        
        return URL(string: fullURLString)!
    }
}

//MARK: - Colors
public extension Wallpaper {
    
    public class func placeRandomColorWithHue(_ hue: CGFloat) -> UIColor {
        assert(hue <= 1 && hue >= 0, "Hue value must be between 0 and 1")
        
        let upperLimit = 100
        let lowerLimit = 10
        
        let percentRange = NSMakeRange(lowerLimit, upperLimit - lowerLimit)
        
        let s = randomPercentage(in: percentRange)
        let b = randomPercentage(in: percentRange)
        
        return UIColor(hue: hue, saturation: s, brightness: b, alpha: 1.0)
    }
    
    public class func placeRandomColor() -> UIColor {
        return placeRandomColorWithAlpha(1.0)
    }
    
    public class func placeRandomColorWithAlpha(_ alpha: CGFloat) -> UIColor {
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
    
    public class func placeRandomGreyscaleColor(_ alpha: CGFloat) -> UIColor {
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
fileprivate extension Wallpaper {
    
    class func randomPhoneNumber() -> String {
        return "(\(arc4random_uniform(000))) \(arc4random_uniform(999))-\(arc4random_uniform(9999))"
    }
    
    class func randomInteger(lessThan: UInt32) -> Int {
        return Int(arc4random_uniform(lessThan))
    }
    
    class func randomFloat(lessThan: UInt32) -> CGFloat {
        return (CGFloat(arc4random_uniform(lessThan)) + randomPercentage())
    }
    
    class func randomFloat(in range: NSRange) -> CGFloat {
        
        return ((CGFloat(range.location) + CGFloat(arc4random_uniform(UInt32(range.length)))) + randomPercentage())
    }
    
    class func randomPercentage() -> CGFloat {
        return (CGFloat(arc4random_uniform(100)) / 100.0)
    }
    
    class func randomPercentage(in range: NSRange) -> CGFloat {
        return ((CGFloat(range.location) + CGFloat(arc4random_uniform(UInt32(range.length)))) / 100.0)
    }
}

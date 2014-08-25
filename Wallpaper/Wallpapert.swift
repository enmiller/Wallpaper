//
//  Wallpaper.swift
//  Wallpaper
//
//  Created by Eric Miller on 8/21/14.
//  Copyright (c) 2014 Xero. All rights reserved.
//

import UIKit
import Foundation

public enum WPTextParagraphLength: Int {
    case VeryShort = 0
    case Short = 1
    case Medium = 2
    case Long = 3
    case VeryLong = 4
}

public struct WPTextOptions : RawOptionSetType, BooleanType {
    private var value: UInt = 0
    init(_ value: UInt) { self.value = value }
    public var boolValue: Bool { return self.value != 0 }
    public func toRaw() -> UInt { return self.value }
    public static var allZeros: WPTextOptions { return self(0) }
    public static func fromRaw(raw: UInt) -> WPTextOptions? { return self(raw) }
    public static func fromMask(raw: UInt) -> WPTextOptions { return self(raw) }
    public static func convertFromNilLiteral() -> WPTextOptions { return self(0) }

    static var None: WPTextOptions { return self(0) }
    static var AllCaps: WPTextOptions { return self(1 << 0) }
    static var Prude: WPTextOptions { return self(1 << 1) }
}

public struct WPHTMLOptions : RawOptionSetType, BooleanType {
    private var value: UInt = 0
    init(_ value: UInt) { self.value = value }
    public var boolValue: Bool { return self.value != 0 }
    public func toRaw() -> UInt { return self.value }
    public static var allZeros: WPHTMLOptions { return self(0) }
    public static func fromRaw(raw: UInt) -> WPHTMLOptions? { return self(raw) }
    public static func fromMask(raw: UInt) -> WPHTMLOptions { return self(raw) }
    public static func convertFromNilLiteral() -> WPHTMLOptions { return self(0) }

    static var None:             WPHTMLOptions { return self(0) }
    static var EmphasisTags:     WPHTMLOptions { return self(1 << 0) }
    static var AnchorTags:       WPHTMLOptions { return self(1 << 1) }
    static var UnorderedList:    WPHTMLOptions { return self(1 << 2) }
    static var OrderedList:      WPHTMLOptions { return self(1 << 3) }
    static var DescriptionList:  WPHTMLOptions { return self(1 << 4) }
    static var Blockquotes:      WPHTMLOptions { return self(1 << 5) }
    static var CodeSamples:      WPHTMLOptions { return self(1 << 6) }
    static var Headers:          WPHTMLOptions { return self(1 << 7) }
    static var AllCaps:          WPHTMLOptions { return self(1 << 8) }
    static var Prude:            WPHTMLOptions { return self(1 << 9) }
}

public let kWPPlaceKittenImageURLString = "http://placekitten.com/%@/%@"
public let kWPPlaceKittenGreyscaleImageURLString = "http://placekitten.com/g/%@/%@"
public let kWPPlaceBaconImageURLString = "http://baconmockup.com/%@/%@/"
public let kWPPlaceHolderImageURLString = "http://placehold.it/%@/%@/"
public let kWPPlaceRandomImageURLString = "http://lorempixel.com/%@/%@/"
public let kWPPlaceRandomGreyscaleImageURLString = "http://lorempixel.com/g/%@/%@/"
public let kWPPlaceRandomTextURLString = "http://loripsum.net/api/"
public let kWPPlaceRandomDowneyImageURLString = "http://rdjpg.com/%@/%@/"

public class Wallpaper: NSObject {

    private class func requestImage(path: String, size: CGSize, completion: (image: UIImage?) -> ()) {
        let screenScale: CGFloat = UIScreen.mainScreen().scale

        let urlString = NSString(format: path, "\(Int(size.width * screenScale))", "\(Int(size.height * screenScale))")
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if error == nil {
                let image = UIImage(data: data, scale: screenScale)
                completion(image: image);
            } else {
                println("++ Wallpaper Error: \(error)")
                completion(image: nil)
            }
        }
    }

    private class func paragraphLengthParameterFromParagraphLength(paragraphLength: WPTextParagraphLength) -> String {
        var paragraphLengthParameter: String
        switch paragraphLength {
        case .VeryShort:
            paragraphLengthParameter = "veryshort"
            break
        case .Short:
            paragraphLengthParameter = "short"
            break
        case .Medium:
            paragraphLengthParameter = "medium"
            break
        case .Long:
            paragraphLengthParameter = "long"
            break
        case .VeryLong:
            paragraphLengthParameter = "verylong"
            break
        }

        return paragraphLengthParameter
    }

    private class func htmlOptionsString(htmlOptions: WPHTMLOptions) -> String {
        var optionsString: String = ""

        if (htmlOptions & WPHTMLOptions.AnchorTags) {
            optionsString = optionsString.stringByAppendingPathComponent("link")
        }
        if (htmlOptions & WPHTMLOptions.EmphasisTags) {
            optionsString = optionsString.stringByAppendingPathComponent("decorate")
        }
        if (htmlOptions & WPHTMLOptions.UnorderedList) {
            optionsString = optionsString.stringByAppendingPathComponent("u1")
        }
        if (htmlOptions & WPHTMLOptions.OrderedList) {
            optionsString = optionsString.stringByAppendingPathComponent("o1")
        }
        if (htmlOptions & WPHTMLOptions.DescriptionList) {
            optionsString = optionsString.stringByAppendingPathComponent("d1")
        }
        if (htmlOptions & WPHTMLOptions.Blockquotes) {
            optionsString = optionsString.stringByAppendingPathComponent("bq")
        }
        if (htmlOptions & WPHTMLOptions.CodeSamples) {
            optionsString = optionsString.stringByAppendingPathComponent("code")
        }
        if (htmlOptions & WPHTMLOptions.Headers) {
            optionsString = optionsString.stringByAppendingPathComponent("headers")
        }
        if (htmlOptions & WPHTMLOptions.AllCaps) {
            optionsString = optionsString.stringByAppendingPathComponent("allcaps")
        }
        if (htmlOptions & WPHTMLOptions.Prude) {
            optionsString = optionsString.stringByAppendingPathComponent("prude")
        }

        return optionsString
    }
}

//MARK: - Images
public extension Wallpaper {

    public class func placeKittenImage(size: CGSize, completion: (image: UIImage?) -> ()) {
        requestImage(kWPPlaceKittenImageURLString, size: size, completion: completion)
    }

    public class func placeKittenGreyscaleImage(size: CGSize, completion: (image: UIImage?) -> ()) {
        requestImage(kWPPlaceKittenGreyscaleImageURLString, size: size, completion: completion)
    }

    public class func placeBaconImage(size: CGSize, completion: (image: UIImage?) -> ()) {
        requestImage(kWPPlaceBaconImageURLString, size: size, completion: completion)
    }

    public class func placeHolderImage(size: CGSize, completion: (image: UIImage?) -> ()) {
        requestImage(kWPPlaceHolderImageURLString, size: size, completion: completion)
    }

    public class func placeRandomImage(size: CGSize, category: String, completion: (image: UIImage?) -> ()) {
        let path = kWPPlaceRandomImageURLString.stringByAppendingPathComponent(category)
        requestImage(path, size: size, completion: completion)
    }

    public class func placeRandomGreyscaleImage(size: CGSize, category: String, completion: (image: UIImage?) -> ()) {
        let path = kWPPlaceRandomGreyscaleImageURLString.stringByAppendingPathComponent(category)
        requestImage(path, size: size, completion: completion)
    }

    public class func placeRandomImage(size: CGSize, completion: (image: UIImage?) -> ()) {
        requestImage(kWPPlaceRandomImageURLString, size: size, completion: completion)
    }

    public class func placeRandomGreyscaleImage(size: CGSize, completion: (image: UIImage?) -> ()) {
        requestImage(kWPPlaceRandomGreyscaleImageURLString, size: size, completion: completion)
    }

    public class func placeDowneyImage(size: CGSize, completion: (image: UIImage?) -> ()) {
        requestImage(kWPPlaceRandomDowneyImageURLString, size: size, completion: completion)
    }
}


//MARK: - Text
public extension Wallpaper {

    public class func placeText(numberOfParagraphs: Int, paragraphLength: WPTextParagraphLength, textOptions: WPTextOptions, completion: (placeText: String?) -> ()) {
        assert(numberOfParagraphs > 0, "Number of paragraphs is invalid")

        var urlString = kWPPlaceRandomTextURLString
        if (textOptions & WPTextOptions.AllCaps) {
            urlString = urlString.stringByAppendingPathComponent("allcaps")
        }

        if (textOptions & WPTextOptions.Prude) {
            urlString = urlString.stringByAppendingPathComponent("prude")
        }

        let paragraphLengthParameter = paragraphLengthParameterFromParagraphLength(paragraphLength)
        urlString = urlString.stringByAppendingPathComponent("plaintext")
        urlString = urlString.stringByAppendingPathComponent(paragraphLengthParameter)

        let paragraphArgs = "\(numberOfParagraphs)"
        urlString = urlString.stringByAppendingPathComponent(paragraphArgs)
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url)
         NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if error == nil {
                let returnString = NSString(data: data, encoding: NSUTF8StringEncoding)
                completion(placeText: returnString)
            } else {
                println("++ Wallpaper Error: \(error)")
                completion(placeText: nil)
            }
        }
    }

    public class func placeHipsterIpsum(numberOfParagraphs: Int, shotOfLatin: Bool, completion: (hipsterIpsum: String?) -> ()) {
        var hipsterPath: String = "http://hipsterjesus.com/api?paras=\(numberOfParagraphs)&html=false"
        if shotOfLatin {
            hipsterPath += "&type=hipster-latin"
        } else {
            hipsterPath += "&type=hipster-centric"
        }

        let url = NSURL(string: hipsterPath)
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if error == nil {
                var dict: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as NSDictionary
                let returnString = dict["text"] as String
                completion(hipsterIpsum: returnString)
            } else {
                println("++ Wallpaper Error: \(error)")
                completion(hipsterIpsum: nil)
            }
        }
    }

    public class func placeHTML(numberOfParagraphs: Int, paragraphLength: WPTextParagraphLength, options: WPHTMLOptions, completion: (placeText: String?) -> ()) -> () {
        let htmlURL = placeURLForHTML(numberOfParagraphs, paragraphLength: paragraphLength, htmlOptions: options)
        let request = NSURLRequest(URL: htmlURL)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if error == nil {
                let returnString = NSString(data: data, encoding: NSUTF8StringEncoding)
                completion(placeText: returnString)
            } else {
                println("++ Wallpaper Error: \(error)")
                completion(placeText: nil)
            }
        }
    }

    public class func placeURLForHTML(paragraphs: Int, paragraphLength: WPTextParagraphLength, htmlOptions: WPHTMLOptions) -> NSURL {
        var htmlURLString = kWPPlaceRandomTextURLString
        let optionsString = htmlOptionsString(htmlOptions)
        let lengthString = paragraphLengthParameterFromParagraphLength(paragraphLength)

        htmlURLString = htmlURLString.stringByAppendingPathComponent(lengthString)
        htmlURLString = htmlURLString.stringByAppendingPathComponent(optionsString)

        return NSURL(string: htmlURLString)
    }
}

//MARK: - Data
//public extension Wallpaper {
//
//    public class func placeRandomFirstName() -> String {
//        let males = maleFirstNames()
//        let females = femaleFirstNames()
//        let names: NSArray = males.arrayByAddingObjectsFromArray(females)
//
//        return  names[arc4random_uniform(names.count)]
//    }
//
//    public class func placeRandomLastName() -> String {
//        let names = lastNames()
//        return names[arc4random_uniform(names.count)]
//    }
//
//    public class func placeRandomFullName() -> String {
//        return "\(placeRandomFirstName()) \(placeRandomLastName())"
//    }
//
//    public class func placeRandomBusinessName(numberOfWords: UInt) -> String {
//        return "Not Yet Implemented"
//    }
//}

//MARK: - Random Numbers
public extension Wallpaper {

    public class func placeRandomPhoneNumber() -> String {
        return "(\(arc4random_uniform(000))) \(arc4random_uniform(999))-\(arc4random_uniform(9999))"
    }

    public class func placeRandomInteger(lessThan: UInt32) -> Int {
        return Int(arc4random_uniform(lessThan))
    }

    public class func placeRandomFloat(lessThan: UInt32) -> CGFloat {
        return (CGFloat(arc4random_uniform(lessThan)) + placeRandomPercentage())
    }

    public class func placeRandomFloat(range: NSRange) -> CGFloat {
        return (CGFloat(range.location + arc4random_uniform(UInt32(range.length))) + placeRandomPercentage())
    }

    public class func placeRandomPercentage() -> CGFloat {
        return (CGFloat(arc4random_uniform(100)) / 100.0)
    }

    public class func placeRandomPercentage(range: NSRange) -> CGFloat {
        return (CGFloat(range.location + arc4random_uniform(UInt32(range.length))) / 100.0)
    }
}

//MARK: - Geometry
public extension Wallpaper {

    public class func placeRandomSize(dimensionRange: NSRange) -> CGSize {
        return placeRandomSize(xRange: dimensionRange, yRange: dimensionRange)
    }

    public class func placeRandomSize(#xRange: NSRange, yRange: NSRange) -> CGSize {
        let width = round(placeRandomFloat(xRange))
        let height = round(placeRandomFloat(yRange))
        return CGSizeMake(width, height)
    }

    public class func placeRandomRect(withinRect rect: CGRect) -> CGRect {
        let minX = CGRectGetMinX(rect)
        let maxX = CGRectGetMaxX(rect)
        let minY = CGRectGetMinY(rect)
        let maxY = CGRectGetMaxY(rect)
        let maxWidth = CGRectGetWidth(rect)
        let maxHeight = CGRectGetHeight(rect)

        let rectSize = placeRandomSize(xRange: NSMakeRange(0, Int(maxWidth)), yRange: NSMakeRange(0, Int(maxHeight)))
        let xOrigin = placeRandomFloat(NSMakeRange(Int(minX), Int(maxX - rectSize.width)))
        let yOrigin = placeRandomFloat(NSMakeRange(Int(minY), Int(maxY - rectSize.height)))

        return CGRectMake(xOrigin, yOrigin, rectSize.width, rectSize.height)
    }

    public class func placeRandomPoint(withinRect rect: CGRect) -> CGPoint {
        let minX = CGRectGetMinX(rect)
        let maxX = CGRectGetMaxX(rect)
        let minY = CGRectGetMinY(rect)
        let maxY = CGRectGetMaxY(rect)

        let xOrigin = placeRandomFloat(NSMakeRange(Int(minX), Int(maxX)))
        let yOrigin = placeRandomFloat(NSMakeRange(Int(minY), Int(maxY)))

        return CGPointMake(xOrigin, yOrigin)
    }
}

//MARK: - Colors
public extension Wallpaper {

    public class func placeRandomColorWithHue(hue: CGFloat) -> UIColor {
        assert(hue <= 1 && hue >= 0, "Hue value must be between 0 and 1")

        let s = placeRandomPercentage(NSMakeRange(10, 90))
        let b = placeRandomPercentage(NSMakeRange(10, 90))

        return UIColor(hue: hue, saturation: s, brightness: b, alpha: 1.0)
    }

    public class func placeRandomColor() -> UIColor {
        return placeRandomColorWithAlpha(1.0)
    }

    public class func placeRandomColorWithAlpha(alpha: CGFloat) -> UIColor {
        let r = placeRandomPercentage()
        let g = placeRandomPercentage()
        let b = placeRandomPercentage()

        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }

    public class func placeRandomColorWithRandomAlpha() -> UIColor {
        let alpha = max(placeRandomPercentage(), 0.1)
        return placeRandomColorWithAlpha(alpha)
    }

    public class func placeRandomGreyscaleColor() -> UIColor {
        return placeRandomGreyscaleColor(1.0)
    }

    public class func placeRandomGreyscaleColor(alpha: CGFloat) -> UIColor {
        let greyness = min(max(placeRandomPercentage(), 0.1), 0.95)
        return UIColor(white: greyness, alpha: alpha)
    }

    public class func placeRandomGreyscaleColorWithRandomAlpha() -> UIColor {
        let alpha = max(placeRandomPercentage(), 0.1)
        return placeRandomGreyscaleColor(alpha)
    }

    public class func placeRandomColorWithHueOfColor(color: UIColor) -> UIColor {
        var hue: CGFloat = 0.0
        color.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
        return placeRandomColorWithHue(hue)
    }
}

//MARK: - Private Data Helpers
//private extension Wallpaper {
//
//    class func femaleFirstNames() -> NSArray {
//        return ["Malinda", "Kaye", "Audra", "Trudie", "Stacee", "Esta", "Albertina", "Nakia",
//                "Bettye", "Remona", "Kimberli", "Clarinda", "Gussie", "Carmina", "Alia", "Shaquita",
//                "Rosalee", "Nicki", "Tamica", "Tressa", "Yvette", "Shantae", "Trena", "Abbie",
//                "Isabella", "Fiona", "Alejandrina", "Hyo", "Marvis", "Alexandra", "Torri", "Gemma"]
//    }
//
//    class func maleFirstNames() -> NSArray {
//        return ["Phillip", "Gene", "Trenton", "Darwin", "Darrin", "Herman", "Cody", "Maximo",
//                "Gabriel", "Noble", "Adan", "Dale", "Ali", "Laurence", "Paris", "Orval", "Randy",
//                "Ed", "Alonzo", "Margarito", "Leonard", "Houston", "Zackary", "Darnell", "Whitney",
//                "Samuel", "Claud", "Derick", "Teddy", "Rigoberto", "Leonardo", "Clay", "Lyman"]
//    }
//
//    class func lastNames() -> NSArray {
//        return ["Mclawhorn", "Lyvers", "Deborde", "Scarberry", "Swearingen", "Mccampbell", "Strum",
//                "Banuelos", "Parrish", "Bueno", "Wegener", "Vieira", "Plantz", "Mcquaid", "Bruckner",
//                "Orchard", "Wall", "Gerth", "Schweiger", "Minder", "Correa", "Cremer", "Close",
//                "Zink", "Victorian", "Bickle", "Vanorden", "Lauro", "Whitsitt", "Dubose", "Nowell"]
//    }
//
//    class func businessNameSingleWordPrefix() -> NSArray {
//        return ["Micro", "Star", "Wal", "Du", "Goo", "Citi", "Cono", "Kro", "Proc", "Boe", "Com",
//                "Sys", "Super", "Aet", "All", "Nation"]
//    }
//
//    class func businessNameSingleWordSuffix() -> NSArray {
//        return ["get", "bucks", "pont", "gle", "co", "ger", "ter", "thon", "soft", "get", "ing",
//                "cast", "a", "well", "na", "state", "r"]
//    }
//
//    class func businessPreFixes() -> NSArray {
//        return ["News", "Home", "World", "General", "Giant", "Big", "Honey", "Delta", "Southwest",
//                "Dr.", "Citi", "Wells", "Jamba", "Cost", "Green"]
//    }
//
//    class func businessMiddleParts() -> NSArray {
//        return ["Depot", "Juice", "Bucks", "Market", "Air", "Commercial", "Fuel", "Motor",
//                "Electric", "Mae", "Fruit"]
//    }
//
//    class func businessSuffixes() -> NSArray {
//        return ["Motors", "Builders", "Works", "Technologies", "Institute", "Labs", "Communications",
//                "Electric", "Co-Op", "Holdings", "Systems", "International", "Mobile", "Bank",
//                "Electric"]
//    }
//
//    class func businessCorporateMonickers() -> NSArray {
//        return [", Inc", " Incorporated", ", LLC", ", PC", " Group"]
//    }
//
//    class func businessDomains() -> NSArray {
//        return [".com", ".net"]
//    }
//}

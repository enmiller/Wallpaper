//
//  Wallpaper_DemoTests.swift
//  Wallpaper-DemoTests
//
//  Created by Eric Miller on 8/22/14.
//  Copyright (c) 2014 Xero. All rights reserved.
//

import UIKit
import XCTest

class Wallpaper_ImageTests: XCTestCase {
    
    let theSize = CGSize(width: 100.0, height: 200.0)
    let expectationTimeoutString = "The test expectation did not return in time"
    let imageFailureString = "The network returned a nil image"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

//MARK: - Images
    func testPlaceKittenImageReturnsImage() {
        let completedExpectation = expectation(description: "completed")
        
        Wallpaper.placeKittenImage(size: theSize, completion: { (image) -> () in
            XCTAssertNotNil(image, self.imageFailureString)
            completedExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: { (error) -> Void in
            XCTAssertNil(error, self.expectationTimeoutString)
        })
    }
    
    func testPlaceGreyscaleKittenImageReturnsImage() {
        let completedExpectation = expectation(description: "completed")
        
        Wallpaper.placeKittenGreyscaleImage(size: theSize, completion: { (image) -> () in
            XCTAssertNotNil(image, self.imageFailureString)
            completedExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: { (error) -> Void in
            XCTAssertNil(error, self.expectationTimeoutString)
        })
    }
    
    func testPlaceBaconImgeReturnsImage() {
        let completedExpectation = expectation(description: "completed")
        
        Wallpaper.placeBaconImage(size: theSize, completion: { (image) -> () in
            XCTAssertNotNil(image, self.imageFailureString)
            completedExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: { (error) -> Void in
            XCTAssertNil(error, self.expectationTimeoutString)
        })
    }
    
    func testPlaceHolderImageReturnsImage() {
        let completedExpectation = expectation(description: "completed")
        
        Wallpaper.placeHolderImage(size: theSize, completion: { (image) -> () in
            XCTAssertNotNil(image, self.imageFailureString)
            completedExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: { (error) -> Void in
            XCTAssertNil(error, self.expectationTimeoutString)
        })
    }
    
    func testPlaceRandomImageReturnsImage() {
        let completedExpectation = expectation(description: "completed")
        
        Wallpaper.placeRandomImage(size: theSize, completion: { (image) -> () in
            XCTAssertNotNil(image, self.imageFailureString)
            completedExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: { (error) -> Void in
            XCTAssertNil(error, self.expectationTimeoutString)
        })
    }
    
    func testPlaceRandomGreyscaleImageReturnsImage() {
        let completedExpectation = expectation(description: "completed")
        
        Wallpaper.placeRandomGreyscaleImage(size: theSize, completion: { (image) -> () in
            XCTAssertNotNil(image, self.imageFailureString)
            completedExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: { (error) -> Void in
            XCTAssertNil(error, self.expectationTimeoutString)
        })
    }
    
    func testPlaceDowneyImageReturnsImage() {
        let completedExpectation = expectation(description: "completed")
        
        Wallpaper.placeDowneyImage(size: theSize, completion: { (image) -> () in
            XCTAssertNotNil(image, self.imageFailureString)
            completedExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: { (error) -> Void in
            XCTAssertNil(error, self.expectationTimeoutString)
        })
    }
    
}

class Wallpaper_TextTests: XCTestCase {
    let expectationTimeoutString = "The test expectation did not return in time"
    let textFailureString = "The network did not return any text"
    
//MARK: - Text
    func testPlaceTextWithOneParagraphShortLengthAllCapsReturnsText() {
        let completedExpectation = expectation(description: "completed")
        
        Wallpaper.placeText(numberOfParagraphs: 1, paragraphLength: .Short, textOptions: .AllCaps) { (placeText) -> () in
            XCTAssertNotNil(placeText, self.textFailureString)
            completedExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: { (error) -> Void in
            XCTAssertNil(error, self.expectationTimeoutString)
        })
    }
    
    func testPlaceHipsterTextWithOneParagraphNoLatinReturnsText() {
        let completedExpectation = expectation(description: "completed")
        
        Wallpaper.placeHipsterIpsum(numberOfParagraphs: 1, shotOfLatin: false) { (hipsterIpsum) -> () in
            XCTAssertNotNil(hipsterIpsum, self.textFailureString)
            completedExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: { (error) -> Void in
            XCTAssertNil(error, self.expectationTimeoutString)
        })
    }
    
    func testPlaceHTMLWithTwoParagraphsLongLengthBlockquoteReturnsText() {
        let completedExpectation = expectation(description: "completed")
        
        Wallpaper.placeHTML(numberOfParagraphs: 2, paragraphLength: .Long, options: .Blockquotes) { (placeText) -> () in
            XCTAssertNotNil(placeText, self.textFailureString)
            completedExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: { (error) -> Void in
            XCTAssertNil(error, self.expectationTimeoutString)
        })
    }
    
    func testPlaceURLForHTMLWithMediumLengthEmphasisTagOptionReturnsURL() {
        let knownURLString = "http://loripsum.net/api/medium/decorate"
        let returnedURL = Wallpaper.placeURLForHTML(paragraphLength: .Medium, htmlOptions: .EmphasisTags)
        let returnedURLString = "\(returnedURL)"
        XCTAssert(knownURLString == returnedURLString, "The returned URL did not match the expected URL")
    }
}

class Wallpaper_ColorTests: XCTestCase {
    let huePercentage: CGFloat = 0.45
    let alpha: CGFloat = 0.5
    
    func testRandomColorWithHueReturnsColor() {
        let color = Wallpaper.placeRandomColorWithHue(huePercentage)
        
        XCTAssertNotNil(color, "Color was nil!")
    }
    
    func testRandomColorWithHue() {
        
        let color = Wallpaper.placeRandomColorWithHue(huePercentage)
        
        var resultingHue: CGFloat = 0.0
        color.getHue(&resultingHue, saturation: nil, brightness: nil, alpha: nil)
        XCTAssertEqualWithAccuracy(resultingHue, huePercentage, accuracy: 0.001, "Resulting hue was not the same as the input hue!");
    }
    
    func testRandomColorReturnsColor() {
        let color = Wallpaper.placeRandomColor()
        
        XCTAssertNotNil(color, "Color was nil!")
    }
    
    func testRandomAlphaColorReturnsColor() {
        let color = Wallpaper.placeRandomColorWithAlpha(alpha)
        
        XCTAssertNotNil(color, "Color was nil!")
    }
    
    func testRandomAlphaColorReturnsColorWithAlpha() {
        let color = Wallpaper.placeRandomColorWithAlpha(alpha)
        
        var resultingAlpha: CGFloat = 0.0
        color.getWhite(nil, alpha: &resultingAlpha)
        
        XCTAssertEqualWithAccuracy(alpha, resultingAlpha, accuracy: 0.0001, "Alpha values were not equal!")
    }
    
//    func testRandomGreyscaleColorHasGreyscaleColorSpace() {
//        let color = Wallpaper.placeRandomGreyscaleColor()
//        
//        let colorSpace: CGColorSpace? = color.cgColor.colorSpace
//        let greyScaleColorSpace = CGColorSpaceCreateDeviceGray()
//        XCTAssertTrue(colorSpace === greyScaleColorSpace, "Colorspace was not a greyscale color space!")
//    }
    
    func testRandomGreyscaleColorWithAlphaReturnsCorrectAlpha() {
        let color = Wallpaper.placeRandomGreyscaleColor(alpha)
        var resultingAlpha: CGFloat = 0.0
        color.getWhite(nil, alpha: &resultingAlpha)
        
        XCTAssertEqualWithAccuracy(alpha, resultingAlpha, accuracy: 0.0001, "Alpha values were not equal!")
    }
}

//
//  Wallpaper_DemoTests.swift
//  Wallpaper-DemoTests
//
//  Created by Eric Miller on 8/22/14.
//  Copyright (c) 2014 Xero. All rights reserved.
//

import UIKit
import XCTest

class Wallpaper_DemoTests: XCTestCase {
    
    let theSize = CGSizeMake(100.0, 200.0)
    let expectationTimeoutString = "The test expectation did not return in time"
    let imageFailureString = "The network returned a nil image"
    let textFailureString = "The network did not return any text"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

//MARK: - Images
    func testPlaceKittenImageReturnsImage() {
        let completedExpectation = expectationWithDescription("completed")
        
        Wallpaper.placeKittenImage(theSize, completion: { (image) -> () in
            XCTAssertNotNil(image, self.imageFailureString)
            completedExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { (error) -> Void in
            XCTAssertNil(error, self.expectationTimeoutString)
        })
    }
    
    func testPlaceGreyscaleKittenImageReturnsImage() {
        let completedExpectation = expectationWithDescription("completed")
        
        Wallpaper.placeKittenGreyscaleImage(theSize, completion: { (image) -> () in
            XCTAssertNotNil(image, self.imageFailureString)
            completedExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { (error) -> Void in
            XCTAssertNil(error, self.expectationTimeoutString)
        })
    }
    
    func testPlaceBaconImgeReturnsImage() {
        let completedExpectation = expectationWithDescription("completed")
        
        Wallpaper.placeBaconImage(theSize, completion: { (image) -> () in
            XCTAssertNotNil(image, self.imageFailureString)
            completedExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { (error) -> Void in
            XCTAssertNil(error, self.expectationTimeoutString)
        })
    }
    
    func testPlaceHolderImageReturnsImage() {
        let completedExpectation = expectationWithDescription("completed")
        
        Wallpaper.placeHolderImage(theSize, completion: { (image) -> () in
            XCTAssertNotNil(image, self.imageFailureString)
            completedExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { (error) -> Void in
            XCTAssertNil(error, self.expectationTimeoutString)
        })
    }
    
    func testPlaceRandomImageReturnsImage() {
        let completedExpectation = expectationWithDescription("completed")
        
        Wallpaper.placeRandomImage(theSize, completion: { (image) -> () in
            XCTAssertNotNil(image, self.imageFailureString)
            completedExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { (error) -> Void in
            XCTAssertNil(error, self.expectationTimeoutString)
        })
    }
    
    func testPlaceRandomGreyscaleImageReturnsImage() {
        let completedExpectation = expectationWithDescription("completed")
        
        Wallpaper.placeRandomGreyscaleImage(theSize, completion: { (image) -> () in
            XCTAssertNotNil(image, self.imageFailureString)
            completedExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { (error) -> Void in
            XCTAssertNil(error, self.expectationTimeoutString)
        })
    }
    
    func testPlaceDowneyImageReturnsImage() {
        let completedExpectation = expectationWithDescription("completed")
        
        Wallpaper.placeDowneyImage(theSize, completion: { (image) -> () in
            XCTAssertNotNil(image, self.imageFailureString)
            completedExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { (error) -> Void in
            XCTAssertNil(error, self.expectationTimeoutString)
        })
    }
    
//MARK: - Text
    func testPlaceTextWithOneParagraphShortLengthAllCapsReturnsText() {
        let completedExpectation = expectationWithDescription("completed")
        
        Wallpaper.placeText(1, paragraphLength: .Short, textOptions: .AllCaps) { (placeText) -> () in
            XCTAssertNotNil(placeText, self.textFailureString)
            completedExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5, handler: { (error) -> Void in
            XCTAssertNil(error, self.expectationTimeoutString)
        })
    }
    
    func testPlaceHipsterTextWithOneParagraphNoLatinReturnsText() {
        let completedExpectation = expectationWithDescription("completed")
        
        Wallpaper.placeHipsterIpsum(1, shotOfLatin: false) { (hipsterIpsum) -> () in
            XCTAssertNotNil(hipsterIpsum, self.textFailureString)
            completedExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5, handler: { (error) -> Void in
            XCTAssertNil(error, self.expectationTimeoutString)
        })
    }
    
    func testPlaceHTMLWithTwoParagraphsLongLengthBlockquoteReturnsText() {
        let completedExpectation = expectationWithDescription("completed")
        
        Wallpaper.placeHTML(2, paragraphLength: .Long, options: .Blockquotes) { (placeText) -> () in
            XCTAssertNotNil(placeText, self.textFailureString)
            completedExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5, handler: { (error) -> Void in
            XCTAssertNil(error, self.expectationTimeoutString)
        })
    }
    
    func testPlaceURLForHTMLWithMediumLengthEmphasisTagOptionReturnsURL() {
        let knownURLString = "http://loripsum.net/api/medium/decorate"
        let returnedURL = Wallpaper.placeURLForHTML(.Medium, htmlOptions: .EmphasisTags)
        let returnedURLString = "\(returnedURL)"
        XCTAssert(knownURLString == returnedURLString, "The returned URL did not match the expected URL")
    }
}

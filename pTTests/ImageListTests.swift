//
//  ImageListTests.swift
//  pTTests
//
//  Created by Владимир Клевцов on 19.10.23..
//

@testable import pictureTape
import Foundation

import XCTest 
 // Import your app's module

final class ImageListViewControllerTests: XCTestCase {
    var imageListViewController: ImageListViewController!
    var imageListHelperSpy: ImageListHelperSpy!

    override func setUp() {
        super.setUp()
        imageListViewController = ImageListViewController()
        imageListHelperSpy = ImageListHelperSpy()
        imageListViewController.helper = imageListHelperSpy
    }

    override func tearDown() {
        imageListViewController = nil
        imageListHelperSpy = nil
        super.tearDown()
    }

    func testSetIsLikeCall() {
        let cell = ImageListCell()
        let indexPath = IndexPath(row: 0, section: 0)
        
        imageListViewController.helper?.setIsLiked(isLike: true, cell: cell)

        XCTAssertTrue(imageListHelperSpy.setIsLikedCalled)
        XCTAssertEqual(imageListHelperSpy.isLikedValue, true)
        XCTAssertEqual(imageListHelperSpy.cellValue, cell)
    }
}



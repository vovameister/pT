//
//  pictureTapeTests.swift
//  pictureTapeTests
//
//  Created by Владимир Клевцов on 21.9.23..
//
@testable import pictureTape
import XCTest


final class pictureTapeTests: XCTestCase {
    
    func testFetchPhotos() {
            let service = ImagesListService()
            
            let expectation = self.expectation(description: "Wait for Notification")
            NotificationCenter.default.addObserver(
                forName: ImagesListService.DidChangeNotification,
                object: nil,
                queue: .main) { _ in
                    expectation.fulfill()
                }
            
        service.fetchPhotosNextPage(completion: { result in
            switch result {
            case .success(let result):
                    print("\(result)")
            case .failure(let error):
                
                print("error \(error)")
            }
        })
            wait(for: [expectation], timeout: 10)
            
            XCTAssertEqual(service.photo.count, 10)
        }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

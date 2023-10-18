//
//  ProfileViewTests.swift
//  pTTests
//
//  Created by Владимир Клевцов on 18.10.23..
//

@testable import pictureTape
import Foundation

import XCTest

final class ProfileViewTests: XCTestCase {
    func testButtonTappedCallsPresenterMethod() {
           let profileViewController = ProfileViewController()
           let presenterSpy = ProfilePresenterSpy()
           profileViewController.profilePresenter = presenterSpy
           
           profileViewController.buttonTapped()
           
           XCTAssertTrue(presenterSpy.presenterCalled)
       }
}

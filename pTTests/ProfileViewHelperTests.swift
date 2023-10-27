//
//  ProfileViewHelperTests.swift
//  pTTests
//
//  Created by Владимир Клевцов on 23.10.23..
//
@testable import pictureTape
import Foundation

import XCTest

final class ProfileViewHelperTests: XCTestCase {
    
    var profileViewController: ProfileViewController!
    var profileViewHelper: ProfileViewHelper!

    override func setUp() {
        super.setUp()
        
        profileViewController = ProfileViewController()
        profileViewHelper = ProfileViewHelper(viewController: profileViewController)
    }

    override func tearDown() {
        profileViewController = nil
        profileViewHelper = nil
        super.tearDown()
    }
    
    func testUpdateProfile() {
        let profileResult = pictureTape.ProfileResult(id: "10293801", userName: "someName", firstName: "someFirstName", lastName: "someLastName", bio: "XDD")
        let profile = pictureTape.Profile(from: profileResult)
        
        profileViewHelper.updateProfile(profile: profile)
        
        XCTAssertEqual(profileViewController.nameLabel.text, "someFirstName someLastName")
        XCTAssertEqual(profileViewController.nNLabel.text, "someName")
        XCTAssertEqual(profileViewController.messageLabel.text, "XDD")
    }
}

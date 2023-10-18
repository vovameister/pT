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
    func testUpdateAvatar() {
        let profileViewController = ProfileViewController()
        let profileViewHelper = ProfileViewHelperSpy()
        profileViewController.profileViewHelper = profileViewHelper
        
        profileViewController.profileViewHelper?.updateAvatar()
        
        XCTAssertTrue(profileViewHelper.avataUpdated)
    }
    func testUpdateProfile() {
        let profileViewController = ProfileViewController()
        let profileViewHelper = ProfileViewHelperSpy()
        profileViewController.profileViewHelper = profileViewHelper
        let profileResult = pictureTape.ProfileResult(id: "10293801", userName: "someName", firstName: "someFirstName", lastName: "someLastName", bio: "XDD")
        let profile = pictureTape.Profile(from: profileResult)
        
        profileViewController.profileViewHelper?.updateProfile(profile: profile)
        
        XCTAssertTrue(profileViewHelper.profileUpdated)
    }
}


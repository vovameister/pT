//
//  ProfilePresenterSpy.swift
//  pTTests
//
//  Created by Владимир Клевцов on 18.10.23..
//

@testable import pictureTape
import Foundation

final class ProfilePresenterSpy: ProfilePresenterProtocol {
    var presenterCalled = false
    func showAlertWithYesNoAction() {
        presenterCalled = true
    }
}
final class ProfileViewHelperSpy: ProfileViewHealperProtocol {
    var avataUpdated = false
    var profileUpdated = false
    
    func updateAvatar() {
       avataUpdated = true
    }
    
    func updateProfile(profile: pictureTape.Profile) {
        profileUpdated = true
    }
}


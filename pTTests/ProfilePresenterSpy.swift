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
final class ProfileViewControllerSpy: ProfileViewControllerProtocol {
    var updateAvataCalled = false
    func updateAvatar() {
        updateAvataCalled = true
    }
}

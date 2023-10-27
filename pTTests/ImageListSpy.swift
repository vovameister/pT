//
//  ImageListSpy.swift
//  pTTests
//
//  Created by Владимир Клевцов on 21.10.23..
//
@testable import pictureTape
import Foundation

final class ImageListHelperSpy: ImageListHelperProtocol {
    var setIsLikedCalled = false
    var isLikedValue: Bool?
    var cellValue: ImageListCell?

    func setIsLiked(isLike: Bool, cell: ImageListCell) {
        setIsLikedCalled = true
        isLikedValue = isLike
        cellValue = cell
    }
}


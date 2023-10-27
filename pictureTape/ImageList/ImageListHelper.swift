//
//  ImageListHelper.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 19.10.23..
//

import UIKit

protocol ImageListHelperProtocol {
    func setIsLiked(isLike: Bool, cell: ImageListCell)
}
final class ImageListHelper: ImageListHelperProtocol {
    func setIsLiked(isLike: Bool, cell: ImageListCell) {
        var likeButton = UIImage(named: "like_button")
        if isLike == false {
            likeButton = UIImage(named: "like_button")
            cell.likeButton.accessibilityIdentifier = "like_button"
        }
        else {
            likeButton = UIImage(named: "like_button_nil")
        }
        cell.likeButton.setImage(likeButton, for: .normal)
    }
}

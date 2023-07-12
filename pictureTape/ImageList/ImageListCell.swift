//
//  ImageListCell.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 10.7.23..
//

import UIKit

final class ImageListCell: UITableViewCell {
    static let reuseIdentifier = "ImageListCell"
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var imageCell: UIImageView!
    
}

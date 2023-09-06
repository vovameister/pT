//
//  UIBlock.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 17.8.23..
//

import UIKit
import ProgressHUD

final class UIBlock {
    private static var window: UIWindow? {
        return UIApplication.shared.windows.first
    }
    static func show() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.show()
    }
    static func dissmiss() {
        window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }
}

//
//  SingleImageViewController.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 19.7.23..
//


import UIKit
import Kingfisher
import ProgressHUD


final class SingleImageViewController: UIViewController {
    var imageUrlFull: String = ""
    
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet var imageView: UIImageView!
    
    func imageLoad() {
        guard let largeURL = URL(string: imageUrlFull) else { return }
        UIBlock.show()
        DispatchQueue.main.async {
            self.imageView.kf.setImage(with: largeURL, placeholder: nil, options: [], completionHandler: { result in
                switch result {
                case .success(_):
                    self.rescaleAndCenterImageInScrollView(image: self.imageView.image!)
                    UIBlock.dissmiss()
                    break
                case .failure(let error):
                    print("Image loading error: \(error)")
                    UIBlock.dissmiss()
                }
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLoad()
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
        rescaleAndCenterImageInScrollView(image: self.imageView.image!)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func shareButton(_ sender: Any) {
        let share = UIActivityViewController(activityItems: [self.imageView.image], applicationActivities: nil)
        present(share, animated: true)
    }
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
 
        let xOffset = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
            let yOffset = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
            
            // Apply the calculated offsets to center the image
            scrollView.contentInset = UIEdgeInsets(top: yOffset, left: xOffset, bottom: 0, right: 0)
    }
    
    
    private func rescaleAndCenterImageInScrollView(image: UIImage) {
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        view.layoutIfNeeded()
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = min(maxZoomScale, max(minZoomScale, max(hScale, vScale)))
        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
        let newContentSize = scrollView.contentSize
        let x = (newContentSize.width - visibleRectSize.width) / 2
        let y = (newContentSize.height - visibleRectSize.height) / 2
        scrollView.setContentOffset(CGPoint(x: x, y: y), animated: false)
    }
    
    
}
extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}


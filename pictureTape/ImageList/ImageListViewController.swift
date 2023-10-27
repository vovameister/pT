//
//  ViewController.swift
//  pictureTape
//
//  Created by Владимир Клевцов on 2.7.23..
//

import UIKit
import Kingfisher
import ProgressHUD

final class ImageListViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    var helper: ImageListHelperProtocol?
    
    private var ImageListServiceObserver: NSObjectProtocol?
    
    private var imageListService = ImagesListService()
    private let showSingleImageSegueIdentifier = "ShowSingleImage"
    private var photos: [Photo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        
        imageListService = ImagesListService()
        helper = ImageListHelper()
        
        imageListService.fetchPhotosNextPage(completion: { result in
            switch result {
            case .success(let result):
                self.photos = result
            case .failure(let error):
                print("error \(error)")
                return
            }
        })
        ImageListServiceObserver = NotificationCenter.default.addObserver(forName: ImagesListService.didChangeNotification, object: nil, queue: .main) {
            [weak self] _ in
            guard let self = self else { return }
            self.updateTableViewAnimated()
        }
        updateTableViewAnimated()
    }
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter
    }()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == showSingleImageSegueIdentifier,
              let viewController = segue.destination as? SingleImageViewController,
              let indexPath = sender as? IndexPath,
              indexPath.row < photos.count else {
            super.prepare(for: segue, sender: sender)
            return
        }
        viewController.imageUrlFull = photos[indexPath.row].largeImageURL
    }
    func updateTableViewAnimated() {
        let oldCount = tableView.numberOfRows(inSection: 0)
        let newCount = imageListService.photo.count
        photos = imageListService.photo
        if oldCount != newCount {
            tableView.performBatchUpdates {
                let indexPaths = (oldCount..<newCount).map { i in
                    IndexPath(row: i, section: 0)
                }
                tableView.insertRows(at: indexPaths, with: .automatic)
            } completion: { _ in }
        }
    }
}
extension ImageListViewController {
    func configCell(for cell: ImageListCell, with indexPath: IndexPath) {
        let thumbURLString = photos[indexPath.row].thumbImageURL
        
        if let thumbURL = URL(string: thumbURLString) {
            cell.imageCell.kf.indicatorType = .activity
            cell.imageCell.kf.setImage(with: thumbURL, placeholder: UIImage(named: "wave"), options: nil, completionHandler: { (result) in
                switch result {
                case .success(_):
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                case .failure(_):
                    break
                }
            })
        } else {
            return
        }
        if let date = photos[indexPath.row].convertCreatedAtToDate() {
            cell.dateLabel.text = dateFormatter.string(from: date)
        }
        
        let isLiked = !(imageListService.photo[indexPath.row].isLiked)
        helper?.setIsLiked(isLike: isLiked, cell: cell)
    }}

extension ImageListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageListCell.reuseIdentifier, for: indexPath)
        
        
        
        guard let imageListCell = cell as? ImageListCell else {
            return UITableViewCell()
        }
        imageListCell.delegate = self
        
        configCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
}
extension ImageListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == imageListService.photo.count,
           let isUITest = ProcessInfo.processInfo.environment["isUITest"], isUITest != "true"
        {
            imageListService.fetchPhotosNextPage(completion: { result in
                switch result {
                case .success(let result):
                        self.photos.append(contentsOf: result)
                case .failure(let error):
                    print("error \(error)")
                    return
                }
            })
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showSingleImageSegueIdentifier, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let photo = photos[indexPath.row]
            let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
            let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
            let imageWidth = photo.size.width
            let scale = imageViewWidth / imageWidth
            let cellHeight = photo.size.height * scale + imageInsets.top + imageInsets.bottom
            return cellHeight
    }
}
extension ImageListViewController: ImagesListCellDelegate {
    func imageListCellDidTapLike(_ cell: ImageListCell) {
        UIBlock.show()
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let photo = imageListService.photo[indexPath.row]
        self.imageListService.changeLike(photoId: photo.id, isLike: photo.isLiked) { [weak self] result in
            guard let self = self else { return }
    
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.helper?.setIsLiked(isLike: photo.isLiked, cell: cell)
                    UIBlock.dissmiss()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Failed to change like status: \(error)")
                    UIBlock.dissmiss()
                }
            }
        }
    }
}

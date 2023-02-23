//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Vladislav Green on 9/20/22.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    
//    private enum LocalizedKeys: String {
//        case title = "PhotosVС-title" // "Photo gallery"
//    }
    
    private enum Constants {
        static let numberOfItemsInLine: CGFloat = 3
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var dataSource = [UIImageView]()
    private let dataSourceImages: [UIImage] = MyImages.images
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupNavigationBar()
        self.filter(images: dataSourceImages)
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.title = "PhotosVС-title".localized

    }

    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}


extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        
        let post = self.dataSource[indexPath.row]

        cell.clipsToBounds = true
        cell.layer.borderColor = UIColor.black.cgColor
        cell.setup(with: post)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interItemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0

        let width = collectionView.frame.width - (Constants.numberOfItemsInLine - 1) * interItemSpacing - insets.left - insets.right
        let itemWidth = floor(width / Constants.numberOfItemsInLine)

        return CGSize(width: itemWidth, height: itemWidth)
    }
}

// структура для временного хранения данных подсчёта времени работы фильтра
struct Timing  {
    static var startFilterTime: Double = 0.0
    static var startExportTime: Double = 0.0
    static var diffTime: Double = 0.0
}


//  расширенеие для функций обработки и экспорта изображений
extension PhotosViewController {
    
    private func filter(images: [UIImage]) {
        
        let start = CFAbsoluteTimeGetCurrent()
        Timing.startFilterTime = start
        
        ImageProcessor().processImagesOnThread(
            sourceImages: images,
            filter: .noir,
            qos: .default,
            completion: exportImageViews(images: )
        )
    }
            
    private func exportImageViews(images: [CGImage?]) {
        
        let start = CFAbsoluteTimeGetCurrent()
        Timing.startExportTime = start
        let diff = Timing.startExportTime - Timing.startFilterTime
        
        imageProcessingReport(diffTime: diff) { result in
            switch result {
            case .success(let diff):
                print("Not bad! It takes just \(diff) sec to process all images")
            case .failure(let error):
                print(error.description)
            }
        }
        
        print("Filtering took \(diff) sec to process")

        let imagesCG = images
        for i in 0..<imagesCG.count {
            let imageCG = imagesCG[i]
            let imageUI: UIImage = UIImage(cgImage: imageCG!)
            DispatchQueue.main.async {
                let imageView = UIImageView()
                imageView.image = imageUI
                self.dataSource.append(imageView)
//                print("exporting image \(i+1)")
                self.collectionView.reloadData()
            }
        }
    }
    
    func imageProcessingReport(
        diffTime: Double,
        completion: (Result<Double, ImageProcessingTimeOut>) -> Void
    ) {
        let controlTime = 2.5
        if diffTime > controlTime {
            completion(.failure(.tooSlow))
            return
        } else {
            completion(.success(diffTime))
        }
    }
}

//  результаты измерений времени применения фильтра .noir
//  qos: .userInteractive 2.4, 2.16 -  3 threads
//  qos: .userInitiated 2.37, 2.11 - 4 threads
//  qos: .utility 2.7, 2.5 - 3 threads
//  qos: .background 11.9, 10.14 - 3 threads
//  qos: .default 2.54, 2.15 - 4 threads

//  результаты ручных измерений с момента перехода на экран до появления обработанных изображений (почему так с потоками - непонятно)
//  qos: .userInteractive 2.80 - 10 threads
//  qos: .userInitiated 2.95 - 10 threads
//  qos: .utility 3.25 - 11 threads
//  qos: .background 13.70 - 3 threads
//  qos: .default 2.4, 2.13  - 4 threads



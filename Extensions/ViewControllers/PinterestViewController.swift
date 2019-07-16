//
//  PinterestViewController.swift
//  Extensions
//
//  Created by Mohamed El Hanafi on 7/16/19.
//  Copyright © 2019 Mohamed El Hanafi. All rights reserved.
//

import UIKit

class PinterestViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var photos: [UIImage] = []
    private let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        self.collectionView.dataSource = self
        
        // Set the PinterestLayout delegate
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        
        loadPhotos()
    }
    func loadPhotos(){
        for i in 0..<6 {
            photos.append(UIImage(named: String(format: "%d", i))!)
        }
    }
    @IBAction func closeAction(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
extension PinterestViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        if let annotateCell = cell as? MyCollectionViewCell {
            annotateCell.cellImageView.image = photos[indexPath.item]
        }
        return cell
    }
}

extension PinterestViewController : PinterestLayoutDelegate {
    
    // Returns the photo height
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        return photos[indexPath.item].size.height
    }
    
}

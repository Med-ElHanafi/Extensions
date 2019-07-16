//
//  ViewController.swift
//  Extensions
//
//  Created by Mohamed El Hanafi on 7/16/19.
//  Copyright © 2019 Mohamed El Hanafi. All rights reserved.
//

import UIKit
import myExtensions

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var middleContainerView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var containerView: UIView!
    
    private let cellId = "cellId"
    
    var photos: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.collectionView.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        loadPhotos()
    }

    func loadPhotos(){
        for i in 0..<6 {
            photos.append(UIImage(named: String(format: "%d", i))!)
        }
    }

    override func viewDidLayoutSubviews() {
        
        followButton.addGradientLayerToView(colors: [UIColor.custom.pinkColor.cgColor,UIColor.purple.cgColor])
        profileImageView.roundedView()
        imageContainer.roundViewWithShadow()
        
        containerView.roundViewWithShadow(offset: CGSize(width: 0, height: 5))
    }
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PinterestViewController")
        self.present(vc, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MyCollectionViewCell
        
        cell.cellImageView.image = photos[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
}
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize: CGFloat = collectionView.frame.size.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}

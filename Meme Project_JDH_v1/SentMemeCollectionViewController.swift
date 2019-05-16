//
//  SentMemeCollectionViewController.swift
//  Meme Project_JDH_v2.1
//
//  Created by Do Hyung Joo on 4/5/19.
//  Copyright © 2019 Do Hyung Joo. All rights reserved.
//

import UIKit
import Photos

// MARK: - UICollectionViewController
class SentMemeCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    @IBAction func openmeme(_ sender: Any) {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorView") as! MemeEditorViewController
        
        self.present(controller, animated: true, completion: nil)
    }
    
    // MARK: Properties
    
    // Get ahold of some villains, for the table
    // This is an array of Villain instances.
    
    var meme: [Memes]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 2.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        let vertical = (view.frame.size.height - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space * 2.0
        flowLayout.itemSize = CGSize(width: dimension, height: vertical)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        collectionView.reloadData()
    }
    
    
     // MARK: Collection View Data Source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.meme.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Meme", for: indexPath) as! SentMemeCollectionViewCell
        let memeForItem = self.meme[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.DetailImageView?.image = memeForItem.memedImage
        
        return cell

    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        detailController.meme = self.meme[(indexPath as NSIndexPath).row]
        
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    
}



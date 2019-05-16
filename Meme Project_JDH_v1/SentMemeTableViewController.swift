//
//  SentMemeTableViewController.swift
//  Meme Project_JDH_v2.1
//
//  Created by Do Hyung Joo on 25/4/19.
//  Copyright © 2019 Do Hyung Joo. All rights reserved.
//

import UIKit
import Photos

// MARK: - UITableViewDelegate, UITableViewDataSource
class SentMemeTableViewController: UITableViewController {
    
    var meme: [Memes]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    @IBAction func openmeme(_ sender: Any) {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorView") as! MemeEditorViewController
        
        self.present(controller, animated: true, completion: nil)
    }

    
    // MARK: - Table view data source
    
       @IBOutlet var memeTable: UITableView!
    

    

// UITableViewDelegate, UITableViewDataSource methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeTable.reloadData()

    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.meme.count
    
}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Meme")! as! SentMemeTableViewCell
    let memeForRow = self.meme[(indexPath as NSIndexPath).row]

    // Set the name and image
    cell.tableUILabel?.text = memeForRow.topText + memeForRow.bottomText
    cell.tableViewCell?.image = memeForRow.memedImage
    
    return cell
}

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
    
    detailController.meme = self.meme[(indexPath as NSIndexPath).row]
    
    self.navigationController!.pushViewController(detailController, animated: true)
    
    }
    
}



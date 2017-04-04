//
//  SentMemeTableViewController.swift
//  MemeMe
//
//  Created by Boxuan Zhang on 4/1/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UITableViewController {

    var dataStore: MemeDataStoreProtocol = MemeoryMemeDataStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.numberOfMemes
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemeTableViewCell.cellIdentifier, for: indexPath)
       
        let meme = dataStore.meme(at: indexPath.row)
        (cell as? MemeTableViewCell)?.configure(with: meme)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            let meme = dataStore.meme(at: indexPath.row)
            dataStore.remove(meme: meme)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default: break
        }
        
    }
}

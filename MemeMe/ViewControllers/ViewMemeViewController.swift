//
//  ViewMemeViewController.swift
//  MemeMe
//
//  Created by Boxuan Zhang on 4/26/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import UIKit

class ViewMemeViewController: UIViewController {

    static func initFromStoryboard(meme: Meme) -> ViewMemeViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ViewMemeViewController")
            as? ViewMemeViewController else {
                fatalError()
        }
        
        vc.meme = meme
        
        return vc
    }
    
    @IBOutlet weak var memeImageView: UIImageView!
   
    var meme: Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        memeImageView.image = meme?.memedImage
    }

    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "editMeme", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "editMeme"?:
            let naviVC = segue.destination as? UINavigationController
            let vc = naviVC?.viewControllers.first as? MemeEditorViewController
            vc?.memeToEdit = meme
        default: break
        }
    }
}

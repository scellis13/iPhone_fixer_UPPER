//
//  ViewController.swift
//  iPhone_Fixer_UPPER
//
//  Created by JPL-ST-SPRING2021 on 4/18/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gif_loadview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        gif_loadview.loadGif(name: "background_gif_large")
    }

    

}


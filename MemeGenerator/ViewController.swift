//
//  ViewController.swift
//  MemeGenerator
//
//  Created by Dmitry Reshetnik on 05.06.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importImage))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareImage))
    }

    @IBAction func setTopText(_ sender: UIButton) {
    }
    
    @IBAction func setBottomText(_ sender: UIButton) {
    }
    
    @objc func importImage() {
        
    }
    
    @objc func shareImage() {
        
    }
}


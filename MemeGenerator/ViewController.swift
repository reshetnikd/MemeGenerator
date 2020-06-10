//
//  ViewController.swift
//  MemeGenerator
//
//  Created by Dmitry Reshetnik on 05.06.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextButton: UIButton!
    @IBOutlet weak var bottomTextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importImage))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareImage))
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            let attributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: 36)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]

            let string = "Press \"+\" to add an image"
            string.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        }
        
        imageView.image = image
        topTextButton.isEnabled = false
        bottomTextButton.isEnabled = false
        navigationItem.leftBarButtonItem?.isEnabled = false
    }

    @IBAction func setTopText(_ sender: UIButton) {
        let ac = UIAlertController(title: "Enter top text", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0]
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: self.imageView.image!.size.width, height: self.imageView.image!.size.height + 50))
            let image = renderer.image { ctx in
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center

                let attributes = [
                    NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: 36)!,
                    NSAttributedString.Key.paragraphStyle: paragraphStyle,
                    NSAttributedString.Key.backgroundColor: UIColor.black,
                    NSAttributedString.Key.foregroundColor: UIColor.white
                ]

                let string = answer.text!
                string.draw(with: CGRect(x: 0, y: 0, width: self.imageView.image!.size.width, height: 50), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                self.imageView.image!.draw(at: CGPoint(x: 0, y: 50))
            }
            
            self.imageView.image = image
        }

        ac.addAction(submitAction)

        present(ac, animated: true)
    }
    
    @IBAction func setBottomText(_ sender: UIButton) {
        let ac = UIAlertController(title: "Enter top text", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0]
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: self.imageView.image!.size.width, height: self.imageView.image!.size.height + 50))
            let image = renderer.image { ctx in
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center

                let attributes = [
                    NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: 36)!,
                    NSAttributedString.Key.paragraphStyle: paragraphStyle,
                    NSAttributedString.Key.backgroundColor: UIColor.black,
                    NSAttributedString.Key.foregroundColor: UIColor.white
                ]

                let string = answer.text!
                string.draw(with: CGRect(x: 0, y: self.imageView.image!.size.height, width: self.imageView.image!.size.width, height: 50), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                self.imageView.image!.draw(at: CGPoint(x: 0, y: 0))
            }
            
            self.imageView.image = image
        }

        ac.addAction(submitAction)

        present(ac, animated: true)
    }
    
    @objc func importImage() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func shareImage() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        imageView.image = image
        topTextButton.isEnabled = true
        bottomTextButton.isEnabled = true
        navigationItem.leftBarButtonItem?.isEnabled = true
        
        dismiss(animated: true)
    }
}


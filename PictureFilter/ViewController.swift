//
//  ViewController.swift
//  Picture
//
//  Created by Weicheng Cheng on 2/12/16.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        logAllFilters()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loadPhoto(sender: AnyObject) {
        let pickerC = UIImagePickerController()
        pickerC.delegate = self
        pickerC.sourceType = .PhotoLibrary
        self.presentViewController(pickerC, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in})
        
        imageView!.image = image
    }
    
    
    @IBAction func applyFilter(sender: AnyObject) {
        // 1
        let originalImage = CIImage(image: imageView.image!)
        let originalScale = imageView.image!.scale
        let originalOrientation = imageView.image!.imageOrientation
        
        // 2
        // let filter = CIFilter(name: "CIPhotoEffectMono")
        let filter = CIFilter(name: "CISepiaTone")
        
        filter!.setDefaults()
        filter!.setValue(originalImage, forKey: kCIInputImageKey)
        
        // 3
        let outputImage = filter!.outputImage
        
        let context = CIContext(options: nil)
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newImage = UIImage(CGImage: cgimg, scale:originalScale, orientation:originalOrientation)
        
        imageView!.image = newImage
    }
    
    @IBAction func takePhoto(sender: AnyObject) {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            let pickerC = UIImagePickerController()
        
            pickerC.delegate = self
        
            pickerC.sourceType = UIImagePickerControllerSourceType.Camera
        
            self.presentViewController(pickerC, animated: true, completion: nil)
        }
    }
    
    func logAllFilters() {
        let properties = CIFilter.filterNamesInCategory(kCICategoryBuiltIn)
        print(properties)
        
        for filterName: AnyObject in properties {
            let fltr = CIFilter(name:filterName as! String)
            print(fltr?.attributes)
        }
    }
}
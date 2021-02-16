//
//  ViewController.swift
//  IsRight?(CoreML)
//
//  Created by 홍진석 on 2021/01/29.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var hotdogLabel: UILabel!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hotdogLabel.isHidden = true
        imagePicker.delegate = self
        
        //imagePicker.sourceType = .camera
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickimage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView.image = pickimage
            
            guard let ciImage = CIImage(image: pickimage) else{
                fatalError("can't convert CIImage")
            }
            
            detect(image: ciImage)
            
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cameraPressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func detect(image : CIImage){
                
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else{
            fatalError("model failed")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else{
                fatalError("result failed")
            }
            
            if let firstResult = results.first{
                if firstResult.identifier.contains("hotdog"){
                    self.hotdogLabel.isHidden = false
                    self.hotdogLabel.text = "Yes Hotdog"
                    self.hotdogLabel.backgroundColor = UIColor.green
                }else{
                    self.hotdogLabel.isHidden = false
                    self.hotdogLabel.text = "NO Hotdog"
                    self.hotdogLabel.backgroundColor = UIColor.red
                }
            }
            print(results)
        }
        let handler = VNImageRequestHandler(ciImage : image)
        
        do{
            try handler.perform([request])
        }catch{
            print(error)
        }
    }
}


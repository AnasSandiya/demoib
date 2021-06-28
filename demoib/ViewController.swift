//
//  ViewController.swift
//  demoib
//
//  Created by pc link on 28/06/2021.
//

import UIKit

extension UIImageView {
  public func maskCircle(anyImage: UIImage) {
    self.contentMode = UIView.ContentMode.scaleAspectFit
    self.layer.cornerRadius = self.frame.height / 2
    self.layer.masksToBounds = false
    self.clipsToBounds = true

   // make square(* must to make circle),
   // resize(reduce the kilobyte) and
   // fix rotation.
   self.image = anyImage
  }
}

    class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {

    
    @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var editImageView: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let anyAvatarImage:UIImage = UIImage(systemName: "person")!
        self.imageView.maskCircle(anyImage: anyAvatarImage)
        
        let editImage:UIImage = UIImage(systemName: "pencil.circle")!
        self.editImageView.maskCircle(anyImage: editImage)
        
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
          imageView.isUserInteractionEnabled = true
          imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView

        self.showAlert()
        // Your action
    }
    
    
    
    private func showAlert() {

           let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
           alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
               self.getImage(fromSourceType: .camera)
           }))
           alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
               self.getImage(fromSourceType: .photoLibrary)
           }))
           alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }

       //get image from source type
       private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {

           //Check is source type available
           if UIImagePickerController.isSourceTypeAvailable(sourceType) {

               let imagePickerController = UIImagePickerController()
               imagePickerController.delegate = self
               imagePickerController.sourceType = sourceType
               self.present(imagePickerController, animated: true, completion: nil)
           }
       }

       //MARK:- UIImagePickerViewDelegate.
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

           self.dismiss(animated: true) { [weak self] in

               guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
               //Setting image to your image view
               self?.imageView.image = image
           }
       }

       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }

    
    
    
    
    


}


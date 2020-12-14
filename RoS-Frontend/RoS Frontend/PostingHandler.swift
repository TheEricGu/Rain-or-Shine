//
//  PostingHandler.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/13/20.
//

import Foundation
import UIKit
import MobileCoreServices
import AVFoundation
import Photos

// how to test if camera puts image user takes into vc??

class PostingHandler: NSObject{
    static let shared = PostingHandler()
    fileprivate var currentVC: UIViewController?
    
    //MARK: - Internal Properties
    var imagePickedBlock: ((UIImage) -> Void)?
    
    enum AttachmentType: String {
        case camera, photoLibrary
    }

struct PostingConstants {
     static let actionFileTypeHeading = "Add a Post"
     static let actionFileTypeDescription = "Choose a filetype to add..."
     static let camera = "Camera"
     static let phoneLibrary = "Photo Library"
     
     static let alertForPhotoLibraryMessage = "App does not have access to your photos. To enable access, tap settings and turn on Photo Library Access."
     
     static let alertForCameraAccessMessage = "App does not have access to your camera. To enable access, tap settings and turn on Camera."
     
     static let settingsBtnTitle = "Settings"
     static let cancelBtnTitle = "Cancel"
         
     }
    
    //MARK: - showAttachmentActionSheet
    // This function is used to show the attachment sheet for image, photo.
    func showPostingActionSheet(vc: UIViewController) {
        currentVC = vc
        let actionSheet = UIAlertController(title: PostingConstants.actionFileTypeHeading, message: PostingConstants.actionFileTypeDescription, preferredStyle: .actionSheet)
        
        // camera
        actionSheet.addAction(UIAlertAction(title: PostingConstants.camera, style: .default, handler: { (action) -> Void in
            self.authorisationStatus(attachmentTypeEnum: .camera, vc: self.currentVC!)
        }))
        
        // photo library
        actionSheet.addAction(UIAlertAction(title: PostingConstants.phoneLibrary, style: .default, handler: { (action) -> Void in
            self.authorisationStatus(attachmentTypeEnum: .photoLibrary, vc: self.currentVC!)
        }))
        
        actionSheet.addAction(UIAlertAction(title: PostingConstants.cancelBtnTitle, style: .cancel, handler: nil))
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
    //MARK: - Authorisation Status
    // This is used to check the authorisation status whether user gives access to import the image, photo library.
    // if the user gives access, then we can import the data safely
    // if not show them alert to access from settings.
    func authorisationStatus(attachmentTypeEnum: AttachmentType, vc: UIViewController){
        currentVC = vc
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            if attachmentTypeEnum == AttachmentType.camera{
                openCamera()
            }
            if attachmentTypeEnum == AttachmentType.photoLibrary{
                photoLibrary()
            }
        case .denied:
            print("permission denied")
            self.addAlertForSettings(attachmentTypeEnum)
        case .notDetermined:
            print("Permission Not Determined")
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == PHAuthorizationStatus.authorized{
                    // photo library access given
                    print("access given")
                    if attachmentTypeEnum == AttachmentType.camera{
                        self.openCamera()
                    }
                    if attachmentTypeEnum == AttachmentType.photoLibrary{
                        self.photoLibrary()
                    }
                }else{
                    print("restriced manually")
                    self.addAlertForSettings(attachmentTypeEnum)
                }
            })
        case .restricted:
            print("permission restricted")
            self.addAlertForSettings(attachmentTypeEnum)
        default:
            break
        }
    }
    
    //MARK: - CAMERA PICKER
    //This function is used to open camera from the iphone
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .camera
            currentVC?.present(myPickerController, animated: true, completion: nil)
        }
    }

    //MARK: - PHOTO PICKER
    func photoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            currentVC?.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    //MARK: - SETTINGS ALERT
    func addAlertForSettings(_ attachmentTypeEnum: AttachmentType){
        var alertTitle: String = ""
        if attachmentTypeEnum == AttachmentType.camera{
            alertTitle = PostingConstants.alertForCameraAccessMessage
        }
        if attachmentTypeEnum == AttachmentType.photoLibrary{
            alertTitle = PostingConstants.alertForPhotoLibraryMessage
        }
        
        let cameraUnavailableAlertController = UIAlertController (title: alertTitle , message: nil, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: PostingConstants.settingsBtnTitle, style: .destructive) { (_) -> Void in
            let settingsUrl = NSURL(string:UIApplication.openSettingsURLString)
            if let url = settingsUrl {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: PostingConstants.cancelBtnTitle, style: .default, handler: nil)
        cameraUnavailableAlertController .addAction(cancelAction)
        cameraUnavailableAlertController .addAction(settingsAction)
        currentVC?.present(cameraUnavailableAlertController , animated: true, completion: nil)
    }
}

//MARK: - IMAGE PICKER DELEGATE
// This is responsible for image picker interface to access image and then responsible for canceling the picker
extension PostingHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            self.imagePickedBlock?(image)
            
        } else{
            print("Something went wrong in image")
        }
        currentVC?.dismiss(animated: true, completion: nil)
        //pull up posting vc and put image into it
        let pickedImage = (info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage)!
        let postingViewController = PostingViewController(delegate: self, image: pickedImage)
        currentVC?.present(postingViewController, animated: true, completion: nil)
    }
}

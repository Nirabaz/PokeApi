//
//  SELBaseVC.swift
//  listUps
//
//  Created by Sergii Lyahovchuk on 14.12.2017.
//  Copyright © 2017 Selecto. All rights reserved.
//

import UIKit
import SafariServices

class BaseVC: UIViewController {

    //MARK: - Inside Variables
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var additionalSectionsAtStart: Int = 0
    var onDissmissCompletion: void_block?
    var bgndTapGestureRecognizer: UITapGestureRecognizer?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
//        swipeLeft.direction = UISwipeGestureRecognizerDirection.right
//        self.view.addGestureRecognizer(swipeLeft)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializeBgndTapGestureRecognizer()
        listenNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotifications()
        removeBgndTapGestureRecognizer()
        view.endEditing(true)
    }
    
    //MARK: - Private
    
    @objc func respondToSwipeGesture()
    {
        onBtnBack(UIButton())
    }
    func listenNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func removeNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        notificationCenter.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    //MARK: - IBActions
    
    @IBAction func onBtnBack(_ sender: Any) {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: onDissmissCompletion)
        }
    }
    
    // MARK: - NSNotifications
    
    @objc func keyboardWillHide(notification: NSNotification) {
        //override in child class
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        //override in child class
    }

}

extension BaseVC {
    
    func initializeBgndTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBgndTap(aRecognizer:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        bgndTapGestureRecognizer = tapGesture
    }
    
    func removeBgndTapGestureRecognizer() {
        if let tapGesture = bgndTapGestureRecognizer {
            view.removeGestureRecognizer(tapGesture)
        }
    }
    
    @objc func handleBgndTap(aRecognizer: UITapGestureRecognizer) {
        let rView = aRecognizer.view
        let location = aRecognizer.location(in: rView)
        let viewOfTouch = rView?.hitTest(location, with: nil)
        
        if !(viewOfTouch is UIButton) {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else {return}
                strongSelf.view.endEditing(true)
            }
        }
        
        print("Handle tap in: \(self)")
    }
}

extension BaseVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.isSecureTextEntry) {
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            
            if (range.location > 0 && range.length == 1 && string.count == 0) {
                // iOS is trying to delete the entire string
                textField.text = newString
                return false
            }
            
//             prevent typing clearing the pass
            if range.location == textField.text?.count {
                textField.text = newString
                return false
            }
        }
        
        return true
    }
}
extension BaseVC: UINavigationControllerDelegate {
    
}
extension BaseVC: UIGestureRecognizerDelegate {
    
}
extension BaseVC: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController)
    {
        controller.dismiss(animated: true, completion: nil)
    }
}

//
//  NewListViewController.swift
//  CookingApp
//
//  Created by Hannes on 01.03.17.
//  Copyright © 2017 Eva Jobst. All rights reserved.
//

import UIKit

class NewListViewController: UIViewController {
    let keys = ObserverKeyManager()
    let entities = EntityManager()

    @IBOutlet weak var NewListName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hideKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }

    
    @IBAction func saveAction(_ sender: Any) {
        entities.listManager.set(listID: Int16(entities.lists.count), count: 0, name: NewListName.text!)
        NotificationCenter.default.post(name: Notification.Name(rawValue: (self.keys.newList)), object: self)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

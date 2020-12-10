//
//  DetailsViewController.swift
//  RestDownload
//
//  Created by Vanessa Primetzhofer on 03.12.20.
//  Copyright © 2020 Vanessa Primetzhofer. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var todoTitle: UITextField!
    @IBOutlet weak var check: UIButton!
    
    var todo:ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        id.text = "ID: \(todo!.id)"
        userId.text = "UserID: \(todo!.userId)"
        
        todoTitle.text = todo?.title
        
        let completed = todo?.completed
        
        if completed! {
            check.setImage(UIImage(named:"Checkmark"), for: .normal)
         }else{
            check.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
        }
    }
    
    @IBAction func oncick(_ sender: Any) {
        
        let completed = todo?.completed
        
        if completed!{
            check.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
            todo?.completed = false
        }else{
            check.setImage(UIImage(named:"Checkmark"), for: .normal)
            todo?.completed = true
        }
    }
    
    @IBAction func send(_ sender: Any) {
        
        let completed = todo?.completed
        
        print("Die Person mit der ID \(todo?.userId) hat den Todo mid der ID \(todo?.id) und dem Text: \(todoTitle.text!), geändert")
        
        print("\(completed!)")
        
    }
    
    
}

//
//  TodoViewController.swift
//  TodoListApp
//
//  Created by Justice Ekeke on 28/11/2021.
//

import UIKit
import FirebaseDatabase

protocol TodoViewControllerDelegate: AnyObject
{
  func todoViewController(_ vc: TodoViewController, didSaveTodo todo: Todo)
}

class TodoViewController: UIViewController
{
    private let database = Database.database().reference()

    @IBOutlet weak var textfield: UITextField!
    var todo: Todo?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //datePicker.dateFormat = "yyyy/MM/dd"
    
    //private var datePicker: UIDatePicker?
    
    
    @IBOutlet weak var hasDuedate: UISwitch!
    
    weak var delegate: TodoViewControllerDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //
    @IBAction func save(_ sender: Any)
    {
        let todo = Todo(title: textfield.text!, dueDate: datePicker.date)
        database.child(textfield.text!).setValue(hasDuedate.isOn)
        
        delegate?.todoViewController(self, didSaveTodo: todo)
    }
    
}

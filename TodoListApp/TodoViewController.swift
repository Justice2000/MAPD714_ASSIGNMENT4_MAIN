//
//  TodoViewController.swift
//  TodoListApp
//
//  Created by Justice Ekeke on 28/11/2021.
//

import UIKit

protocol TodoViewControllerDelegate: AnyObject
{
  func todoViewController(_ vc: TodoViewController, didSaveTodo todo: Todo)
}

class TodoViewController: UIViewController
{

    @IBOutlet weak var textfield: UITextField!
    var todo: Todo?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //datePicker.dateFormat = "yyyy/MM/dd"
    
    @IBOutlet weak var hasDuedate: UISwitch!
    
    weak var delegate: TodoViewControllerDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    @IBAction func save(_ sender: Any)
    {
        let todo = Todo(title: textfield.text!)//, dueDate: datePicker.date)
        delegate?.todoViewController(self, didSaveTodo: todo)
    }
    
}

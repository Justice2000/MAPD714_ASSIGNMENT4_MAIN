/*
 *Program Name: Todo List App
 *Date Last Modified: 13/11/2021
 *Description: A simple Todo list app to add, edit and delete basic tasks.
 *Revision History: Added navigation controls as well fixed build and run error.
 *Author: Justice Ekeke
 *Student ID: 301160908
 *Date: November 13, 2021
 *
 *Author: Shrijan Karki
 *Student ID: 301222636
 *Date: November 13, 2021
 *
 *Author: Basil Farooq
 *Student ID: 301201128
 *Date: November 13, 2021
 *
 */

import UIKit


class ViewController: UIViewController, UITableViewDataSource
{
    
    
    //temporary todo list Datasource
    var todos =
    [
        Todo(title: "Clean bag"),
        Todo(title: "clean room" ),
        Todo(title: "Buy groceries")
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //link newtodo list item to main viewController
    @IBSegueAction func todoViewcontroller(_ coder: NSCoder) -> TodoViewController?
    {
        let vc = TodoViewController(coder: coder)
        
        vc?.delegate = self
        
        return vc
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return todos.count
           
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
           
           let cell = tableView.dequeueReusableCell(withIdentifier: "checked cell", for: indexPath) as! CheckTableViewCell
        
            cell.delegate = self
           
           let todo = todos[indexPath.row]
           
           cell.set(title: todo.title, checked: todo.isComplete)
           
           return cell
    }
    
    //swipe delete function connected to swipe delegate function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //deletes data along with row in list
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
       

}

extension ViewController: UITableViewDelegate
{
    //swipe complete function
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Complete"){ action, view, complete in
            
            let todo = self.todos[indexPath.row].completToggled()
            self.todos[indexPath.row] = todo
            
            let cell = tableView.cellForRow(at: indexPath) as! CheckTableViewCell
            cell.set(checked: todo.isComplete)
                  
            complete(true)
                  
            
            print("complete")
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    //swipe delete fuction
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    {
        return .delete
    }
    
}

extension ViewController: CheckTableViewCellDelegate
{
    func checkTableViewCell(_ cell: CheckTableViewCell, didChangeCheckedState checked: Bool )
    {
        guard let indexPath =  tableView.indexPath(for: cell) else{
            return
        }
        let todo = todos[indexPath.row]
        let newTodo = Todo(title: todo.title, /*dueDate: todo.dueDate,*/ isComplete: checked)
        
        todos[indexPath.row] = newTodo
    }
}

extension ViewController: TodoViewControllerDelegate
{
    func todoViewController(_ vc: TodoViewController, didSaveTodo todo: Todo)
    {
        
        dismiss(animated: true)
        {
            self.todos.append(todo)
            self.tableView.insertRows(at: [IndexPath(row: self.todos.count-1, section: 0)], with: .automatic)
        }
    }
}

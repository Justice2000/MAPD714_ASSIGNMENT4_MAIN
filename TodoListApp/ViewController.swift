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
        Todo(title: "Clean bag", dueDate: Date()),
        Todo(title: "clean room", dueDate: Date()),
        Todo(title: "Buy groceries", dueDate: Date())
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
    
    @IBSegueAction func editViewcontroller(_ coder: NSCoder) -> SecondScreenViewController?
    {
        return SecondScreenViewController(coder: coder)
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
       

}

extension ViewController: UITableViewDelegate
{
    //Edit swipe function from leading
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let editAction = UIContextualAction(style: .normal, title: "Edit")
        {
            action, view, edit in
            
            let editProfilePage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "editscreen") as! SecondScreenViewController
            [22:38]
            
            let transition:CATransition = CATransition()
                    transition.duration = 0.5
                    transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                    transition.type = .push
                    transition.subtype = .fromLeft

            //adding transition to navigation controller
            self.navigationController?.view.layer.add(transition, forKey: kCATransition)
            
            self.navigationController?.pushViewController(editProfilePage, animated: true)

        }

        editAction.backgroundColor = .systemBlue

        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    
    
    //swipe custom functions for complete and delete
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let completeAction = UITableViewRowAction(style: .normal, title: "Complete")
        {
            view, complete in
            
            let todo = self.todos[indexPath.row].completToggled()
            self.todos[indexPath.row] = todo
            
            let cell = tableView.cellForRow(at: indexPath) as! CheckTableViewCell
            cell.set(checked: todo.isComplete)
            
        }
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete")
        {
            view, delete in
            //deletes data along with row in list
            self.todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
        completeAction.backgroundColor = .systemYellow
        
        return [deleteAction,completeAction]
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
        let newTodo = Todo(title: todo.title, dueDate: todo.dueDate, isComplete: checked)
        
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

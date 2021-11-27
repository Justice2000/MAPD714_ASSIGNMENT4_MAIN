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
    
    var todos =
    [
        Todo(title: "Name of the people that i would like to see eat fish in a shopping store like"),
        Todo(title: "Name2"),
        Todo(title: "Name3")
        
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
}

extension ViewController: CheckTableViewCellDelegate
{
    func checkTableViewCell(_ cell: CheckTableViewCell, didChangeCheckedState checked: Bool )
    {
        guard let indexPath =  tableView.indexPath(for: cell) else{
            return
        }
        let todo = todos[indexPath.row]
        let newTodo = Todo(title: todo.title, isComplete: checked)
        
        todos[indexPath.row] = newTodo
    }
}


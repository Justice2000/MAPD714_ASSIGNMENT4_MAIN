//
//  ViewController.swift
//  TodoListApp
//
//  Created by Justice Ekeke on 12/11/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource
{
    
    let todos =
    [
        Todo(title: "Name1"),
        Todo(title: "Name2"),
        Todo(title: "Name3")
        
    ]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todos.count
           
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cell = tableView.dequeueReusableCell(withIdentifier: "checked cell", for: indexPath) as! CheckTableViewCell
           
           let todo = todos[indexPath.row]
           
           cell.set(title: todo.title, checked: todo.isComplete)
           
           return cell
       }
       

}


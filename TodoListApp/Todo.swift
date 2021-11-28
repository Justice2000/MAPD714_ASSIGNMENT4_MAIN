//
//  Todo.swift
//  TodoListApp
//
//  Created by Justice Ekeke on 12/11/2021.
//

import Foundation

struct Todo
{
    let title: String
    let isComplete: Bool
    //let dueDate: Date
    let hasDuedate: Bool
    
    init(title: String, /*dueDate: Date,*/ isComplete: Bool = false, hasDuedate: Bool = false)
    {
        self.title = title
        self.isComplete = isComplete
        self.hasDuedate = hasDuedate
        //self.dueDate = dueDate
    }
    
    func completToggled() -> Todo
    {
        return Todo(title: title, /*dueDate: dueDate,*/ isComplete: !isComplete, hasDuedate: !hasDuedate)
    }
}

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
    
    init(title: String, isComplete: Bool = false)
    {
        self.title = title
        self.isComplete = isComplete
    }
    
    func completToggled() -> Todo {
        return Todo(title: title, isComplete: !isComplete)
    }
}

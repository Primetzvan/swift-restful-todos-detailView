//
//  Model.swift
//  RestDownload
//
//  Created by Vanessa Primetzhofer on 16.11.20.
//  Copyright © 2020 Vanessa Primetzhofer. All rights reserved.
//
class ToDo {
    var id = 0
    var userId = 0
    var title = ""
    var completed = false
}

class Model{
    var todos = [ToDo]()
    var currentTodo:ToDo?
}

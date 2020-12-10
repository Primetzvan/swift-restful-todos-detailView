//
//  ViewController.swift
//  RestDownload
//
//  Created by Vanessa Primetzhofer on 15.11.20.
//  Copyright © 2020 Vanessa Primetzhofer. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    let queue = DispatchQueue(label: "queue1")
    var model = Model()
    let urlString = "http://localhost:3000/todos"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        queue.async {
            self.download()
        }
        
        urlRequestDownload()
    
    }
    
    func download() {
        let model = Model()
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    if let array = json as? [Any] {
                        for obj in array {
                            if let dict = obj as? [String: Any] {
                                
                                let todo = ToDo()
                                
                                todo.title = dict["title"] as! String
                                todo.id = dict["id"] as! Int
                                todo.userId = dict["userId"] as! Int
                                todo.completed = dict["completed"] as! Bool
                                
                                model.todos.append(todo)
                                
                            }
                        }
                        DispatchQueue.main.async {
                            print("title downloaded:\(model)")
                            self.model = model
                            //todo: tableView.reload Data...
                            self.tableView.reloadData()
                        }
                    }
                }
            } else {
                print("failed to download")
            }
        } else {
            print("sinnlose URL")
        }
        
    }
    
    func urlRequestDownload(){
        let todomodel = Model()
        
        if let url = URL(string: urlString){
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                print("loaded \(data)")

                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) {
                    if let array = json as? [Any] {
                        for obj in array {
                            if let dict = obj as? [String: Any] {
                                
                                let todo = ToDo()
                                
                                todo.title = dict["title"] as! String
                                todo.id = dict["id"] as! Int
                                todo.userId = dict["userId"] as! Int
                                todo.completed = dict["completed"] as! Bool
                                
                                todomodel.todos.append(todo)
                                
                            }
                        }

                        DispatchQueue.main.async {
                            print("title downloaded:\(todomodel)")
                            self.model = todomodel
                            //todo: tableView.reload Data...
                            self.tableView.reloadData()
                        }
                        
                    }
                }
                
            }
            
            task.resume()
                
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.todos.count
    }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "elementsview", for: indexPath) as! TableViewCell
        let element = model.todos[indexPath.row]
    
            // Do this
    
            cell1.detailTextLabel?.text = "\(element.title)"
            cell1.textLabel?.text = "ID: \(element.id) UserID: \(element.userId)"
            //cell.button.setTitle("\(element.userId)", for: .normal)
    
    
            if element.completed{
                cell1.button.setImage(UIImage(named:"Checkmark"), for: .normal)
            }else{
                cell1.button.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
            }
    
        cell1.todo = element
    
        return cell1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected cell \(indexPath.row)")
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        print("title: \(cell.todo!.title)")
        model.currentTodo = model.todos[indexPath.row]
        performSegue(withIdentifier: "detail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let todo = model.currentTodo{
            if let detailsViewController = segue.destination as? DetailsViewController{
                detailsViewController.todo = todo
            }
        }
    }
    
}


//
//  ViewController.swift
//  taskApp
//
//  Created by RYUTARO OKAMOTO on 2019/04/20.
//  Copyright © 2019 RYUTARO OKAMOTO. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }
    //
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:
            indexPath)
        return cell
    }
    //cellをtapした時に行われるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "cellSegue", sender: nil)
    }
    //cellが削除可能を伝えるメソッド
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)->        UITableViewCell.EditingStyle{
    return .delete
    }
    //deleteを押した時に出る
    func tableView(_ tableView: UITableView, commit eddingStyle: UITableViewCell.EditingStyle, forRowAt IndexPath: IndexPath){
        
    }
 
    
    

}


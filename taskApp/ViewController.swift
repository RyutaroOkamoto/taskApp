//
//  ViewController.swift
//  taskApp
//
//  Created by RYUTARO OKAMOTO on 2019/04/20.
//  Copyright © 2019 RYUTARO OKAMOTO. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    let realm = try! Realm()
    
    var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath:"date",ascending: false)
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.placeholder = "search"
        searchBar.setValue("cancel", forKey: "_cancelButtonText")
        searchBar.enablesReturnKeyAutomatically = false
        
    }
    //
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:
            indexPath)
        let task = taskArray[indexPath.row]
        cell.textLabel?.text = task.title
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString:String = formatter.string(from: task.date)
        cell.detailTextLabel?.text = dateString
        
        
        return cell
    }
    //cellをtapした時に行われるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "cellSegue", sender: nil)
    }
    //cellが削除可能を伝えるメソッド
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)->        UITableViewCell.EditingStyle{
    return.delete
    }
    //deleteを押した時に出る
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            let task = self.taskArray[indexPath.row]
            
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [String(task.id)])
            
            
            try! realm.write {
                self.realm.delete(self.taskArray[indexPath.row])
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            // 未通知のローカル通知一覧をログ出力
            center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
                for request in requests {
                    print("/---------------")
                    print(request)
                    print("---------------/")
                }
                
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let inputViewController:InputViewController = segue.destination as! InputViewController
        
        if segue.identifier == "cellSegue"{
        let indexPath = self.tableView.indexPathForSelectedRow
            inputViewController.task = taskArray[indexPath!.row]
    }else{
    let task = Task()
    task.date = Date()
    
    let allTasks = realm.objects(Task.self)
    if allTasks.count != 0{
    task.id = allTasks.max(ofProperty:"id")! + 1
    
    }
    inputViewController.task = task
    }
}
    //change tableview
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    //searchBar
    
    
    
        
        
    
            
    
        




    
        
    // 検索キータップ時に呼び出されるメソッド.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.resignFirstResponder()
        
        searchBar.setShowsCancelButton(false, animated: true)
        
        if (searchBar.text == "") {
            taskArray = try! Realm().objects(Task.self).sorted(byKeyPath:"date",ascending: false)
            tableView.reloadData()
            print("入力がありません")
        }else{
            let predicate = NSPredicate(format: "Category CONTAINS[c] %@",((searchBar.text)!))
            taskArray = realm.objects(Task.self).filter(predicate)
        tableView.reloadData()
            print("結果")
    }
    // キャンセルボタンタップ時に呼び出されるメソッド.
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    
}

    
    
    
    
    
    
    

}

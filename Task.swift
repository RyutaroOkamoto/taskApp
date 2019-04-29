//
//  Task.swift
//  
//
//  Created by RYUTARO OKAMOTO on 2019/04/22.
//

import Foundation

import RealmSwift

class Task: Object {
    //管理用ID プライマリーキー
    @objc dynamic var id = 0
    //タイトル
    @objc dynamic var title = ""
    //内容
    @objc dynamic var contents = ""
    //日時
    @objc dynamic var date = Date()
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

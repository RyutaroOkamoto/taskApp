//
//  Task.swift
//  taskApp
//
//  Created by RYUTARO OKAMOTO on 2019/04/22.
//  Copyright © 2019 RYUTARO OKAMOTO. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    //管理用ID
@objc dynamic var id = 0
//タイトル
@objc dynamic var title = ""
//内容
@objc dynamic var contents = ""
//日時
@objc dynamic var date = Date()
//カテゴリ
@objc dynamic var Category = ""

    override static func primaryKey() -> String?{
        return "id"
}
}



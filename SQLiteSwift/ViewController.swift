//
//  ViewController.swift
//  SQLiteSwift
//
//  Created by apple on 2017/9/11.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {
    
    var db:Connection! = nil
    
    let users = Table("user")
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let email = Expression<String>("email")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //获取沙盒路径 temp liability documents
        do{
            db = try Connection(NSHomeDirectory() + "/Documents/db.sqlite3")
            try db.run(users.create{ t in
                t.column(id,primaryKey:true)
                t.column(name)
                t.column(email)
            })
        }catch{
            print("数据库创建失败")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func insertAction(_ sender: AnyObject) {
        do{
            let insert = users.insert(id<-3,name<-"zsz",email<-"864849506@qq.com")
            try db.run(insert)
        }catch{
            print(error)
        }
    }

    @IBAction func deleteAction(_ sender: AnyObject) {
        let user = users.filter(id == 3)
        do {
            try db.run(user.delete())
        } catch {
            print(error)
        }
    }
    
    @IBAction func updateAction(_ sender: AnyObject) {
        let user = users.filter(id == 3)
        do {
            //可以直接改
            try db.run(user.update(name <- name.replace("111", with: "zzz")))
        } catch {
            print(error)
        }
    }
    
    @IBAction func seleteAction(_ sender: AnyObject) {
        do{
            
            for user in try db.prepare(users){
                print("id:\(user[id]),name:\(user[name]),email:\(user[email])")
            }
        }catch{
            print(error)
        }
    }
}


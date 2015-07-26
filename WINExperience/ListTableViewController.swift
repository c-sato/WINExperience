//
//  ListTableViewController.swift
//  sommelier
//
//  Created by Csato on 2015/02/08.
//  Copyright (c) 2015年 csatoap. All rights reserved.
//

import UIKit

//cellの色を変えるメソッドの拡張
extension UIColor {
    class func hexStr (var hexStr : NSString, var alpha : CGFloat) -> UIColor {
        hexStr = hexStr.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("invalid hex string")
            return UIColor.whiteColor();
        }
    }
}

class ListTableViewController: UITableViewController {
    
    // セクションの項目を作成する
    let sectionList: NSArray = ["練習問題","過去問"]
    
    // セルの項目を作成する
    let practice: NSArray = ["模擬試験","壁打ち"]
    let past: NSArray = ["平成２６年","平成２５年","平成２４年","平成２３年","平成２２年","平成２１年"]
    
    // セルの項目をまとめる
    //        let datas: NSArray = [peple, dogs, others]
    
    //        dataSource = [NSDictionary dictionaryWithObjects:datas forKeys:sectionList];
    //        let dataSource:NSDictionary =
    //        let dataSource = NSDictionary(objects: datas, forKeys: sectionList)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //余分な行を消す
        var v:UIView = UIView(frame: CGRectZero)
        v.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = v
        tableView.tableHeaderView = v
        //スクロール固定
        //        tableView.scrollEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return sectionList.count
    }
    
    //セクションのタイトルを返す
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionList[section] as? String
    }
    
    //セクションの色を変える
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UILabel {
        var sectionLabel: UILabel = UILabel()
        //背景色
        sectionLabel.backgroundColor = UIColor.hexStr("90576D", alpha: 1)
        //テキスト
        sectionLabel.textColor = UIColor.hexStr("FFFFFF", alpha: 1)
        //値設定
        sectionLabel.text = sectionList[section] as? String
        return sectionLabel
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        //セクション毎にセル数を返す
        if section == 0 {
            return practice.count
        } else if section == 1 {
            return past.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "LessonCell")
        
        //デフォルトでは画面遷移してしまうのでメソッド変更
        //let cell = tableView.dequeueReusableCellWithIdentifier("LessonCell", forIndexPath: indexPath) as UITableViewCell
        // Configure the cell...
        
        //セレクションごとに使用するセル値を返却
        if indexPath.section == 0 {
            cell.textLabel?.text = "\(practice[indexPath.row])"
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "\(past[indexPath.row])"
        }
        
        //背景色
        cell.backgroundColor = UIColor.hexStr("700029", alpha: 1)
        
        //テキスト
        cell.textLabel?.textColor = UIColor.hexStr("FFEE79", alpha: 1)
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //NSUserDefaultsのインスタンスを生成
        let ud = NSUserDefaults.standardUserDefaults()
        
        //"LessonName"というキーで配列namesをNSUserDefaultsへ保存
        if indexPath.section == 0 {
            ud.setObject(practice[indexPath.row], forKey:"LessonName")
        } else if indexPath.section == 1 {
            ud.setObject((past[indexPath.row]), forKey:"LessonName")
        }
        
        //問題ファイルの読み込み
        let path = NSBundle.mainBundle().pathForResource("QuestionList", ofType: "plist")!
        let data = NSDictionary(contentsOfFile: path)
        let QuestionList = data?.objectForKey("QuestionList") as! NSMutableArray

        //qidを取り出して問題の並べ替え
        var qid_org = getqid(QuestionList) as NSArray
        var qid_rnd = shuffleqid(getqid(QuestionList) as NSArray) as NSArray

        //que ans res 初期化
        var que: [String] = []
        var ans: [String] = []
        var res: [String] = []
        var pageno :String = "0"

        ud.setObject(que , forKey: "que")
        ud.setObject(ans , forKey: "ans")
        ud.setObject(res , forKey: "res")
        ud.setObject(pageno , forKey: "page")
        ud.setObject(data , forKey: "questiondata")
        ud.setObject(qid_org , forKey: "qid_org")
        ud.setObject(qid_rnd , forKey: "qid_rnd")

        //シンクロは入れたほうが良いとのこと
        ud.synchronize()

        // Storyboard segues identiferの値を指定
        self .performSegueWithIdentifier("selectRow", sender: self)
    }

    //qid取得
    func getqid(parray:NSMutableArray)->NSArray{
        var rarray:NSMutableArray = []
        for var i = 0; i < parray.count; i++ {
            rarray.addObject(parray[i].objectForKey("qid") as! String)
        }
        return rarray
    }
    
    //qid並び替え
    func shuffleqid(parray:NSArray)->NSArray{
        let arrayCount = parray.count
        var parray2 = parray as! NSMutableArray
        var rarray:NSMutableArray = []
        for var i = 0; i < arrayCount; i++ {
            var randNum = Int(arc4random())%(arrayCount - i)
            rarray.addObject(parray[randNum])
            parray2.removeObjectAtIndex(randNum)
        }
        return rarray
    }

}

//
//  QuestionViewController.swift
//  sommelier
//
//  Created by Csato on 2015/02/02.
//  Copyright (c) 2015年 csatoap. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController {
    
    @IBOutlet weak var Lesson: UINavigationItem!
    @IBOutlet weak var anstext: UITextView!
    @IBOutlet weak var ansbutton1: UIButton!
    @IBOutlet weak var ansbutton2: UIButton!
    @IBOutlet weak var ansbutton3: UIButton!
    @IBOutlet weak var ansbutton4: UIButton!
    @IBOutlet weak var anslabel1: UILabel!
    @IBOutlet weak var anslabel2: UILabel!
    @IBOutlet weak var anslabel3: UILabel!
    @IBOutlet weak var anslabel4: UILabel!
    @IBOutlet weak var questiontext: UITextView!
    @IBOutlet weak var exitbutton: UIButton!
    @IBOutlet weak var nextbtn: UIButton!
    @IBOutlet weak var pagelabel1: UILabel!
    @IBOutlet weak var pagelabel2: UILabel!
    @IBOutlet weak var finishbutton: UIButton!

    //NSUserDefaultsのインスタンスを生成
    let ud = NSUserDefaults.standardUserDefaults()
    
    //変数定義
    var question :NSArray = []
    var que :[String] = []
    var ans :[String] = []
    var res :[String] = []
    var nextflg :String = "0"
    var pageno :String = ""
    var questiondata :NSMutableArray = []
    var qid_org :NSArray = []
    var qid_rnd :NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //test1
        //戻るボタンを常に"Back”表示
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: nil, action: nil)

        //①回答状態の取得
        que = ud.objectForKey("que") as! [String]!
        ans = ud.objectForKey("ans") as! [String]!
        res = ud.objectForKey("res") as! [String]!
        pageno = ud.stringForKey("page")!

        //問題取得
        var data: AnyObject? = ud.objectForKey("questiondata")
        questiondata = data!.objectForKey("QuestionList") as! NSMutableArray
        qid_org = ud.arrayForKey("qid_org")!
        qid_rnd = ud.arrayForKey("qid_rnd")!

        //②pagenoから問題番号を取得
        let qid_ind :Int = find(qid_org, qno: qid_rnd[pageno.toInt()!] as! String)!

        //表示する問題を設定する
        question = [
             (questiondata[qid_ind].objectForKey("qid") as! String)
            ,(questiondata[qid_ind].objectForKey("section") as! String)
            ,(questiondata[qid_ind].objectForKey("category") as! String)
            ,(questiondata[qid_ind].objectForKey("question") as! String)
            ,(questiondata[qid_ind].objectForKey("select1") as! String)
            ,(questiondata[qid_ind].objectForKey("select2") as! String)
            ,(questiondata[qid_ind].objectForKey("select3") as! String)
            ,(questiondata[qid_ind].objectForKey("select4") as! String)
            ,(questiondata[qid_ind].objectForKey("ans") as! String)
            ,(questiondata[qid_ind].objectForKey("resulte") as! String)
        ]

        //③画面表示項目の作成
        //NSUserDefaultsから値を取り出してタイトル設定
        Lesson.title = ud.stringForKey("LessonName")

        //編集仕様：画面のパーツへ問題を設定
        questiontext.text   = "\(question[3])"
        ansbutton1.setTitle("\(question[4])", forState: .Normal)
        ansbutton2.setTitle("\(question[5])", forState: .Normal)
        ansbutton3.setTitle("\(question[6])", forState: .Normal)
        ansbutton4.setTitle("\(question[7])", forState: .Normal)
        anstext.text        = "\(question[9])"

        //編集仕様：ページ番号表示
        pagelabel1.text = toString(pageno.toInt()! + 1)
        pagelabel2.text = toString(qid_org.count)
        
        //編集仕様：最終問題の場合、表示するボタン切り替える
        if pagelabel1.text == pagelabel2.text {
            nextbtn.hidden = true
            finishbutton.hidden = false
        }
        
        ansbutton1.titleLabel?.adjustsFontSizeToFitWidth = true
        ansbutton2.titleLabel?.adjustsFontSizeToFitWidth = true
        ansbutton3.titleLabel?.adjustsFontSizeToFitWidth = true
        ansbutton4.titleLabel?.adjustsFontSizeToFitWidth = true

        //回答済みならば結果表示、未回答なら回答状況へ追加
        if pageno.toInt() >= que.count {

            que.append("\(question[0])")
            ans.append("\(question[8])")
            res.append("0")

        } else if res[pageno.toInt()!] != "0" {
            
            answer(res[pageno.toInt()!].toInt()!)
            
        }else if pageno.toInt() < que.count {
        }
        
        ud.setObject(que , forKey: "que")
        ud.setObject(ans , forKey: "ans")
        ud.setObject(res , forKey: "res")
        ud.setObject(pageno , forKey: "page")
        ud.synchronize()
        
        
    }
    
    // ページ番号からインデックスを取得
    func find(parray:NSArray, qno:String) -> Int? {
        for var i = 0; i < parray.count; i++ {
            if parray[i] as! String == qno {
                return i
            }
        }
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //進むボタン押下時
    @IBAction func nextpage(sender: AnyObject) {
        
        que = ud.objectForKey("que") as! [String]!
        ans = ud.objectForKey("ans") as! [String]!
        res = ud.objectForKey("res") as! [String]!
        pageno = ud.stringForKey("page")!
        nextflg = "1"
        
    }
    
    //遷移時に戻るか、進むかを判定する
    override func viewWillDisappear(animated: Bool) {
        
        que = ud.objectForKey("que") as! [String]!
        ans = ud.objectForKey("ans") as! [String]!
        res = ud.objectForKey("res") as! [String]!
        pageno = ud.stringForKey("page")!
        
        //進むボタンが押されていたらページ番号をプラスする
        if nextflg == "1" {
            pageno = "\(pageno.toInt()! + 1)"
            nextflg = "0"
        }else if nextflg == "0" {
            pageno = "\(pageno.toInt()! - 1)"
            nextflg = "0"
        }

        ud.setObject(que , forKey: "que")
        ud.setObject(ans , forKey: "ans")
        ud.setObject(res , forKey: "res")
        ud.setObject(pageno , forKey: "page")
        ud.synchronize()

/*
        println(pageno.toInt())
        println(qid_org.count)
        if pageno.toInt() > 2 {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
*/

    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    //ユーザが選択した値
    @IBAction func answer1(sender: AnyObject) {
        //戻るボタン対応　押下時に最新の回答状況に更新し直す
        que = ud.objectForKey("que") as! [String]!
        ans = ud.objectForKey("ans") as! [String]!
        res = ud.objectForKey("res") as! [String]!
        pageno = ud.stringForKey("page")!
        
        //ユーザ操作の回答を格納
        res[pageno.toInt()!] = "1"
        
        //回答描画
        answer(1);
        
        ud.setObject(res , forKey: "res")
        ud.synchronize()
    }
    @IBAction func answer2(sender: AnyObject) {
        que = ud.objectForKey("que") as! [String]!
        ans = ud.objectForKey("ans") as! [String]!
        res = ud.objectForKey("res") as! [String]!
        pageno = ud.stringForKey("page")!
        res[pageno.toInt()!] = "2"
        answer(2);
        ud.setObject(res , forKey: "res")
        ud.synchronize()
    }
    @IBAction func answer3(sender: AnyObject) {
        que = ud.objectForKey("que") as! [String]!
        ans = ud.objectForKey("ans") as! [String]!
        res = ud.objectForKey("res") as! [String]!
        pageno = ud.stringForKey("page")!
        res[pageno.toInt()!] = "3"
        answer(3);
        ud.setObject(res , forKey: "res")
        ud.synchronize()
    }
    @IBAction func answer4(sender: AnyObject) {
        que = ud.objectForKey("que") as! [String]!
        ans = ud.objectForKey("ans") as! [String]!
        res = ud.objectForKey("res") as! [String]!
        res[pageno.toInt()!] = "4"
        answer(4);
        ud.setObject(res , forKey: "res")
        ud.synchronize()
    }
    
    //回答描画
    func answer(resno: Int ){
        
        //選択肢を非活性
        ansbutton1.enabled = false
        ansbutton2.enabled = false
        ansbutton3.enabled = false
        ansbutton4.enabled = false
        
        //解説を表示
        anstext.hidden = false
        
        //選択したボタン以外を半透明
        switch resno {
        case 1:
            ansbutton2.alpha = 0.3
            ansbutton3.alpha = 0.3
            ansbutton4.alpha = 0.3
            break
        case 2:
            ansbutton1.alpha = 0.3
            ansbutton3.alpha = 0.3
            ansbutton4.alpha = 0.3
            break
        case 3:
            ansbutton1.alpha = 0.3
            ansbutton2.alpha = 0.3
            ansbutton4.alpha = 0.3
            break
        case 4:
            ansbutton1.alpha = 0.3
            ansbutton2.alpha = 0.3
            ansbutton3.alpha = 0.3
            break
        default:
            break
        }
        
        //正解に"正解"を表示
        let ansno = ans[pageno.toInt()!].toInt()!
        switch ansno {
        case 1:
            anslabel1.hidden = false
            break
        case 2:
            anslabel2.hidden = false
            break
        case 3:
            anslabel3.hidden = false
            break
        case 4:
            anslabel4.hidden = false
            break
        default:
            break
        }
    }
    
    //modal終了処理
    @IBAction func exit(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var forward: UIButton!
    
    /*
    @IBAction func forward(sender: AnyObject) {
    var nowpage_str :String = ud.stringForKey("nowpage")!
    var nowpage_int :Int = nowpage_str.toInt()! + 1
    ud.setObject("\(nowpage_int)", forKey:"nowpage" )
    println(nowpage_int)
    }
    */
}

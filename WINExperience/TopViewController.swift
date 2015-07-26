//
//  TopViewController.swift
//  WINExperience
//
//  Created by Csato on 2015/04/07.
//  Copyright (c) 2015年 csatoapp. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let path = NSBundle.mainBundle().pathForResource("QuestionList", ofType: "plist")!
        let data = NSDictionary(contentsOfFile: path)

        let QuestionList = data?.objectForKey("QuestionList") as! NSArray

        var question2:[String] = []
        for que in QuestionList {

            question2.append(que.objectForKey("question") as! String)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

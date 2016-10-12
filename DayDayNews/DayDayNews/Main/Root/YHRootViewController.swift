//
//  YHRootViewController.swift
//  DayDayNews
//
//  Created by 马卿 on 16/10/11.
//  Copyright © 2016年 com.yihe. All rights reserved.
//通过反射创建子视图控制器

import UIKit

class YHRootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
         setupChildViewControllers()
        // Do any additional setup after loading the view.
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
//MARK:设置子控制器
extension YHRootViewController {

    func setupChildViewControllers()  {
        //子控制器详情
        let array = [
            ["className":"YHNewsViewController","title":"新闻","iconName":"tabbar_news"],
            ["className":"YHPhotoViewController","title":"图片","iconName":"tabbar_picture"],
            ["className":"YHVideoViewController","title":"视频","iconName":"tabbar_video"],
            ["className":"YHProfileViewController","title":"我","iconName":"tabbar_setting"]
        ]
        //遍历数组创建子视图控制器
        for dict in array {
            guard let className = dict["className"],
                  let title = dict["title"],
                  let iconName = dict["iconName"]
                else{
                  continue
            }
            var tmpVC : UIViewController?
            
            if let ClassType = NSClassFromString(NSBundle.mainBundle().namespace  + "." + className) as? UIViewController.Type{//swift
               tmpVC = ClassType.init()
            }else{
                if let ClassType = NSClassFromString(className) as? UIViewController.Type {//OC
                tmpVC = ClassType.init()
            }
            }
            guard let vc = tmpVC else{
                return
            }
            vc.view.backgroundColor = randomColor
            var seletedIconName = iconName
           seletedIconName = seletedIconName.stringByAppendingString("_hl")
            let selectedImage = UIImage(named:seletedIconName)?.imageWithRenderingMode(.AlwaysOriginal)
            vc.tabBarItem = UITabBarItem(title: title, image: UIImage(named: iconName)?.imageWithRenderingMode(.AlwaysOriginal), selectedImage:selectedImage)
            addChildViewController(vc)
          
        }

    }
    
}
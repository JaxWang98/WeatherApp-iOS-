//
//  SelectCityController.swift
//  Weather
//
//  Created by jaxwang on 2020/3/16.
//  Copyright © 2020 jaxwang. All rights reserved.
//

import UIKit

//1.自定义了一个协议，相当于制造了一个工具，待会让干活的人用
//个人理解，甲方爸爸提出了需求说明书（协议），好让乙方按要求干活
protocol SelectCityDelegate {
    func didChangeCity(city:String) //协议里不能包含函数的具体实现（函数体）
}
class SelectCityController: UIViewController {

    var cityName = ""
    //2.本页面有一些事件发生，这些事件函数究竟存放在哪里？--相当于告诉别人工具是谁所有的
    //甲方爸爸制造协议书，得说明遇到对应事件时，应该参考哪份协议
    var delegate: SelectCityDelegate?
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityInput: UITextField!
    
    //3.究竟在哪里触发这些事件函数呢？--在哪里使用这些工具呢？
    //甲方爸爸说明协议里事件对应的函数
    @IBAction func cityChange(_ sender: Any) {
        //？意思是delegate有值则继续执行后面的调用，若为nil，则不执行后面的调用
        delegate?.didChangeCity(city: cityInput.text!)//textfiled中的字符串已经处理过了，即使空也会返回空字符串，因此可以强制解包

    }
    @IBAction func quitButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.text  = cityName

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

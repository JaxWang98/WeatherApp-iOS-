//
//  ViewController.swift
//  Weather
//
//  Created by jaxwang on 2020/3/13.
//  Copyright © 2020 jaxwang. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

//delegate 委托
//procotol 协议
//一旦遵守了某个协议，就意味着我们需要干一些脏活累活（实现一些函数，因为协议里的函数都是没有实现的）
//个人理解协议有点像C#里的抽象类
class ViewController: UIViewController{//CLLocationManngerDelegate 是CLlocationMannger对应的协议
    //即我们既继承了UIviewController类，也遵守CLLocationManagerDelegate协议
    let locationMananger = CLLocationManager()
    var weather = Weather() //Weather类实例化
    let appid = "e7c44d12b8e0d79c19aeff1edf9a154a" //appid调用API时每次都要用，因此写成全局变量，省的每次写一遍
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //一开始viewcontroller遵循了CLLocationManngerDelegate之后，然后他干完了活（实现了函数）之后不知道给谁干的活，只知道个大概，也就是某个CL   LocationMannger
        //下面这句，让viewcontroller知道了他在给谁干活
        locationMananger.delegate = self // CLLocationManager的代理人是self（viewcontroller他自己）
        
        locationMananger.requestWhenInUseAuthorization()//请求授权获取当前位置（当使用的时候）
        locationMananger.desiredAccuracy = kCLLocationAccuracyHundredMeters//设置位置精度，精度越大、耗电越大
    }
    
    
    override func viewDidAppear(_ animated: Bool) { //view appear时
        super.viewDidAppear(animated)
        
        locationMananger.requestLocation() //请求用户位置--只请求一次
//        locationMananger.requestAlwaysAuthorization()//一直请求，比如嘀嘀打车
    }
    
    //当请求用户位置时立即调用这个方法--系统调用，不需要我们自己去调用
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lat = locations[0].coordinate.latitude //获取经度
        let lon = locations[0].coordinate.longitude //获取维度
        
        //参数--字典类型
        let paras = ["lat": "\(lat)","lon":"\(lon)","appid":appid]
        getWeather(paras) // 调用getWeather函数
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination. 得到跳转到的viewcontroller
        // Pass the selected object to the new view controller.
        if segue.identifier == "selectCity"{
            //as -->向上转型
            //as！-->向下转型，强制的，若失败则程序出错
            //as？-->向下转型，若失败则返回nil，需要iflet判断
            //找到目的地页面的控制器，以方便进行传值
            let vc = segue.destination as! SelectCityController //向下转型，selectCItyCOntroller是UIVIewcontrolle的子类
            vc.cityName = weather.city //传值成功，将weather.city的值传到了selectCityController中
            //3.第二个页面的delegate委托给本controller实现 --让干活的人（viewcontroller）知道老板是谁（第二个页面selectCityConttoller，即这里的vc），自己给谁干活呢
            vc.delegate = self
        }
    }

    
    
    

}
//扩展 --分离出代码，方便维护
//比较复杂项目，也可以把extension写成专门的文件，然后整理成组
//1.遵守协议--相当于，你让我干活，你得先给我个工具
//个人理解，你让我干活，得给我需求说明书
extension ViewController:  CLLocationManagerDelegate,SelectCityDelegate{
    //2.实现协议里的的必选方法 --接下来正式干活
    func didChangeCity(city: String) {
//        print(city)
        let paras = ["q":city,"appid":appid]
        getWeather(paras)
        dismiss(animated: true, completion: nil)
    }
    //目前是针对协议CLLocationMannger的扩展
        
    func getWeather(_ paras: [String:String]) { //传入的参数为字典类型
        //请求API来获取数据
        AF.request("https://api.openweathermap.org/data/2.5/weather?",parameters: paras).responseJSON { response in
            //iflet针对可选类型数据类型进行判断
            //回调函数中使用全局变量要使用self
            //MVC设计模式，将model中的值给controller，而不是直接给view
            if let json = response.value{
                
                let weather = JSON(json) //使用SwiftyJSONh中的JSON（）方法对json数据进行处理
            
                //给weather对象赋值，model --> controller
                self.createWeather(weatherJSON: weather)
        
                //更新界面 controller --> view
                self.updateUI()
            }
        }
    }
    //给weather赋值
    //传入的参数为JSON类型，是包SwiftyJSON中的包
    func createWeather(weatherJSON: JSON){
       weather.city = weatherJSON["name"].stringValue
       weather.temp = Int(round(weatherJSON["main","temp"].doubleValue - 273.15))// 开尔文转换成摄氏度 -273.15 //round()对double四舍五入，再通过Int()转换为整数
       weather.condition = weatherJSON["weather",0,"id"].intValue
    }
    //更新界面
    func updateUI()
    {
        cityLabel.text = self.weather.city
        tempLabel.text = "\(self.weather.temp)˚"
        conditionImageView.image = UIImage(named: self.weather.icon)
    }
    //请求位置失败时调用
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "获取位置失败"
    }
    
    
    
    
}


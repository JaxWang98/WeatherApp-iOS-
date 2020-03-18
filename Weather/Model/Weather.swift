
//
//  Weather.swift
//  Weather
//
//  Created by jaxwang on 2020/3/16.
//  Copyright © 2020 jaxwang. All rights reserved.
//

import Foundation

class Weather{
    var temp = 0
    var city = ""
    var condition = 0 //天气状况,id来表示对应的天气
    
    //计算属性
    //参考API转换网址 https://openweathermap.org/weather-conditions
    var icon: String{ //根据condition 的id计算出应该有的图标icon
        switch condition {
        case 0...300 :
            return "tstorm1"
            
        case 301...500 :
            return "light_rain"
            
        case 501...600 :
            return "shower3"
            
        case 601...700 :
            return "snow4"
            
        case 701...771 :
            return "fog"
            
        case 772...799 :
            return "tstorm3"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy2"
            
        default :
            return "dunno"
        }
    }
}

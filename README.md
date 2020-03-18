# WeatherApp-iOS-
 a weather app developed by Swift and Xcode11.
## 功能介绍
  使用Xcode + swift进行开发，设计并实现一个多界面天气app，通过访问用户当前位置向API请求并得到天气信息，并显示在当前界面上；在第二个界面app还可以通过城市名查询天气。
## 使用的包、API
  * 包管理工具cocoaPods
  * Alomofire --进行http请求，返回JSON格式
  * SwiftyJSON -- 处理得到的JSON数据，读取需要的部分
  * SVSVProgressHUD -- 界面加载动画
  * 请求天气信息访问的API -- Openweathermap
## 设计理念
  * 根据MVC设计模式，首先设计好view：通过storyBoard进行界面设计，创建两个viewController，添加好控件和constrain，在跳转按钮上设置segue实现页面跳转。
  * 在model部分，定义Weather类，为他添加气温、城市等属性，并添加根据id来判断其天气类型的计算属性，以方便处理和传递从API获取的JSON信息
  * 在controller部分，第一个界面对应viewContorller，引入CoreLocation，通过其中的CLLocationManner类来实现对用户位置的访问。项目中访问的API为openweathermap，通过Alamofire发送https请求，并使用SwiftyJson包来处理返回的JSON数据。为了代码规范与方便扩展，扩展了了viewController类，在扩展中遵循CLLocationManngerDelegate协议，并实现具体功能。第二个界面对应SelectCityController，用户在textfield中输入城市名，点击查询，需要反向传值到第一个页面。为实现反向传值，在SelectCityController中自定义了协议 SelectCityDelegate，定义了按钮触发事件，并委托给viewController实现，在其扩展中读取传过来的值并更新界面。
## 界面及功能展示
界面1 自动读取用户当前位置并显示天气信息
<div align=center><img src="https://github.com/JaxWang98/WeatherApp-iOS-/blob/master/image/1.png" alt="img1" width="432" height="747"></div> 
界面2 可选择城市来查询天气，当前城市会显示读取的位置
<div align=center><img src="https://github.com/JaxWang98/WeatherApp-iOS-/blob/master/image/2.png" alt="img1" width="432" height="747"></div>
 输入城市查询
<div align=center><img src="https://github.com/JaxWang98/WeatherApp-iOS-/blob/master/image/3.png" alt="img1" width="432" height="747"></div>
显示查询的城市天气
<div align=center><img src="https://github.com/JaxWang98/WeatherApp-iOS-/blob/master/image/4.png" alt="img1" width="432" height="747"></div> 






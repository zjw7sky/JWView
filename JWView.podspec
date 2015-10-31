

Pod::Spec.new do |s|
s.name         = "JWView"  #名字
s.version      = "0.0.1"  #版本号
s.summary      = "JWView" #简短的介绍
s.homepage     = "https://github.com/zjw7sky/JWView.git"   #主页,这里要填写可以访问到的地址，不然验证不通过
s.license      = "MIT"  #开源协议
s.author             = { "zjw7sky" => "745650559@qq.com" }  #作者信息
s.platform     = :ios,     #支持平台及版本
s.source       = { :git => "https://github.com/zjw7sky/JWView.git", :tag => s.version }    #项目地址，这里不支持ssh的地址，验证不通过，只支持HTTP和HTTPS，最好使用HTTPS,
s.source_files  = "JWView/*" #代码源文件地址，**/*表示Classes目录及其子目录下所有文件，如果有多个目录下则用逗号分开，如果需要在项目中分组显示，这里也要做相应的设置
#s.requires_arc = true   #项目是否使用 ARC
end
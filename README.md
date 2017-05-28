# BoneZoomImage 图片放大器
![github](https://github.com/kuangtao22/BoneImagePreview/blob/master/%E9%A2%84%E8%A7%88.gif
 "github")  
## 简介
BoneZoomImage是纯swift写的图片预览，集成非常简单，只需要一句即可集成，点击图片即可放大，双击放大图可最大化，单击可隐藏显示nav，在1倍大小时，下滑/上滑可关闭预览，模仿ios系统原生照片缩放动画。

## 环境要求

* iOS 7.0+
* Xcode 8 (Swift 3) 版

## BoneZoomImage
* 集成方法

		self.imageView.zoomImage()
本方法支持父视图下的图片预览、tableViewCell下的图片预览
		
--
 

> 注意事项: 
> 
* 图片保存功能必须在plist中添加 NSPhotoLibraryUsageDescription
* Supporting Files文件夹内sdk可根据自己习惯替换
* 状态栏隐藏效果，请在plist中添加UIViewControllerBasedStatusBarAppearance为NO
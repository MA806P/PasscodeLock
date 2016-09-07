# PasscodeLock
<p align="center">
## 密码解锁  手势解锁  指纹解锁
 

## 1.手势解锁
![demo](https://github.com/MA806P/PasscodeLock/blob/master/ScreenShoot/Gesture.gif)
 
 使用方法
 ```
 MYZGestureView * gestureView = [[MYZGestureView alloc] init];
 gestureView.gestureResult = ^(NSString * gestureCode){
   //得到手势密码 gestureCode 
 };
```
 
 
 
 
## 2.密码解锁 
 ![demo](https://github.com/MA806P/PasscodeLock/blob/master/ScreenShoot/Passcode.gif)
 
 使用方法
 ```
 MYZPasscodeView * passcodeView = [[MYZPasscodeView alloc] init];
 passcodeView.PasscodeResult = ^(NSString * passcode){
    //得到数字密码passcode
 };
 ```
 
 
 
 
## 3.指纹解锁
 
 
 
 
 
 
 
 

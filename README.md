
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
 ![demo](https://github.com/MA806P/PasscodeLock/blob/master/ScreenShoot/Fingerprint.jpg)

```
#import <LocalAuthentication/LocalAuthentication.h>

//判断是否支持指纹识别
if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
{
    //本地验证对象上下文
    LAContext *context = [LAContext new];

    //LAPolicyDeviceOwnerAuthenticationWithBiometrics: 允许使用
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]){
        
        //localizedReason: 指纹识别出现时的提示文字
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"指纹识别, 开锁" reply:^(BOOL success, NSError * _Nullable error) {

            if (success) {
                //识别成功
                dispatch_async(dispatch_get_main_queue(), ^{ 
                    //...
                });
            }

            if (error) { }
        }];
    }
}

```

 
 
 
 
 
 

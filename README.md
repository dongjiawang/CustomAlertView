# CustomAlertView
![AlertView](https://raw.githubusercontent.com/dongjiawang/CustomAlertView/master/images/2017-04-06.gif)


```objectivec
   CommonTextAlertView *alert = [[CommonTextAlertView alloc] initWithMessage:@"自定义alert 输入框" placeholder:@"说点什么吧" okAction:@"确定" okActionStyle:TextAlertActionStyleDestructive cancelAction:@"取消" cancelActionStyle:TextAlertActionStyleDefault okHandler:^(NSString *alertString) {

   } cancelHandler:^{

    }];
[self.view addSubview:alert];
```

![TextAlertView](https://raw.githubusercontent.com/dongjiawang/CustomAlertView/master/images/TextAlert.png)

```objectivec
  StarAlertView *alert = [[StarAlertView alloc] initWithMessage:@"打分" StarValue:0 okAction:@"确定" okActionStyle:StarAlertActionStyleDestructive cancelAction:@"取消" cancelActionStyle:StarAlertActionStyleDefault okHandler:^(CGFloat starValue) {

  } cancelHandler:nil];

[self.view addSubview:alert];
```

![StarAlertView](https://raw.githubusercontent.com/dongjiawang/CustomAlertView/master/images/StarAlert.png)


```objectivec
    StarTextAlertView *alert = [[StarTextAlertView alloc] initWithPlaceholder:@"说点什么吧" okAction:@"提交" okActionStyle:StarTextAlertActionStyleDestructive cancelAction:@"取消" cancelActionStyle:StarTextAlertActionStyleDefault okHandler:^(CGFloat starValue, NSString *alertString) {

    } cancel:^{

    }];
[self.view addSubview:alert];
```

![StarTextAlertView](https://raw.githubusercontent.com/dongjiawang/CustomAlertView/master/images/StarTextAlert.png)


其中带 Star 的 Alert 使用 [HCSStarRatingView](https://github.com/hsousa/HCSStarRatingView), 感谢作者.
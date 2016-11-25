//
//  RegisterViewController.h
//  看你有多色
//
//  Created by Agan on 16/8/16.
//  Copyright © 2016年 brother. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RegisterViewControllerdelegate <NSObject>

-(void)RegisterName:(NSString *)user andPass:(NSString *)pass;

@end
@interface RegisterViewController : UIViewController
@property (strong,nonatomic)id<RegisterViewControllerdelegate>delegate;
@end

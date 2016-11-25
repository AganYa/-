//
//  LoginViewController.m
//  看你有多色
//
//  Created by Agan on 16/8/16.
//  Copyright © 2016年 brother. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()



- (IBAction)LoginClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *LoginName;
@property (weak, nonatomic) IBOutlet UITextField *LoginPass;
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString *password;
@property(nonatomic,strong) NSMutableArray *RegisterArray;
//标识
@property(nonatomic,assign)int ture;

@end

@implementation LoginViewController
-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //默认
    self.ture = 1;
    
}
-(NSMutableArray *)RegisterArray{
    if (_RegisterArray==nil) {
        NSString *path=[[NSBundle mainBundle] pathForResource:@"Register" ofType:@"plist"];
        _RegisterArray=[NSMutableArray arrayWithContentsOfFile:path];
    }
    return _RegisterArray;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}






- (IBAction)LoginClick:(UIButton *)sender {
    
    _userName = [NSString stringWithFormat:@"%@",self.LoginName.text];
    _password = [NSString stringWithFormat:@"%@",self.LoginPass.text];
    if ([_userName isEqualToString:@""]) {
        [self alert:@"用户名不能为空"];
    }
    else if ([_password isEqualToString:@""]) {
        [self alert:@"密码不能为空"];
    }
    for (NSMutableDictionary *dic in self.RegisterArray ) {
        if ([[dic objectForKey:@"用户名"] isEqualToString:self.LoginName.text] && [[dic objectForKey:@"密码"] isEqualToString:self.LoginPass.text]  ) {
            self.ture = 0;
        }
    }
    if (self.ture == 0) {
       //[self alert:@"YES"];
    }else{
       [self alert:@"密码或用户名错误"];
        self.ture = 1;
    }
    
 
}


-(void)alert:(NSString*)msg
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end

//
//  RegisterViewController.m
//  看你有多色
//
//  Created by Agan on 16/8/16.
//  Copyright © 2016年 brother. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UITextField *Pass;
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString *password;

- (IBAction)Register:(UIButton *)sender;

@property(nonatomic,strong)NSMutableArray *RegisterArray;
@end

@implementation RegisterViewController
-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.Pass.secureTextEntry = YES;

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



- (IBAction)Register:(UIButton *)sender {
    
    _userName = [NSString stringWithFormat:@"%@",self.Name.text];
    _password = [NSString stringWithFormat:@"%@",self.Pass.text];
    if ([_userName isEqualToString:@""]) {
        [self alert:@"用户名不能为空"];
    }
    else if ([_password isEqualToString:@""]) {
        [self alert:@"密码不能为空"];
    }
    else {
        [self alert:@"注册成功"];
        NSDictionary *dic =@{@"用户名":_userName,@"密码":_password};
        [self.RegisterArray addObject:dic];
        [self.RegisterArray writeToFile:@"/Users/Agan/Desktop/看你有多色/看你有多色/Register.plist" atomically:YES];
        if ([self.delegate respondsToSelector:@selector(RegisterName:andPass:)]) {
            [self.delegate RegisterName:_userName andPass:_password];
            
//            [self dismissViewControllerAnimated:YES completion:nil];
        
        }
        
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

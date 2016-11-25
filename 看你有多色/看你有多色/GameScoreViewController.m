//
//  GameScoreViewController.m
//  看你有多色
//
//  Created by Agan on 16/8/17.
//  Copyright © 2016年 brother. All rights reserved.
//

#import "GameScoreViewController.h"

@interface GameScoreViewController ()
@property (weak, nonatomic) IBOutlet UITextField *SoreLab1;
@property (weak, nonatomic) IBOutlet UITextField *SoreLab2;
@property (weak, nonatomic) IBOutlet UITextField *SoreLab3;
@property(nonatomic,strong)NSMutableArray *scoreArray;
@end

@implementation GameScoreViewController

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scoreArray=[NSMutableArray arrayWithContentsOfFile:@"/Users/Agan/Desktop/看你有多色/看你有多色/GameScore.plist"];
    [self TraversalScoreArray1];
    [self TraversalScoreArray2];
    [self TraversalScoreArray3];
    
}
-(void)TraversalScoreArray1{
    
    int x=0;
    int max=0;
    for (int i=0; i<self.scoreArray.count; i++) {
        NSString *str=[NSString string];
        str=self.scoreArray[i];
        int n=[str intValue];
        if (max<n)
        {
            max=n;
            x=i;
        }
    }
    
    self.SoreLab1.text=self.scoreArray[x];
    [self.scoreArray removeObjectAtIndex:x];
}


-(void)TraversalScoreArray2{
    
    int x=0;
    int max=0;
    for (int i=0; i<self.scoreArray.count; i++) {
        NSString *str=[NSString string];
        str=self.scoreArray[i];
        int n=[str intValue];
        if (max<n)
        {
            max=n;
            x=i;
        }
    }
    
    self.SoreLab2.text=self.scoreArray[x];
    [self.scoreArray removeObjectAtIndex:x];
   }
-(void)TraversalScoreArray3{
    
    int x=0;
    int max=0;
    for (int i=0; i<self.scoreArray.count; i++) {
        NSString *str=[NSString string];
        str=self.scoreArray[i];
        int n=[str intValue];
        if (max<n)
        {
            n=max;
            x=i;
        }
    }
    
    self.SoreLab3.text=self.scoreArray[x];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end



#import "GameViewController.h"
#import  <AVFoundation/AVFoundation.h>
#define kGameTime 60 //游戏时长
#define kBlockMargin 3 //游戏块间隙
#define kDiffrentLevel 0.7 //游戏难度，即颜色差值

@interface GameViewController ()<AVAudioPlayerDelegate> {
    AVAudioPlayer *player;
    int gameLevel; //游戏级别
    int gameScore; //游戏分数
    NSUInteger correctBlockIndex; //正确游戏块索引
}

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *gameContentView;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation GameViewController {
    double boardW;          //用来记录整个屏幕大小
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self gameStart];
    
//    NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"背景音乐_01" ofType:@"wav"];
//    NSURL *url1 = [[NSURL alloc]initFileURLWithPath:filePath1];
//    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url1 error:nil];
    
    
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"04夏恋" ofType:@"mp3"];
    NSURL *url2 = [[NSURL alloc]initFileURLWithPath:filePath2];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url2 error:nil];
    
    player.delegate = self;  //设置代理对象
    player.numberOfLoops = 2; //设置播放次数
    player.volume = 1;      //设置音量大小
    [player prepareToPlay];
    [player play];
}

#pragma mark -- 开始游戏
- (void)gameStart {
    [self gameTimer]; //触发计时器
    [self loadGame];  //初始化加载
}
#pragma mark -- 初始化加载
- (void)loadGame {
    gameLevel = 1;
    gameScore = 0;
    [self updateGameLevel];
}
#pragma mark -- 更新游戏视图界面
- (void)updateGameLevel {

    [self.gameContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    /*根据游戏级别更新游戏块*/
    //随机产生颜色
    CGFloat red = 1.0 / arc4random_uniform(15);
    CGFloat green = 1.0 / arc4random_uniform(15);
    CGFloat blue = 1.0 / arc4random_uniform(15);

    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:0.9];
    //统一添加游戏块
    if (gameLevel>5) {
        gameLevel=5;
    }
    for (int i = 0; i < gameLevel + 1; i++) {
        for (int j = 0; j < gameLevel + 1; j++) {
            UIButton *gameBlock = [UIButton buttonWithType:UIButtonTypeCustom];
            gameBlock.backgroundColor = randomColor; //设置统一随机颜色

            boardW = [UIScreen mainScreen].bounds.size.width;
            double blockW = (boardW - kBlockMargin * (gameLevel + 2)) / (gameLevel + 1);
            double blockX = kBlockMargin + (kBlockMargin + blockW) * j;
            double blockY = kBlockMargin + (kBlockMargin + blockW) * i;
            gameBlock.frame = CGRectMake(blockX,blockY, blockW, blockW);
            gameBlock.layer.cornerRadius = 6;
            gameBlock.layer.masksToBounds = YES;
            [self.gameContentView addSubview:gameBlock];
            [gameBlock addTarget:self action:@selector(gameBlockClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    //随机取出正确块，并个性化设置近似颜色
    int numberOfAllBlocks = (gameLevel + 1) * (gameLevel + 1);
    int randomIndex = arc4random_uniform(numberOfAllBlocks);
    correctBlockIndex =  (NSUInteger) randomIndex;
    NSArray *allGameBlocks = [self.gameContentView subviews];
    UIColor *yesColor = [UIColor colorWithRed:red green:green blue:blue alpha:kDiffrentLevel];
    [allGameBlocks[correctBlockIndex] setBackgroundColor:yesColor];
    [allGameBlocks[correctBlockIndex] setTag:5];

    self.scoreLabel.text = [NSString stringWithFormat:@"%02d",gameScore];

}
#pragma mark -- 计时器方法
- (void)gameTimer {
    self.timeLabel.text = [NSString stringWithFormat:@"%d",kGameTime];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTimeLabel) userInfo:nil repeats:YES];
}

#pragma mark -- 计时更新
- (void)changeTimeLabel {
    int timeCount = [self.timeLabel.text intValue];
    if (timeCount > 0) {
        
        timeCount--;
        self.timeLabel.text = [NSString stringWithFormat:@"%d",timeCount];
       
    } else {
        
        [self TimeShow];
        [self.timer invalidate];
       
    }
}
#pragma mark -- 暂停游戏
- (IBAction)pauseButtonClicked:(UIButton *)sender {
    if (sender.selected == NO) {
        sender.selected = YES;
        self.timer.fireDate = [NSDate distantFuture];

        [self.gameContentView setUserInteractionEnabled:NO];
        UILabel *pauseMask = [[UILabel alloc] init];
        pauseMask.frame = self.gameContentView.frame;
        pauseMask.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
        pauseMask.text = @"稍事休息，揉揉眼睛再战";
        pauseMask.textColor = [UIColor whiteColor];
        pauseMask.textAlignment = NSTextAlignmentCenter;
        pauseMask.tag = 25;
        [self.gameContentView.superview addSubview:pauseMask];
    } else {
        sender.selected = NO;
        self.timer.fireDate = [NSDate date];
        [self.gameContentView setUserInteractionEnabled:YES];
        [[self.gameContentView.superview viewWithTag:25] removeFromSuperview];
    }
}
#pragma mark --点击游戏块
- (void)gameBlockClicked:(UIButton *)sender {
    if (sender.tag == 5) {
        [self RightMusic];
        ++gameLevel;
        gameScore +=2;
        [self updateGameLevel];
        
        
    }else {
        [self WrongMusic];
        [player stop];
        if (gameScore>0) {
            gameScore -=1;
        }
        [self TimeShow];
     
        [self.timer invalidate];
    }
    
}

-(void)TimeShow{
    NSMutableArray * scorearr=[NSMutableArray arrayWithContentsOfFile:@"/Users/Agan/Desktop/看你有多色/看你有多色/GameScore.plist"];
    NSString *score=[NSString stringWithFormat:@"%d",gameScore];
    [scorearr addObject:score];
    [scorearr writeToFile:@"/Users/Agan/Desktop/看你有多色/看你有多色/GameScore.plist" atomically:YES];
    if (gameScore<60) {
      
        self.scoreLabel.text = [NSString stringWithFormat:@"%02d",gameScore];
        NSString *message = [NSString stringWithFormat:@"本局得分：%d",gameScore];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"恭喜你获得“色盲”称号"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"返回游戏" otherButtonTitles:nil];
        [alert show];
        [self WrongMusic];
        
    }else{
        self.scoreLabel.text = [NSString stringWithFormat:@"%02d",gameScore];
        NSString *message = [NSString stringWithFormat:@"本局得分：%d",gameScore];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"恭喜你获得“色魔”称号"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"返回游戏" otherButtonTitles:nil];
        [alert show];
        [self WrongMusic];
        
        
    }
}

#pragma mark -- UIAlert代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:^{
        //游戏完成
    }];
}

- (NSString *)highestScore {
    return self.scoreLabel.text;
}
-(void)RightMusic
{
    SystemSoundID sound;
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"正确音乐.wav" ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileUrl, &sound);
    AudioServicesPlaySystemSound(sound);
}
-(void)WrongMusic
{
    SystemSoundID sound;
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"结束音乐.wav" ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileUrl, &sound);
    AudioServicesPlaySystemSound(sound);
}
@end

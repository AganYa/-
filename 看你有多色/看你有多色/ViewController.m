

#import "ViewController.h"
#import "GameViewController.h"



@interface ViewController ()

@end

@implementation ViewController
-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.delegate = segue.destinationViewController;
}

- (void)viewWillAppear:(BOOL)animated {
    if ([self.highestScroeLabel.text intValue] < [[self.delegate highestScore] intValue]) {
        self.highestScroeLabel.text = [self.delegate highestScore];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    self.highestScore = self.highestScroeLabel.text;
}

@end

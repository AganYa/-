
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@protocol HighestRecordDelegate <NSObject>

- (NSString *)highestScore;

@end

@interface ViewController : UIViewController

@property (copy, nonatomic) NSString *highestScore;
@property (assign, nonatomic) id<HighestRecordDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *highestScroeLabel;

@end
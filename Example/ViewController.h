#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextViewDelegate>
{
    int oneclick;
}
- (void) updateChatContent: (NSString*) text;
- (NSString *) getChatContent;
@property (nonatomic, assign) IBOutlet UISwitch *freeTalkSwitch;
@property (nonatomic, assign) IBOutlet UIButton *pushToTalkButton;
@property (nonatomic, assign) IBOutlet UIButton *initButton;
@property (nonatomic, assign) IBOutlet UIButton *startButton;
@property (nonatomic, assign) IBOutlet UIButton *joinButton;
@property (nonatomic, assign) IBOutlet UIButton *sendTextButton;
@property (nonatomic, assign) IBOutlet UIButton *recordVoiceButton;
@property (nonatomic, assign) IBOutlet UIButton *stopRecordButton;
@property (nonatomic, assign) IBOutlet UIButton *playRecordButton;
@property (nonatomic, assign) IBOutlet UIButton *enableVoiceButton;
@property (nonatomic, assign) IBOutlet UIButton *disVoiceButton;
@property (nonatomic, assign) IBOutlet UIButton *muteSendButton;
@property (nonatomic, assign) IBOutlet UIButton *unmuteSendButton;
@property (nonatomic, assign) IBOutlet UIButton *speakerOutButton;
@property (nonatomic, assign) IBOutlet UIButton *micOutButton;
@property (nonatomic, assign) IBOutlet UIButton *stopButton;
@property (nonatomic, assign) IBOutlet UITextView *chatScreen;

@end


#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"
#include "SDKDelegate.h"
//#include "VoiceRecorder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    oneclick = 0;
}
- (IBAction) init:(id)sender{
    self.chatScreen.text =@"init";
    SDKDelegate::getInstance()->setOneClick(false);
    SDKDelegate::getInstance()->init();
}
- (IBAction) start:(id)sender{
    self.chatScreen.text =@"start";
    Auviis::getInstance()->connect();
}
- (IBAction) join:(id)sender{
    self.chatScreen.text =@"join";
    Auviis::getInstance()->joinChannel(123);
}
- (IBAction) sendTextChat:(id)sender{
    self.chatScreen.text =@"sendTextChat";
    Auviis::getInstance()->sendTextChat(123,"hello");
}
- (IBAction) recordVoice:(id)sender{
    self.chatScreen.text =@"recordVoice";
}
- (IBAction) stopRecord:(id)sender{
    self.chatScreen.text =@"stopRecord";
}
- (IBAction) playRecord:(id)sender{
    self.chatScreen.text =@"playRecord";
}
- (IBAction) enableVoiceStream:(id)sender{
    self.chatScreen.text =@"enableVoice";
    Auviis::getInstance()->startVoiceStream();
}
- (IBAction) disableVoiceStream:(id)sender{
    self.chatScreen.text =@"disableVoice";
    Auviis::getInstance()->stopVoiceStream();
}
- (IBAction) muteSend:(id)sender{
    self.chatScreen.text =@"muteSend";
    Auviis::getInstance()->muteSend();
}
- (IBAction) unmuteSend:(id)sender{
    self.chatScreen.text =@"unmuteSend";
    Auviis::getInstance()->unmuteSend();
}
- (IBAction) speakerOut:(id)sender{
    self.chatScreen.text =@"speakerOut";
    Auviis::getInstance()->outputToSpeaker();
}
- (IBAction) micOut:(id)sender{
    self.chatScreen.text =@"micOut";
    Auviis::getInstance()->outputToDefault();
}
- (IBAction) stop:(id)sender{
    self.chatScreen.text =@"stop";
    Auviis::getInstance()->stop();
}

- (IBAction) oneClickStart:(id)sender{
    self.chatScreen.text =@"oneClickStart";
    SDKDelegate::getInstance()->setOneClick(true);
    SDKDelegate::getInstance()->init();
    [self.freeTalkSwitch setEnabled:TRUE];
}

- (IBAction) oneClickStop:(id)sender{
    [self.freeTalkSwitch setOn:FALSE];
    [self.freeTalkSwitch setEnabled:FALSE];
    self.chatScreen.text =@"oneClickStop";
    Auviis::getInstance()->stop();
}
- (IBAction) freeTalk:(id)sender{
    BOOL on = [self.freeTalkSwitch isOn];
    if (on){
        self.chatScreen.text = @"freeTalk Mode on";
        Auviis::getInstance()->unmuteSend();
        self.pushToTalkButton.enabled = FALSE;
    }else{
        self.chatScreen.text = @"freeTalk Mode off";
        Auviis::getInstance()->muteSend();
        self.pushToTalkButton.enabled = TRUE;
    }
}
- (IBAction) pushToTalkOn:(id)sender{
    self.chatScreen.text = @"pushToTalkOn";
    Auviis::getInstance()->unmuteSend();
}
- (IBAction) pushToTalkOff:(id)sender{
    self.chatScreen.text = @"pushToTalkOff";
    Auviis::getInstance()->muteSend();
}
@end

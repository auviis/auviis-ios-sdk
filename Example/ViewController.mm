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
//    self.chatScreen.text =@"init";
    SDKDelegate::getInstance()->setOneClick(false);
    SDKDelegate::getInstance()->init();
}
- (IBAction) start:(id)sender{
//    self.chatScreen.text =@"start";
    Auviis::connect();
}
- (IBAction) join:(id)sender{
//    self.chatScreen.text =@"join";
    Auviis::joinChannel(123);
}
- (IBAction) sendTextChat:(id)sender{
//    self.chatScreen.text =@"sendTextChat";
    Auviis::sendTextChat(123,"hello");
}
- (IBAction) recordVoice:(id)sender{
//    self.chatScreen.text =@"recordVoice";
}
- (IBAction) stopRecord:(id)sender{
//    self.chatScreen.text =@"stopRecord";
}
- (IBAction) playRecord:(id)sender{
//    self.chatScreen.text =@"playRecord";
}
- (IBAction) enableVoiceStream:(id)sender{
//    self.chatScreen.text =@"enableVoice";
    Auviis::startVoiceStream();
}
- (IBAction) disableVoiceStream:(id)sender{
//    self.chatScreen.text =@"disableVoice";
    Auviis::stopVoiceStream();
}
- (IBAction) muteSend:(id)sender{
//    self.chatScreen.text =@"muteSend";
    Auviis::muteSend();
}
- (IBAction) unmuteSend:(id)sender{
//    self.chatScreen.text =@"unmuteSend";
    Auviis::unmuteSend();
}
- (IBAction) speakerOut:(id)sender{
//    self.chatScreen.text =@"speakerOut";
    Auviis::outputToSpeaker();
}
- (IBAction) micOut:(id)sender{
//    self.chatScreen.text =@"micOut";
    Auviis::outputToDefault();
}
- (IBAction) stop:(id)sender{
    self.chatScreen.text =@"sdk stopped";
    Auviis::stop();
}

- (IBAction) oneClickStart:(id)sender{
    self.chatScreen.text =@"sdk is coneccting ...";
    SDKDelegate::getInstance()->setOneClick(true);
    SDKDelegate::getInstance()->init();
    [self.freeTalkSwitch setEnabled:TRUE];
}

- (IBAction) oneClickStop:(id)sender{
    [self.freeTalkSwitch setOn:FALSE];
    [self.freeTalkSwitch setEnabled:FALSE];
//    self.chatScreen.text =@"oneClickStop";
    Auviis::stop();
    self.chatScreen.text =@"sdk stopped";
}
- (IBAction) freeTalk:(id)sender{
    BOOL on = [self.freeTalkSwitch isOn];
    if (on){
//        self.chatScreen.text = @"freeTalk Mode on";
        Auviis::unmuteSend();
        self.pushToTalkButton.enabled = FALSE;
    }else{
//        self.chatScreen.text = @"freeTalk Mode off";
        Auviis::muteSend();
        self.pushToTalkButton.enabled = TRUE;
    }
}
- (IBAction) pushToTalkOn:(id)sender{
//    self.chatScreen.text = @"pushToTalkOn";
    Auviis::unmuteSend();
}
- (IBAction) pushToTalkOff:(id)sender{
//    self.chatScreen.text = @"pushToTalkOff";
    Auviis::muteSend();
}
- (void) updateChatContent: (NSString*) text{
    self.chatScreen.text = text;
}
- (NSString *) getChatContent{
    return self.chatScreen.text;
}
@end

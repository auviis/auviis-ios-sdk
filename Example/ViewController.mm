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
    self.chatScreen.delegate = self;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    // Do whatever you want here
    NSString*  newStr = [URL absoluteString];
    NSRange range = [newStr  rangeOfString : @"playvoicemsg:"];
    BOOL found = ( range.location != NSNotFound );
    if(found){
        NSString *msg_id = [newStr componentsSeparatedByString:@"playvoicemsg:"][1];
        Auviis::playVoiceMessage([msg_id UTF8String]);
    }
    return NO; // Return NO if you don't want iOS to open the link
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    return NO; // Return NO if you don't want iOS to open the link
}
//- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
//    // Do whatever you want here
//    NSLog(@"%@", URL); // URL is an instance of NSURL of the tapped link
//    return YES; // Return NO if you don't want iOS to open the link
//}
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
    [self updateChatContent: @"recording voice message"];
    Auviis::recordVoice();
}
- (IBAction) stopRecord:(id)sender{
    [self updateChatContent: @"stop recording voice message"];
    Auviis::stopRecord();
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
    [self updateChatContent: @"sdk stopped"];
    Auviis::stop();
}

- (IBAction) oneClickStart:(id)sender{
    [self updateChatContent: @"sdk is connecting ..."];
    SDKDelegate::getInstance()->setOneClick(true);
    SDKDelegate::getInstance()->init();
    [self.freeTalkSwitch setEnabled:TRUE];
}

- (IBAction) oneClickStop:(id)sender{
    [self.freeTalkSwitch setOn:FALSE];
    [self.freeTalkSwitch setEnabled:FALSE];
//    self.chatScreen.text =@"oneClickStop";
    Auviis::stop();
    [self updateChatContent: @"sdk stopped"];
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
    NSString *txt = [NSString stringWithFormat:@"<br/>%@", text];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                   initWithData: [@"" dataUsingEncoding:NSUnicodeStringEncoding]
                                                        options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                             documentAttributes: nil
                                                          error: nil
                                         ];
    [attributedString appendAttributedString:self.chatScreen.attributedText];
    NSAttributedString *attributedStringAppend = [[NSMutableAttributedString alloc]
                                  initWithData: [txt dataUsingEncoding:NSUnicodeStringEncoding]
                                       options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                            documentAttributes: nil
                                         error: nil
                        ];
    [attributedString appendAttributedString:attributedStringAppend];
//    NSLog(@"txt:%@",txt);
    self.chatScreen.attributedText = attributedString;
    
    NSRange range = NSMakeRange(self.chatScreen.attributedText.string.length - 1, 1);
    [self.chatScreen scrollRangeToVisible:range];
}
- (NSString *) getChatContent{
    return self.chatScreen.attributedText.string;
}
@end

#import "SDKDelegate.h"
#import "ViewController.h"
#import "AppDelegate.h"

SDKDelegate* SDKDelegate::_server_handle = nullptr;

SDKDelegate::SDKDelegate(){
}
SDKDelegate::~SDKDelegate(){
}
SDKDelegate* SDKDelegate::getInstance(){
    if(_server_handle == nullptr){
        _server_handle = new SDKDelegate();
    }
    return _server_handle;
}
void SDKDelegate::init(){
    //1. Setup Callback functions
    Auviis::setOnInitSuccessCallback(std::bind(&SDKDelegate::onInitSuccess, this,std::placeholders::_1));
    
    Auviis::setOnActivatedCallback(std::bind(&SDKDelegate::onActivated, this,std::placeholders::_1));
    
    Auviis::setOnErrorCallback(std::bind(&SDKDelegate::onError, this,std::placeholders::_1,std::placeholders::_2));
    Auviis::setOnDisconnectCallback(std::bind(&SDKDelegate::onDisconnect, this,std::placeholders::_1,std::placeholders::_2));
    
    Auviis::setOnJoinChannelCallback(std::bind(&SDKDelegate::onJoinChannel, this,std::placeholders::_1,std::placeholders::_2, std::placeholders::_3, std::placeholders::_4));
    
    Auviis::setOnReceiveChannelMembersCallback(std::bind(&SDKDelegate::onReceiveChannelMembers, this,std::placeholders::_1,std::placeholders::_2));
    
    Auviis::setOnTextChatReceiveCallback(std::bind(&SDKDelegate::onTextMessage, this,std::placeholders::_1,std::placeholders::_2, std::placeholders::_3));
    
    Auviis::setOnVoiceMessageReady(std::bind(&SDKDelegate::onVoiceMessageReady, this,std::placeholders::_1,std::placeholders::_2));
    
    Auviis::setOnVoiceChatReceiveCallback(std::bind(&SDKDelegate::onVoiceMessage, this,std::placeholders::_1,std::placeholders::_2, std::placeholders::_3));
    
    //2. Setup app id and signature
    Auviis::init("6785JH889bhFGKU8904","PnHDEHHEIhjjAvcgQWUbcv");
    //3. Connect server
//    if (oneclick) Auviis::connect("127.0.0.1",8088);
    if (oneclick) Auviis::connect();
}

void SDKDelegate::onError(int code, std::string reason){
    std::cout << reason << std::endl;
    updateChatContent([[NSString alloc] initWithFormat:@"sdk connection error: %s", reason.c_str()]);
}
void SDKDelegate::onDisconnect(int code, std::string reason){
    std::cout << reason << std::endl;
    updateChatContent(@"sdk connection closed");
}
#pragma --
#pragma SDKCALLBACK
void SDKDelegate::onInitSuccess(int64_t peer_id){
    printf("onInitSuccess\n");
    updateChatContent(@"sdk init successfully");
}
void SDKDelegate::onActivated(int64_t peer_id){
    printf("onActivated with id:%lld\n",peer_id);
//    if (channel_id == 0)  {
//        channel_id = 123;//Auviis::createRandomChannel();
//        Auviis::joinChannel(channel_id);
//    }
    updateChatContent(@"sdk activated successfully, joining chanel 123");
    if (oneclick) Auviis::joinChannel(123);
}
void SDKDelegate::onJoinChannel(int code, int64_t channel_id_, int64_t member_count, std::string msg){
//    Auviis::sendTextChat(channel_id, "xyz");
    Auviis::setActiveVoiceChannel(channel_id_);
    if (oneclick) Auviis::startVoiceStream();
    
    updateChatContent(@"sdk join successfully, enable voice stream");
}

void SDKDelegate::onReceiveChannelMembers(int64_t channel_id, std::vector<int64_t> peers){
    printf("onReceiveChannelMembers: having %lu online\n", Auviis::getChannelMembers(123).size());
    NSString *txt = [[NSString alloc] initWithFormat:@"Channel 123 has %lu online members",Auviis::getChannelMembers(123).size()];
    updateChatContent(txt);
}
void SDKDelegate::onTextMessage(int64_t sender_id, int64_t channel_id, std::string msg){
    std::cout << "onTextMessage:" << msg;
}
void SDKDelegate::onVoiceMessage(int64_t sender_id, int64_t channel_id, std::string msg_id){
    std::cout << "onVoiceMessage:" << msg_id;
//    Auviis::playVoiceMessage(msg_id);
    NSString *txt = [[NSString alloc] initWithFormat:@"Channel 123 get voice msg:\n <a href = 'playvoicemsg:%s'>Play Voice Message</a>",msg_id.c_str()];
    updateChatContent(txt);
}
void SDKDelegate::onVoiceMessageReady(int code, long record_id){
    std::cout << "onVoiceMessageReady";
    Auviis::sendVoiceChat(123);
}

#pragma --

void SDKDelegate::updateChatContent( NSString* txt){
    
    dispatch_async(dispatch_get_main_queue(), ^{
        ViewController *rootController = (ViewController*)[[(AppDelegate*)
                                         [[UIApplication sharedApplication] delegate] window] rootViewController];
        [rootController updateChatContent:txt];
        
    });
}

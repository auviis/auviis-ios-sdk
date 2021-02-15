#import "SDKDelegate.h"


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
    Auviis::getInstance()->setOnInitSuccessCallback(std::bind(&SDKDelegate::onInitSuccess, this,std::placeholders::_1));
    
    Auviis::getInstance()->setOnActivatedCallback(std::bind(&SDKDelegate::onActivated, this,std::placeholders::_1));
    
    Auviis::getInstance()->setOnErrorCallback(std::bind(&SDKDelegate::onError, this,std::placeholders::_1,std::placeholders::_2));
    
    Auviis::getInstance()->setOnJoinChannelCallback(std::bind(&SDKDelegate::onJoinChannel, this,std::placeholders::_1,std::placeholders::_2, std::placeholders::_3, std::placeholders::_4));
    
    Auviis::getInstance()->setOnTextChatReceiveCallback(std::bind(&SDKDelegate::onTextMessage, this,std::placeholders::_1,std::placeholders::_2, std::placeholders::_3));
    
    Auviis::getInstance()->setOnVoiceMessageReady(std::bind(&SDKDelegate::onVoiceMessageReady, this,std::placeholders::_1,std::placeholders::_2));
    
    Auviis::getInstance()->setOnVoiceChatReceiveCallback(std::bind(&SDKDelegate::onVoiceMessage, this,std::placeholders::_1,std::placeholders::_2, std::placeholders::_3));
    
    //2. Setup app id and signature
    Auviis::getInstance()->init("6785JH889bhFGKU8904","PnHDEHHEIhjjAvcgQWUbcv");
    //3. Connect server
    if (oneclick) Auviis::getInstance()->connect();
}

void SDKDelegate::onError(int code, std::string reason){
    std::cout << reason << std::endl;
}
#pragma --
#pragma SDKCALLBACK
void SDKDelegate::onInitSuccess(int64_t peer_id){
    printf("onInitSuccess\n");
}
void SDKDelegate::onActivated(int64_t peer_id){
    printf("onActivated with id:%lld\n",peer_id);
//    if (channel_id == 0)  {
//        channel_id = 123;//Auviis::getInstance()->createRandomChannel();
//        Auviis::getInstance()->joinChannel(channel_id);
//    }
    if (oneclick) Auviis::getInstance()->joinChannel(123);
}
void SDKDelegate::onJoinChannel(int code, int64_t channel_id_, int64_t member_count, std::string msg){
    printf("onJoinChannel\n");
//    Auviis::getInstance()->sendTextChat(channel_id, "xyz");
    Auviis::getInstance()->setActiveVoiceChannel(channel_id_);
    if (oneclick) Auviis::getInstance()->startVoiceStream();
}
void SDKDelegate::onTextMessage(int64_t sender_id, int64_t channel_id, std::string msg){
    std::cout << "onTextMessage:" << msg;
}
void SDKDelegate::onVoiceMessage(int64_t sender_id, int64_t channel_id, std::string msg_id){
    std::cout << "onVoiceMessage:" << msg_id;
    Auviis::getInstance()->playVoiceMessage(msg_id);
}
void SDKDelegate::onVoiceMessageReady(int code, long record_id){
    std::cout << "onVoiceMessageReady";
    Auviis::getInstance()->sendVoiceChat(123);
}

#pragma --

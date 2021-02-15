#ifndef Viavoice_hpp
#define Viavoice_hpp
#include <iostream>
#include <string>
#include <vector>

class Auviis {
public:
    Auviis();
    ~Auviis();
public:
    static Auviis *getInstance();
public:
    /*
     
     */
    int64_t getUniqueId();
    int64_t createRandomChannel();
    //void joinChannel(int64_t channel_id);
    void setActiveVoiceChannel(int64_t channel_id);
    void sendTextChat(int64_t channel_id, std::string msg);
    //Voice text
    void recordVoice();
    void playRecord();
    void stopRecord();
    void sendVoiceChat(int64_t channel_id);
    std::string getRecordId();
    void playVoiceMessage(std::string msg_id);
public:
    void init(const char * id, const char * signature);
    void connect();
    void connect(std::string server_address,uint32_t port, bool ssl = false);
    void disconnect();
    void stop();
    bool ready();
public:
    void joinChannel(int64_t channel_id);
    void leaveChannel(int64_t channel_id);
public:
    void sendTextChat(std::string text);
public:
    void startVoiceStream();
    void stopVoiceStream();
    bool isVoiceStreamEnable();
public:
    void muteSend();
    void unmuteSend();
public:
    void outputToDefault();
    void outputToSpeaker();
    void outputToBluetooth();
//Audio
public:
    bool audioReady();
    void setLocalLoop(bool loop);
    void enableAudio();
    void disableAudio();
public:
    void setOnErrorCallback(std::function<void(int, std::string)>  onErrorCallback);
    std::function<void(int, std::string)> getOnErrorCallback();
    //
    void setOnInitSuccessCallback(std::function<void(int64_t)>  onErrorCallback);
    std::function<void(int64_t)> getOnInitSuccessCallback();
    //
    void setOnJoinChannelCallback(std::function<void(int, int64_t, int64_t, std::string)>  onJoinChannelCallback);
    std::function<void(int, int64_t, int64_t, std::string)> getOnJoinChannelCallback();
    //
    void setOnReleaseChannelCallback(std::function<void(int64_t, int64_t)>  onReleaseChannelCallback);
    std::function<void(int64_t, int64_t)> getOnReleaseChannelCallback();
    //
    void setOnTextChatReceiveCallback(std::function<void(int64_t, int64_t, std::string)>  onTextChatReceiveCallback);
    std::function<void(int64_t, int64_t, std::string)> getOnTextChatReceiveCallback();
    //
    void setOnVoiceChatReceiveCallback(std::function<void(int64_t, int64_t, std::string)>  onVoiceChatReceiveCallback);
    std::function<void(int64_t, int64_t, std::string)> getOnVoiceChatReceiveCallback();
    //
    void setOnDisconnectCallback(std::function<void(int, std::string)>  onDisconnectCallback);
    std::function<void(int, std::string)> getOnDisconnectCallback();
    //
    void setOnActivatedCallback(std::function<void(int64_t)>  onActivatedCallback);
    std::function<void(int64_t)> getOnActivatedCallback();
    //
    void setOnVoiceMessageReady(std::function<void(int, long)> onRecordVoiceSuccessCallback);
    std::function<void(int, long)> getOnVoiceMessageReadyCallback();
    //
    void setOnRecordVoiceError(std::function<void(int,std::string )> onRecordVoiceErrorCallback);
    std::function<void(int, std::string)> getOnRecordVoiceErrorCallback();
private:
    void setUniqueId(int64_t id);
private:
    std::function<void(int, std::string)> onErrorFunc = nullptr;
    std::function<void(int64_t)> onInitSuccessFunc = nullptr;
    std::function<void(int, int64_t, int64_t, std::string)> onJoinChannelFunc = nullptr;
    std::function<void(int64_t, int64_t)> onReleaseChannelFunc = nullptr;
    std::function<void(int64_t, int64_t, std::string)> onTextChatReceiveFunc = nullptr;
    std::function<void(int64_t, int64_t, std::string)> onVoiceChatReceiveFunc = nullptr;
    std::function<void(int, std::string)> onDisconnectFunc = nullptr;
    std::function<void(int64_t)> onActivatedFunc = nullptr;
    std::function<void(int, long)> onRecordVoiceSuccessFunc = nullptr;
    std::function<void(int,std::string )> onRecordVoiceErrorFunc = nullptr;
};


#endif /* Viavoice_hpp */

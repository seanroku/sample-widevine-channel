' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

' 1st function that runs for the scene component on channel startup
sub init()
  'To see print statements/debug info, telnet on port 8089
  m.Image       = m.top.findNode("Image")
  m.ButtonGroup = m.top.findNode("ButtonGroup")
  m.Details     = m.top.findNode("Details")
  m.Title       = m.top.findNode("Title")
  m.Video       = m.top.findNode("Video")
  setVideoContent()

  'Change the details
  m.Image.uri="pkg:/images/channel-poster_fhd.png"
  m.Title.text = "WideVine DRM Test Stream Samples"
  m.Details.text =  "Testing Google Sample Endpoints: " + chr(10) + "WV: Secure SD & HD (cenc,MP4,H264) "

  'Change the buttons
  Buttons = ["Play"]
  m.ButtonGroup.buttons = Buttons
  m.ButtonGroup.setFocus(true)
  m.ButtonGroup.observeField("buttonSelected","onButtonSelected")
end sub

'Set your information here
sub setVideoContent()
  'configure video and DRM settings
  ContentNode = CreateObject("roSGNode", "ContentNode")
  ContentNode.streamFormat = "dash"
  ContentNode.url = "https://storage.googleapis.com/wvmedia/cenc/h264/tears/tears.mpd"
  ' configure DRM here
  drmParams = {
      keySystem: "Widevine"
      licenseServerURL: "https://proxy.uat.widevine.com/proxy?provider=widevine_test"
  }
  ? "set content node DRM parameters to: " drmParams
  ContentNode.drmParams = drmParams

  m.Video.content = ContentNode
end sub

' Called when a key on the remote is pressed
function onKeyEvent(key as String, press as Boolean) as Boolean
  print "key press: " key
  if press then
    if key = "back"
      print "------ [back pressed] ------"
      return true
    else if key = "OK"
      print "------- [ok pressed] -------"
      return true
    end if
  end if
  return false
end function


sub onButtonSelected()
  'Ok'
  if m.ButtonGroup.buttonSelected = 0
    m.Video.visible = "true"
    m.Video.control = "play"
    m.Video.setFocus(true)
  end if
end sub

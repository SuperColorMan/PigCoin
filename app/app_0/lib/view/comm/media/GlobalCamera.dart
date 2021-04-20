import 'package:flutter/cupertino.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

/// -------------------------------
/// Des: 全局相机类
/// -------------------------------
class GlobalCamera{
  static void open(BuildContext context,Function callBack){
    /// 简单调用
    CameraPicker.pickFromCamera(
      context,
      isAllowRecording: true,
    ).then((assetEntity){
      /// 拍摄完毕回传处理
      callBack(assetEntity);
    });
  }
}
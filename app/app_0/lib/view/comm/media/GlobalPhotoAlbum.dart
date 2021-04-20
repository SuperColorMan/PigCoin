import 'package:flutter/cupertino.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

/// -------------------------------
/// Des: 全局相机类
/// -------------------------------
class GlobalPhotoAlbum {
  /// 是否编辑
  static void open(BuildContext context, Function callBack, {int maxAssets}) {
    /// 简单调用
    AssetPicker.pickAssets(context,
            maxAssets: maxAssets != null ? maxAssets : 9)
        .then((assetEntityList) {
      callBack(assetEntityList);
    });
  }
}

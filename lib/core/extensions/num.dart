import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Extension for num to provide screen size utilities
extension ScreenSizeScreenUtils on num {
  /// Adapted to the device width of the UI Design.
  /// Height can also be adapted according to this to ensure no deformation ,
  /// if you want a square
  double get w => ScreenUtil().setWidth(this);

  /// Highly adaptable to the device according to UI Design
  /// It is recommended to use this method to achieve a high degree of adaptation
  /// when it is found that one screen in the UI design
  /// does not match the current style effect, or if there is a difference in shape.
  double get h => ScreenUtil().setHeight(this);

  ///Adapt according to the smaller of width or height
  double get r => ScreenUtil().radius(this);

  /// Adapt according to the both width and height
  double get dg => ScreenUtil().diagonal(this);

  /// Adapt according to the maximum value of scale width and scale height
  double get dm => ScreenUtil().diameter(this);

  /// Font size adaptation method
  /// 'fontSize' The size of the font on the UI design, in dp.
  double get sp => ScreenUtil().setSp(this);

  ///Multiple of screen width
  double get sw => ScreenUtil().screenWidth * this;

  ///Multiple of screen height
  double get sh => ScreenUtil().screenHeight * this;
}

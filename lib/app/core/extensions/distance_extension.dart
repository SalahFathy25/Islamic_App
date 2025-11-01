

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension Distance on int {
  Widget get isHeight => SizedBox(height: h);
  Widget get isWidth => SizedBox(width: w);
}

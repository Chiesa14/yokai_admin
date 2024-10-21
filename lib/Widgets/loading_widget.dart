import 'package:flutter/cupertino.dart';

import '../utils/colors.dart';
import '../utils/images.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        MyImageAsset.loading,
        width: 111,
        height: 111,
        color: colorDark,
      ),
    );
  }
}

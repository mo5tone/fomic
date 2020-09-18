import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

extension ExtendedImageStateEx on ExtendedImageState {
  Widget loadStateWidget([bool reload = false]) {
    final size = 100.0;
    Widget result;
    switch (extendedImageLoadState) {
      case LoadState.loading:
        break;
      case LoadState.completed:
        break;
      case LoadState.failed:
        result = reload
            ? GestureDetector(
                child: Icon(
                  Icons.refresh,
                  size: size,
                ),
                onTap: () => reLoadImage(),
              )
            : Icon(
                Icons.broken_image,
                size: size,
              );
        break;
    }
    return result;
  }
}

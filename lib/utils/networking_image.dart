import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart' hide Image;

class NetworkingImage extends StatelessWidget {
  final String url;
  final String semanticLabel;
  final bool excludeFromSemantics;
  final double width;
  final double height;
  final Color color;
  final BlendMode colorBlendMode;
  final BoxFit fit;
  final Alignment alignment;
  final ImageRepeat repeat;
  final Rect centerSlice;
  final bool matchTextDirection;
  final bool gaplessPlayback;
  final FilterQuality filterQuality;
  final Widget Function(ExtendedImageState) loadStateChanged;
  final BoxShape shape;
  final BoxBorder border;
  final BorderRadius borderRadius;
  final Clip clipBehavior;
  final bool enableLoadState;
  final bool Function(Canvas, Rect, Image, Paint) beforePaintImage;
  final void Function(Canvas, Rect, Image, Paint) afterPaintImage;
  final ExtendedImageMode mode;
  final bool enableMemoryCache;
  final bool clearMemoryCacheIfFailed;
  final void Function(ExtendedImageGestureState) onDoubleTap;
  final GestureConfig Function(ExtendedImageState) initGestureConfigHandler;
  final bool enableSlideOutPage;
  final BoxConstraints constraints;
  final CancellationToken cancelToken;
  final int retries;
  final Duration timeLimit;
  final Map<String, String> headers;
  final bool cache;
  final double scale;
  final Duration timeRetry;
  final Key extendedImageEditorKey;
  final EditorConfig Function(ExtendedImageState) initEditorConfigHandler;
  final Widget Function(Widget) heroBuilderForSlidingPage;
  final bool clearMemoryCacheWhenDispose;
  final bool handleLoadingProgress;
  final Key extendedImageGestureKey;
  final int cacheWidth;
  final int cacheHeight;
  final bool isAntiAlias;

  Widget _loadStateChanged(ExtendedImageState imageState) {
    final loadState = imageState.extendedImageLoadState;
    Widget widget;
    switch (loadState) {
      case LoadState.failed:
        widget = retries > 0
            ? GestureDetector(
                child: Icon(Icons.refresh),
                onTap: () => imageState.reLoadImage(),
              )
            : Icon(Icons.broken_image);
        break;
      case LoadState.loading:
        widget = Container();
        break;
      case LoadState.completed:
        widget = null;
        break;
    }
    return widget;
  }

  NetworkingImage(
    this.url, {
    Key key,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.filterQuality = FilterQuality.low,
    this.loadStateChanged,
    this.shape,
    this.border,
    this.borderRadius,
    this.clipBehavior = Clip.antiAlias,
    this.enableLoadState = true,
    this.beforePaintImage,
    this.afterPaintImage,
    this.mode = ExtendedImageMode.none,
    this.enableMemoryCache = true,
    this.clearMemoryCacheIfFailed = true,
    this.onDoubleTap,
    this.initGestureConfigHandler,
    this.enableSlideOutPage = false,
    this.constraints,
    this.cancelToken,
    this.retries = 3,
    this.timeLimit,
    this.headers,
    this.cache = true,
    this.scale = 1.0,
    this.timeRetry = const Duration(milliseconds: 100),
    this.extendedImageEditorKey,
    this.initEditorConfigHandler,
    this.heroBuilderForSlidingPage,
    this.clearMemoryCacheWhenDispose = false,
    this.handleLoadingProgress = false,
    this.extendedImageGestureKey,
    this.cacheWidth,
    this.cacheHeight,
    this.isAntiAlias = false,
  });

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      url,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      filterQuality: filterQuality,
      loadStateChanged: loadStateChanged ?? _loadStateChanged,
      shape: shape,
      border: border,
      borderRadius: borderRadius,
      clipBehavior: clipBehavior,
      enableLoadState: enableLoadState,
      beforePaintImage: beforePaintImage,
      afterPaintImage: afterPaintImage,
      mode: mode,
      enableMemoryCache: enableMemoryCache,
      onDoubleTap: onDoubleTap,
      initGestureConfigHandler: initGestureConfigHandler,
      enableSlideOutPage: enableSlideOutPage,
      constraints: constraints,
      cancelToken: cancelToken,
      retries: retries,
      timeLimit: timeLimit,
      headers: headers,
      cache: cache,
      scale: scale,
      timeRetry: timeRetry,
      extendedImageEditorKey: extendedImageEditorKey,
      initEditorConfigHandler: initEditorConfigHandler,
      heroBuilderForSlidingPage: heroBuilderForSlidingPage,
      clearMemoryCacheWhenDispose: clearMemoryCacheWhenDispose,
      handleLoadingProgress: handleLoadingProgress,
      extendedImageGestureKey: extendedImageGestureKey,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      isAntiAlias: isAntiAlias,
    );
  }
}

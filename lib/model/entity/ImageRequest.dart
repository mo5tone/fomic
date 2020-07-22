class ImageRequest {
  final String url;
  final Map<String, String> headers;

  ImageRequest(this.url, {this.headers = const {}});
}

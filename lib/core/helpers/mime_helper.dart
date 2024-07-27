import 'package:mime/mime.dart';

enum MimeType { video, image, unknown }

class MimeHelper {
  const MimeHelper._();

  static MimeType getMimeType(String path) {
    final mimeType = lookupMimeType(path);
    final fileType = mimeType != null && mimeType.length > 1
        ? mimeType.split('/').first
        : '';

    if (fileType == 'video') {
      return MimeType.video;
    } else if (fileType == 'image') {
      return MimeType.image;
    }
    return MimeType.unknown;
  }
}

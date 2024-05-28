import 'package:direct_link/direct_link.dart';

class FileChecker {
  final DirectLink link = DirectLink();

  Future<SiteModel?> checkUrl(String url) async {
    SiteModel? data = await link.check(url);
    if (data != null) {
      return data;
    } else {
      return null;
    }
  }
}

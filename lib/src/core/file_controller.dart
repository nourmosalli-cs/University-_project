import 'package:supabase_flutter/supabase_flutter.dart';

class FileController {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> deleteFile(String imageUrl, String bucketName) async {
    try {
      var list = imageUrl.split('/');
      var index = list.indexWhere(
        (element) => element == bucketName,
      );
      String dTemp = "";
      for (int i = index + 1; i < list.length; i++) {
        if (list.length - 1 == i) {
          var imageUrl =
              Uri.parse(list[list.length - 1]).replace(queryParameters: {
            "t": "",
          }).toString();
          imageUrl = imageUrl.replaceAll("?t", "");
          dTemp += imageUrl;
        } else {
          dTemp += "${list[i]}/";
        }
      }
      await Supabase.instance.client.storage.from(bucketName).remove([dTemp]);
    } catch (e) {
      throw Exception('Failed to delete File');
    }
  }
}

import 'package:path_provider/path_provider.dart';

getStorageDirectory() async {
  final dir = await getApplicationDocumentsDirectory();
  return dir.path;
}

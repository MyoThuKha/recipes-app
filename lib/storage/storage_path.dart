// this service will handle the app's stored path via path_provider
import 'package:path_provider/path_provider.dart';

class PathService {
  final String coversPath = "covers/";

  const PathService();

  Future<String> getStoragePath() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return path;
  }
 
}

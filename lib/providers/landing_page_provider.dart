import 'package:recipes/providers/base_provider.dart';
import 'package:recipes/storage/perferences_manager.dart';

class LandingPageProvider extends BaseProvider {
  final PerferencesManager perferencesManager;

  LandingPageProvider({required this.perferencesManager});

  void toggleFirstTimeStatus() {
    perferencesManager.setFirstTimeUser(false);
  }
}

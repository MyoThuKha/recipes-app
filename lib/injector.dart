import 'package:get_it/get_it.dart';
import 'package:recipes/storage/storage_manager.dart';
import 'package:recipes/storage/storage_path.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Register your services here
  // Example:
  getIt.registerLazySingleton<PathService>(() => const PathService());
  getIt.registerLazySingleton<StorageManager>(() => StorageManager());
}
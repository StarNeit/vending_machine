import 'package:get_it/get_it.dart';
import 'package:vending_machine/central_logic/controllers/filling_controller.dart';
import 'package:vending_machine/central_logic/controllers/home_controller.dart';
import 'package:vending_machine/central_logic/controllers/statistics_controller.dart';

Future<void> setupDi() async {
  final getIt = GetIt.I;
  await controllers(getIt);
  return;
}

Future<void> controllers(GetIt getIt) async {
  getIt.registerLazySingleton<HomeController>(() => HomeController());
  getIt.registerLazySingleton<FillingController>(() => FillingController());
  getIt.registerLazySingleton<StatisticController>(() => StatisticController());
}

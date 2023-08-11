import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDi();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<HomeCubit>(
        create: (context) => HomeCubit()..initializeDatabase(),
      ),
      BlocProvider<StatisticsCubit>(
        create: (context) => StatisticsCubit(),
      ),
      BlocProvider<FillingCubit>(
        create: (context) => FillingCubit(),
      ),
    ],
    child: const AppDelegate(
      initialRoute: AppRoutes.HOME,
    ),
  ));
}

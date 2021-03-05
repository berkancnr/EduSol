import 'package:edusol/core/constans/app/local_datas.dart';
import 'package:edusol/core/constans/app/time_converter.dart';
import 'package:get_it/get_it.dart';

import 'app/global_variables.dart';

GetIt locator = GetIt.I;

void setupLocator() async {
  locator.registerLazySingleton(() => GlobalVariables());
  locator.registerLazySingleton(() => LocalDatas());
  locator.registerLazySingleton(() => TimeConverter());
}

import 'package:boilerplate_flutter/injector.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(generateForDir: ['lib', 'test'])
void configureDependencies() => getIt.init();

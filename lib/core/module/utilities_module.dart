import 'package:cron/cron.dart';
import 'package:injectable/injectable.dart';

@module
abstract class UtilityModule{
  @lazySingleton
  Cron get cron => Cron();
}
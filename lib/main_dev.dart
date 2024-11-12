import 'package:app_agendamento/core/flavor_config.dart';

import 'app.dart';

void main() {
  bootstrap(FlavorConfig(baseUrl: 'baseUrlDev', flavor: AppFlavor.dev));
}

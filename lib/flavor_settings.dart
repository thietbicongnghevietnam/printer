enum FlavorEnvironment {
  development,
  staging,
  production;

  String get baseUrl => switch (this) {
        development => 'http://192.168.128.131:8010',
        staging => 'http://192.168.128.131:8011',
        production => 'http://10.92.184.22:8093',
      };
}

class FlavorSettings {
  FlavorSettings.development() : env = FlavorEnvironment.development;

  FlavorSettings.staging() : env = FlavorEnvironment.staging;

  FlavorSettings.production() : env = FlavorEnvironment.production;

  final FlavorEnvironment env;

  String get baseUrl => env.baseUrl;
}

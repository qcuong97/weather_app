enum FlavorType {
  dev('dev'),
  prod('prod');

  final String type;

  const FlavorType(this.type);
}

class FlavorConfig {
  late Map<String, dynamic> variables;
  late FlavorType type;

  static final FlavorConfig _inst = FlavorConfig._internal();

  FlavorConfig._internal();

  static FlavorConfig get instance => _inst;

  factory FlavorConfig(
      {required Map<String, dynamic> variables, required FlavorType type}) {
    _inst.variables = variables;
    _inst.type = type;
    return _inst;
  }

  String get apiUrl => variables['DEFINE_API_URL'];
}

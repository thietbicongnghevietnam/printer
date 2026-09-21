enum Role {
  receiving('Receiving'),
  storage('Storage'),
  kitting('Kitting'),
  supply('Supply'),
  inventory('Inventory');

  const Role(this.code);

  factory Role.fromCode(String code) {
    return Role.values.firstWhere((element) => element.code == code);
  }

  final String code;
}
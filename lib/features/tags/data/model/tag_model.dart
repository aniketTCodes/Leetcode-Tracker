class TagModel {
  final String name;
  final int a;
  final int r;
  final int g;
  final int b;

  TagModel(
      {required this.name,
      required this.a,
      required this.r,
      required this.g,
      required this.b});

  factory TagModel.fromFirestore(Map<String, dynamic> map) {
    return TagModel(
        name: map['name'], a: map['a'], r: map['r'], g: map['g'], b: map['b']);
  }

  Map<String, dynamic> toFirestore() {
    return {'name': name, 'a': a, 'r': r, 'g': g, 'b': b};
  }
}

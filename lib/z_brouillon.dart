// Copiez dans DartPad et exécutez.
class Point {
  final int x;
  final int y;

  // 1) Génératif par défaut: positionnels requis
  Point(this.x, this.y);

  // 2) Positionnels optionnels avec valeurs par défaut
  Point.opt([this.x = 0, this.y = 0]);

  // 3) Només (y optionnel, x requis)
  Point.named({required this.x, this.y = 0});

  // 4) Redirection vers un autre constructeur
  Point.zero() : this(0, 0);

  // 5) Liste d’initialisation (assert + calcul)
  Point.nonNeg(int x, int y)
      : assert(x >= 0 && y >= 0),
        x = x,
        y = y;

  // 6) Const constructor (tous les champs sont final)
  const Point.c(this.x, this.y);

  // 7) Named + liste d’init à partir d’un Map
  Point.fromJson(Map<String, int> json)
      : x = json['x'] ?? 0,
        y = json['y'] ?? 0;

  // 8) Factory: peut normaliser, parser, ou retourner un cache
  static final Map<String, Point> _cache = {};
  factory Point.parse(String s) {
    final parts = s.split(',');
    final key = s.trim();
    return _cache.putIfAbsent(key, () {
      final xi = int.parse(parts[0]);
      final yi = int.parse(parts[1]);
      return Point(xi, yi);
    });
  }

  @override
  String toString() => 'Point($x,$y)';
}

// 9) Super-parameters et appel super dans la hiérarchie
class Base {
  final int a;
  final int b;
  const Base({required this.a, this.b = 0});
}

class Derived extends Base {
  final int c;

  // Transfert direct vers les paramètres nommés de Base
  const Derived({required super.a, super.b, this.c = 0});

  // Autre forme: positionnel + super(...) en liste d’init
  const Derived.alt(this.c, int a) : super(a: a);
}

void main() {
  // print(Point(1, 2)); // Point(1,2)
  print(Point.opt()); // Point(0,0)
  print(Point.named(x: 5)); // Point(5,0)
  print(Point.zero()); // Point(0,0)
  print(Point.nonNeg(3, 4)); // Point(3,4)
  const p1 = Point.c(1, 1);
  const p2 = Point.c(1, 1);
  print(identical(p1, p2)); // true (const canonicalization)
  print(Point.fromJson({'x': 7})); // Point(7,0)
  print(Point.parse('8,9')); // Point(8,9)
  print(Point.parse('8,9')); // même instance que ci-dessus (cache)

  const d1 = Derived(a: 10, b: 2, c: 3);
  const d2 = Derived.alt(5, 11);
  print('${d1.a},${d1.b},${d1.c}'); // 10,2,3
  print('${d2.a},${d2.b},${d2.c}'); // 11,0,5
}

class Car {
  final int weight;
  final String color;

  Car({
    required this.weight,
    required this.color,
  });
}

class BMWCar extends Car {
  final bool isOld;
  BMWCar({
    required super.weight,
    required super.color,
    required this.isOld,
  });
}

class MersedesCar extends Car {
  final int seatsCount;

  MersedesCar({
    required super.weight,
    required super.color,
    required this.seatsCount,
  });
}

void main() {
  final bmw1 = BMWCar(
    weight: 120,
    color: 'White',
    isOld: true,
  );

  final mrs1 = MersedesCar(
    weight: 120,
    color: 'Gold',
    seatsCount: 5,
  );

  final mrs2 = MersedesCar(
    weight: 120,
    color: 'Black',
    seatsCount: 2,
  );

  print({bmw1, mrs1, mrs2});

  final allCars = [bmw1, mrs1, mrs2];

  print(allCars.length);
}

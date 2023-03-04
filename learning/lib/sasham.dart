class Car {
    final int weight;
    final String color;

    void drive (){
        print ("Ми їдемо на машині");
    }

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

class MercedesCar extends Car {
    final int seatsCount;

    
MercedesCar({
    required super.weight,
    required super.color,
    required this. seatsCount,
});
}

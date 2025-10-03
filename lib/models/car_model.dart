class CarModel {
  final String id;
  final String brand;
  final String model;
  final String location;
  final String imageUrl;
  final double pricePerDay;
  final String currency;
  final double rating;
  final String vendor;
  final List<String> features;
  bool isFavorite;

  CarModel({
    required this.id,
    required this.brand,
    required this.model,
    required this.location,
    required this.imageUrl,
    required this.pricePerDay,
    this.currency = '\$',
    required this.rating,
    required this.vendor,
    this.features = const [],
    this.isFavorite = false,
  });

  String get displayName => '${brand.toUpperCase()}, $model'.trim();
}

// Sample data similar to the provided design
final List<CarModel> sampleCars = [
  CarModel(
    id: 'c1',
    brand: 'Toyota',
    model: 'Corolla',
    location: 'New Cairo',
    imageUrl:
        'https://images.unsplash.com/photo-1563720223185-11003d516935?w=1200',
    pricePerDay: 700,
    rating: 4.6,
    vendor: 'Uber',
    features: ['Automatic', 'A/C', '5 Seats'],
  ),
  CarModel(
    id: 'c2',
    brand: 'Mitsubishi',
    model: 'Lancer',
    location: '6 October',
    imageUrl:
        'https://images.unsplash.com/photo-1583121274602-3e2820c69888?w=1200',
    pricePerDay: 525,
    rating: 4.5,
    vendor: 'Uber',
    features: ['Manual', 'A/C', '5 Seats'],
  ),
  CarModel(
    id: 'c3',
    brand: 'Cherry',
    model: 'Tiggo',
    location: '5th Settlement',
    imageUrl:
        'https://images.unsplash.com/photo-1604749803988-72df0f51f7b7?w=1200',
    pricePerDay: 650,
    rating: 4.7,
    vendor: 'Uber',
    features: ['Automatic', 'A/C', 'SUV'],
  ),
  CarModel(
    id: 'c4',
    brand: 'Opel',
    model: 'Greenland',
    location: 'Al Zamlak',
    imageUrl:
        'https://images.unsplash.com/photo-1549923746-c502d488b3ea?w=1200',
    pricePerDay: 850,
    rating: 4.8,
    vendor: 'Uber',
    features: ['Automatic', 'A/C', '5 Seats'],
  ),
];

// Categorized lists matching other screens
final List<CarModel> featuredCars = [
  sampleCars[0],
  sampleCars[2],
  sampleCars[3],
];

final List<CarModel> popularCars = [
  sampleCars[1],
  sampleCars[0],
  sampleCars[2],
];

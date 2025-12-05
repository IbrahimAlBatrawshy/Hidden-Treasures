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
        'https://images.unsplash.com/photo-1563720223185-11003d516935?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
    pricePerDay: 70,
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
        'https://images.unsplash.com/photo-1583121274602-3e2820c69888?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
    pricePerDay: 52,
    rating: 4.5,
    vendor: 'Uber',
    features: ['Manual', 'A/C', '5 Seats'],
  ),
  CarModel(
    id: 'c6',
    brand: 'Mercedes',
    model: 'C-Class',
    location: 'Dokki',
    imageUrl:
        'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
    pricePerDay: 140,
    rating: 4.8,
    vendor: 'LuxuryCars',
    features: ['Automatic', 'A/C', 'Premium Audio', 'Sunroof'],
  ),
  CarModel(
    id: 'c7',
    brand: 'Honda',
    model: 'Civic',
    location: 'Nasr City',
    imageUrl:
        'https://images.unsplash.com/photo-1542362567-b07e54358753?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
    pricePerDay: 60,
    rating: 4.5,
    vendor: 'BudgetRide',
    features: ['Automatic', 'A/C', '5 Seats'],
  ),
  CarModel(
    id: 'c8',
    brand: 'Hyundai',
    model: 'Elantra',
    location: 'Maadi',
    imageUrl:
        'https://images.unsplash.com/photo-1503376780353-7e6692767b70?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
    pricePerDay: 58,
    rating: 4.4,
    vendor: 'EconomyCars',
    features: ['Automatic', 'A/C', 'Fuel Efficient'],
  ),
  CarModel(
    id: 'c10',
    brand: 'Nissan',
    model: 'Altima',
    location: 'Heliopolis',
    imageUrl:
        'https://images.unsplash.com/photo-1502877338535-766e1452684a?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
    pricePerDay: 70,
    rating: 4.4,
    vendor: 'RentNow',
    features: ['Automatic', 'A/C', '5 Seats'],
  ),
];

// Categorized lists matching other screens
final List<CarModel> featuredCars = [
  sampleCars[0],
  sampleCars[4],
  sampleCars[5],
];

final List<CarModel> popularCars = [
  sampleCars[1],
  sampleCars[2],
];

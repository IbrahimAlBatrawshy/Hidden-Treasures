class Restaurant {
  String imageUrl;
  String name;
  String address;
  double price;
  double rating;
  bool isFavorite;

  Restaurant({
    required this.imageUrl,
    required this.name,
    required this.address,
    required this.price,
    required this.rating,
    this.isFavorite = false,
  });
}

final List<Restaurant> featuredRestaurants = [
  Restaurant(
    imageUrl: 'https://www.eldahan.com/images/El-Dahan-EL-Rehab.jpg?263601136',
    name: 'Eldhan Restaurant',
    address: 'Alice Springs NT 0870, Australia',
    price: 45.0,
    rating: 5.0,
    isFavorite: true,
  ),
  Restaurant(
    imageUrl: 'https://assets.cairo360.com/app/uploads/2023/08/01/312598415_692360272278107_7839690468544265332_n.jpg',
    name: 'حجوجة',
    address: 'El-khanka, Egypt',
    price: 35.0,
    rating: 4.8,
    isFavorite: false,
  ),
  Restaurant(
    imageUrl: 'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=500',
    name: 'Luxury Dining',
    address: 'Cairo, Egypt',
    price: 55.0,
    rating: 4.9,
    isFavorite: false,
  ),
];

final List<Restaurant> popularRestaurants = [
  Restaurant(
    imageUrl: 'https://sceneeats.com/Content/Admin/Uploads/Articles/ArticlesMainPhoto/12754/75d2183d-f2a6-42cb-a0f7-6454dd2e4428.jpg',
    name: 'Mo Bistro',
    address: 'District 5',
    price: 25.0,
    rating: 5.0,
    isFavorite: false,
  ),
  Restaurant(
    imageUrl: 'https://assets.cairo360.com/app/uploads/2023/08/01/312598415_692360272278107_7839690468544265332_n.jpg',
    name: 'حجوجة',
    address: 'Downtown Area',
    price: 20.0,
    rating: 4.7,
    isFavorite: true,
  ),
  Restaurant(
    imageUrl: 'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=300',
    name: 'Garden Restaurant',
    address: 'Park District',
    price: 30.0,
    rating: 4.6,
    isFavorite: false,
  ),
];

class Hotel {
  String imageUrl;
  String name;
  String address;
  double price;
  double rating;
  bool isFavorite;

  Hotel({
    required this.imageUrl,
    required this.name,
    required this.address,
    required this.price,
    required this.rating,
    this.isFavorite = false,
  });
}

final List<Hotel> featuredHotels = [
  Hotel(
    imageUrl:
        'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=500',
    name: 'Marriott Mena House, Cairo',
    address: '6 Pyramids Road, Giza, Egypt',
    price: 4200.0,
    rating: 5.0,
    isFavorite: true,
  ),
  Hotel(
    imageUrl:
        'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=500',
    name: 'Steigenberger Nile Palace Luxor',
    address: 'Khaled Ben El Walid Street, Luxor, Egypt',
    price: 3200.0,
    rating: 4.8,
    isFavorite: false,
  ),
  Hotel(
    imageUrl:
        'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=500',
    name: 'Four Seasons Hotel Cairo at Nile Plaza',
    address: '1089 Corniche El Nil, Garden City, Cairo, Egypt',
    price: 5600.0,
    rating: 4.9,
    isFavorite: false,
  ),
  Hotel(
    imageUrl:
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=500',
    name: 'Hilton Alexandria Corniche',
    address: '544 El Geish Road, Sidi Bishr, Alexandria, Egypt',
    price: 2800.0,
    rating: 4.6,
    isFavorite: false,
  ),
];

final List<Hotel> popularHotels = [
  Hotel(
    imageUrl:
        'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=300',
    name: 'Baron Resort Sharm El Sheikh',
    address: 'Ras Nasrani, Sharm El Sheikh, Egypt',
    price: 3100.0,
    rating: 5.0,
    isFavorite: false,
  ),
  Hotel(
    imageUrl:
        'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=300',
    name: 'Jaz Aquamarine Resort',
    address: 'South Magawish District, Hurghada, Red Sea, Egypt',
    price: 3500.0,
    rating: 4.7,
    isFavorite: true,
  ),
  Hotel(
    imageUrl:
        'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=300',
    name: 'Cairo Pyramids Hotel',
    address: 'Alexandria Desert Road, Giza, Egypt',
    price: 2600.0,
    rating: 4.6,
    isFavorite: false,
  ),
  Hotel(
    imageUrl:
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=300',
    name: 'Rixos Premium Seagate',
    address: 'Nabq Bay, Sharm El Sheikh, Egypt',
    price: 4800.0,
    rating: 4.9,
    isFavorite: true,
  ),

];

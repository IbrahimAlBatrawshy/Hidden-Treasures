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
        'https://images.unsplash.com/photo-1571896349842-33c89424de2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    name: 'Marriott Mena House, Cairo',
    address: '6 Pyramids Road, Giza, Egypt',
    price: 420.0,
    rating: 5.0,
    isFavorite: true,
  ),
  Hotel(
    imageUrl:
        'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    name: 'Steigenberger Nile Palace Luxor',
    address: 'Khaled Ben El Walid Street, Luxor, Egypt',
    price: 320.0,
    rating: 4.8,
    isFavorite: false,
  ),
  Hotel(
    imageUrl:
        'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    name: 'Four Seasons Hotel Cairo at Nile Plaza',
    address: '1089 Corniche El Nil, Garden City, Cairo, Egypt',
    price: 560.0,
    rating: 4.9,
    isFavorite: false,
  ),
  Hotel(
    imageUrl:
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    name: 'Hilton Alexandria Corniche',
    address: '544 El Geish Road, Sidi Bishr, Alexandria, Egypt',
    price: 280.0,
    rating: 4.6,
    isFavorite: false,
  ),
  Hotel(
    imageUrl:
        'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    name: 'JW Marriott Hotel Cairo',
    address: 'Arab League St., Heliopolis, Cairo, Egypt',
    price: 510.0,
    rating: 4.7,
    isFavorite: false,
  ),
];

final List<Hotel> popularHotels = [
  Hotel(
    imageUrl:
        'https://images.unsplash.com/photo-1571896349842-33c89424de2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
    name: 'Baron Resort Sharm El Sheikh',
    address: 'Ras Nasrani, Sharm El Sheikh, Egypt',
    price: 310.0,
    rating: 5.0,
    isFavorite: false,
  ),
  Hotel(
    imageUrl:
        'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
    name: 'Jaz Aquamarine Resort',
    address: 'South Magawish District, Hurghada, Red Sea, Egypt',
    price: 350.0,
    rating: 4.7,
    isFavorite: true,
  ),
  Hotel(
    imageUrl:
        'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
    name: 'Cairo Pyramids Hotel',
    address: 'Alexandria Desert Road, Giza, Egypt',
    price: 260.0,
    rating: 4.6,
    isFavorite: false,
  ),
  Hotel(
    imageUrl:
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
    name: 'Rixos Premium Seagate',
    address: 'Nabq Bay, Sharm El Sheikh, Egypt',
    price: 480.0,
    rating: 4.9,
    isFavorite: true,
  ),
  Hotel(
    imageUrl:
        'https://images.unsplash.com/photo-1496417263034-38ec4f0b665a?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
    name: 'Grand Alexandria Hotel',
    address: 'Corniche, Alexandria, Egypt',
    price: 240.0,
    rating: 4.3,
    isFavorite: false,
  ),

];

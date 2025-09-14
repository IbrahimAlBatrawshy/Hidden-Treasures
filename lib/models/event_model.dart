class Event {
  final String id;
  final String name;
  final String location;
  final String address;
  final String imageUrl;
  final double rating;
  final double price;
  final String date;
  final String time;
  final String description;
  bool isFavorite;
  final String category;
  final int availableTickets;
  final String organizer;

  Event({
    required this.id,
    required this.name,
    required this.location,
    required this.address,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.date,
    required this.time,
    required this.description,
    this.isFavorite = false,
    required this.category,
    required this.availableTickets,
    required this.organizer,
  });

  Event copyWith({
    String? id,
    String? name,
    String? location,
    String? address,
    String? imageUrl,
    double? rating,
    double? price,
    String? date,
    String? time,
    String? description,
    bool? isFavorite,
    String? category,
    int? availableTickets,
    String? organizer,
  }) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      address: address ?? this.address,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      date: date ?? this.date,
      time: time ?? this.time,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
      category: category ?? this.category,
      availableTickets: availableTickets ?? this.availableTickets,
      organizer: organizer ?? this.organizer,
    );
  }
}

// Sample data
List<Event> featuredEvents = [
  Event(
    id: '1',
    name: 'Music Festival 2024',
    location: 'Central Park',
    address: 'New York, NY',
    imageUrl: 'https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?w=500',
    rating: 4.8,
    price: 75.0,
    date: '2024-06-15',
    time: '7:00 PM',
    description: 'Amazing music festival with top artists',
    category: 'Music',
    availableTickets: 150,
    organizer: 'Event Pro',
  ),
  Event(
    id: '2',
    name: 'Food & Wine Expo',
    location: 'Convention Center',
    address: 'San Francisco, CA',
    imageUrl: 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=500',
    rating: 4.6,
    price: 45.0,
    date: '2024-07-20',
    time: '6:00 PM',
    description: 'Culinary experience with world-class chefs',
    category: 'Food & Drink',
    availableTickets: 200,
    organizer: 'Culinary Events',
  ),
  Event(
    id: '3',
    name: 'Tech Conference 2024',
    location: 'Tech Hub',
    address: 'Austin, TX',
    imageUrl: 'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=500',
    rating: 4.9,
    price: 299.0,
    date: '2024-08-10',
    time: '9:00 AM',
    description: 'Latest technology trends and innovations',
    category: 'Technology',
    availableTickets: 500,
    organizer: 'Tech Events Inc',
  ),
];

List<Event> popularEvents = [
  Event(
    id: '4',
    name: 'Art Gallery Opening',
    location: 'Modern Art Museum',
    address: 'Los Angeles, CA',
    imageUrl: 'https://images.unsplash.com/photo-1541961017774-22349e4a1262?w=500',
    rating: 4.5,
    price: 25.0,
    date: '2024-06-25',
    time: '7:30 PM',
    description: 'Contemporary art exhibition',
    category: 'Art',
    availableTickets: 80,
    organizer: 'Art Gallery',
  ),
  Event(
    id: '5',
    name: 'Comedy Night',
    location: 'Comedy Club',
    address: 'Chicago, IL',
    imageUrl: 'https://images.unsplash.com/photo-1515187029135-18ee286d815b?w=500',
    rating: 4.7,
    price: 35.0,
    date: '2024-07-05',
    time: '8:00 PM',
    description: 'Stand-up comedy show',
    category: 'Entertainment',
    availableTickets: 120,
    organizer: 'Comedy Central',
  ),
  Event(
    id: '6',
    name: 'Yoga Retreat',
    location: 'Mountain Resort',
    address: 'Denver, CO',
    imageUrl: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=500',
    rating: 4.8,
    price: 150.0,
    date: '2024-08-15',
    time: '6:00 AM',
    description: 'Weekend yoga and meditation retreat',
    category: 'Wellness',
    availableTickets: 50,
    organizer: 'Wellness Center',
  ),
  Event(
    id: '7',
    name: 'Wine Tasting',
    location: 'Vineyard',
    address: 'Napa Valley, CA',
    imageUrl: 'https://images.unsplash.com/photo-1506377247377-2a5b3b417ebb?w=500',
    rating: 4.6,
    price: 65.0,
    date: '2024-09-10',
    time: '5:00 PM',
    description: 'Premium wine tasting experience',
    category: 'Food & Drink',
    availableTickets: 40,
    organizer: 'Wine Society',
  ),
];

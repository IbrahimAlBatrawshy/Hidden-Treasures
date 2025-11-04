import 'package:flutter/material.dart';
import '../../models/event_model.dart';
import '../../constants/app_colors.dart';
import 'event_details_screen.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final List<Event> _allEvents;
  List<Event> _filteredEvents = [];

  @override
  void initState() {
    super.initState();
    _allEvents = [...featuredEvents, ...popularEvents];
    _filteredEvents = _allEvents;
    _searchController.addListener(_filterEvents);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterEvents);
    _searchController.dispose();
    super.dispose();
  }

  void _filterEvents() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredEvents = _allEvents.where((event) {
        return event.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _toggleFavorite(Event event) {
    setState(() {
      event.isFavorite = !event.isFavorite;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          event.isFavorite
              ? 'Added ${event.name} to favorites'
              : 'Removed ${event.name} from favorites',
        ),
        backgroundColor:
            event.isFavorite ? AppColors.favorite : AppColors.textSecondary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 25),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Events',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for events...',
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.textLight),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          // Events List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _filteredEvents.length,
              itemBuilder: (BuildContext context, int index) {
                final event = _filteredEvents[index];
                return _buildEventListItem(event);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventListItem(Event event) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsScreen(event: event),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        shadowColor: AppColors.shadowLight,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                event.imageUrl,
                width: 120,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 120,
                  height: 140,
                  color: AppColors.backgroundSecondary,
                  child: const Icon(Icons.event, color: AppColors.textLight, size: 40),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: SizedBox(
                  height: 124,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        event.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              event.location,
                              style: const TextStyle(
                                  fontSize: 12, color: AppColors.textSecondary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            '${event.date} at ${event.time}',
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      Text(
                        '\$${event.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Icon(
                  event.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: AppColors.favorite,
                  size: 24,
                ),
                onPressed: () => _toggleFavorite(event),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

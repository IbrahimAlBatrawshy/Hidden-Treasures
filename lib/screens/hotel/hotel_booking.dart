import 'package:flutter/material.dart';
import 'package:hidden_treasures/screens/hotel/hotel_invoice.dart';
import '../../models/hotel_model.dart';
import '../../constants/app_colors.dart';

class HotelBookingScreen extends StatefulWidget {
  final Hotel hotel;

  const HotelBookingScreen({super.key, required this.hotel});

  @override
  State<HotelBookingScreen> createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  DateTime? checkInDate;
  DateTime? checkOutDate;

  int adults = 1;
  int kids = 0;

  String selectedRoom = "Standard Room";

  List<String> roomTypes = [
    "Standard Room",
    "Deluxe Room",
    "Executive Suite",
    "Presidential Suite",
  ];

  Future<void> pickCheckInDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        checkInDate = picked;
        if (checkOutDate != null && checkOutDate!.isBefore(picked)) {
          checkOutDate = null;
        }
      });
    }
  }

  Future<void> pickCheckOutDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: checkInDate ?? DateTime.now(),
      lastDate: DateTime(2030),
      initialDate: checkInDate ?? DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        checkOutDate = picked;
      });
    }
  }

  int getTotalNights() {
    if (checkInDate != null && checkOutDate != null) {
      return checkOutDate!.difference(checkInDate!).inDays;
    }
    return 0;
  }

  double getTotalPrice() {
    return getTotalNights() * widget.hotel.price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: const Text(
          "Booking Details",
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFFFF3E0),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // HOTEL SUMMARY BOX
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.hotel.imageUrl,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.hotel.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ROOM SELECTION
            const Text(
              "Room Type",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: selectedRoom,
              items: roomTypes.map((room) {
                return DropdownMenuItem(value: room, child: Text(room));
              }).toList(),
              onChanged: (value) => setState(() => selectedRoom = value!),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 20),

            // DATE PICKERS
            const Text(
              "Select Dates",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: pickCheckInDate,
                    child: _dateBox("Check-In", checkInDate),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: pickCheckOutDate,
                    child: _dateBox("Check-Out", checkOutDate),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // GUESTS
            const Text(
              "Guests",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            _guestSelector("Adults", adults, (v) => setState(() => adults = v)),
            const SizedBox(height: 10),
            _guestSelector("Kids", kids, (v) => setState(() => kids = v)),

            const SizedBox(height: 25),

            // INVOICE
            const Text(
              "Invoice Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            _invoiceRow("Price per night", "\$${widget.hotel.price.toStringAsFixed(2)}"),
            _invoiceRow("Nights", getTotalNights().toString()),
            const Divider(),
            _invoiceRow("Total", "\$${getTotalPrice().toStringAsFixed(2)}", bold: true),

            const SizedBox(height: 50),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            if (checkInDate == null || checkOutDate == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please select dates")),
              );
              return;
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingInvoiceScreen(
                  hotelName: widget.hotel.name,
                  roomType: selectedRoom,
                  adults: adults,
                  kids: kids,
                  checkIn: checkInDate!,
                  checkOut: checkOutDate!,
                  price: getTotalPrice(),
                ),
              ),
            );
           
          },
          child: const Text(
            "Confirm Booking",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  // WIDGETS
  Widget _dateBox(String title, DateTime? date) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.textLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            date == null ? "Select Date" : "${date.day}/${date.month}/${date.year}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _guestSelector(String title, int value, Function(int) onChange) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 16)),
        Row(
          children: [
            IconButton(
              onPressed: value > 0 ? () => onChange(value - 1) : null,
              icon: const Icon(Icons.remove_circle, color: AppColors.secondary),
            ),
            Text(value.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            IconButton(
              onPressed: () => onChange(value + 1),
              icon: const Icon(Icons.add_circle, color: AppColors.secondary),
            ),
          ],
        )
      ],
    );
  }

  Widget _invoiceRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: bold ? FontWeight.bold : FontWeight.w500)),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: bold ? FontWeight.bold : FontWeight.w500)),
        ],
      ),
    );
  }
}

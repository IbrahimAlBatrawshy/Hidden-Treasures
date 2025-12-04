import 'package:flutter/material.dart';

class BookingInvoiceScreen extends StatelessWidget {
  final String hotelName;
  final String roomType;
  final int adults;
  final int kids;
  final DateTime checkIn;
  final DateTime checkOut;
  final double price;

  const BookingInvoiceScreen({
    super.key,
    required this.hotelName,
    required this.roomType,
    required this.adults,
    required this.kids,
    required this.checkIn,
    required this.checkOut,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hotelName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _itemRow('Room Type', roomType),
            _itemRow('Adults', adults.toString()),
            _itemRow('Kids', kids.toString()),
            _itemRow('Check-in', _formatDate(checkIn)),
            _itemRow('Check-out', _formatDate(checkOut)),

            const Divider(height: 40),

            _itemRow(
              'Total Price',
              '\$${price.toStringAsFixed(2)}',
              isBold: true,
            ),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/payment');
                },
                child: const Text(
                  'Proceed to Payment',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}

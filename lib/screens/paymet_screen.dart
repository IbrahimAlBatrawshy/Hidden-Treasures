import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:hidden_treasures/paymen_funcs.dart';
import '../../constants/app_colors.dart';

class PaymentScreen extends StatefulWidget {
  final String title;
  final String amountText;

  const PaymentScreen({
    super.key,
    required this.title,
    required this.amountText,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        title: const Text(
          'Payment',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CreditCardWidget(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  cardBgColor: AppColors.secondary,
                  textStyle: const TextStyle(color: AppColors.textWhite),
                  onCreditCardWidgetChange: (_) {},
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowLight,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: Row(
                    children: [
                      const Icon(Icons.payment, color: AppColors.secondary),
                      const SizedBox(width: 8),
                      Text(
                        'Total Amount: \$${widget.amountText}',
                        style: TextStyle(
                          color: AppColors.info,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                CreditCardForm(
                  formKey: formKey,
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cvvCode: cvvCode,
                  cardHolderName: cardHolderName,
                  onCreditCardModelChange: (CreditCardModel m) {
                    setState(() {
                      cardNumber = m.cardNumber;
                      expiryDate = m.expiryDate;
                      cardHolderName = m.cardHolderName;
                      cvvCode = m.cvvCode;
                      isCvvFocused = m.isCvvFocused;
                    });
                  },
                  obscureCvv: true,
                  obscureNumber: true,
                  isHolderNameVisible: true,
                  inputConfiguration: InputConfiguration(
                    cardNumberDecoration: InputDecoration(
                      labelText: 'Card Number',
                      hintText: 'XXXX XXXX XXXX XXXX',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.secondary),
                      ),
                    ),
                    expiryDateDecoration: InputDecoration(
                      labelText: 'Expiry Date',
                      hintText: 'MM/YY',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.secondary),
                      ),
                    ),
                    cvvCodeDecoration: InputDecoration(
                      labelText: 'CVV',
                      hintText: 'XXX',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.secondary),
                      ),
                    ),
                    cardHolderDecoration: InputDecoration(
                      labelText: 'Card Holder',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.secondary),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _onPay,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      foregroundColor: AppColors.textWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Pay Now',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPay() async {
  if (formKey.currentState?.validate() ?? false) {
    // Show a temporary "Processing payment" message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Processing your payment...'),
        backgroundColor: AppColors.info,
      ),
    );

    // Simulate successful payment and send confirmation email
    bool emailSent = await sendEventPaymentConfirmation(
      userEmail: "mohameda.ayman@gmail.com", // replace with actual user's email
      userName: cardHolderName.isNotEmpty ? cardHolderName : "Valued Customer",
    );

    if (emailSent) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '✅ Payment successful! A confirmation email has been sent.',
          ),
          backgroundColor: AppColors.success,
          duration: Duration(seconds: 4),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '⚠️ Payment succeeded, but email confirmation failed. Please check your network.',
          ),
          backgroundColor: AppColors.error,
        ),
      );
    }

    // Return to previous screen after a short delay
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enter valid card details'),
        backgroundColor: AppColors.error,
      ),
    );
  }
}

}

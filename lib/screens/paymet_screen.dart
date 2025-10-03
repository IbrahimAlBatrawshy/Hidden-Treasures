import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(color: AppColors.textPrimary),
        ),
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
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
                  textStyle: TextStyle(color: AppColors.textWhite),
                  onCreditCardWidgetChange: (_) {},
                ),

                SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundSecondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: Row(
                    children: [
                      Text(
                        'Amount',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      Spacer(),
                      Text(
                        widget.amountText,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),
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
                  inputConfiguration: const InputConfiguration(
                    cardNumberDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Number',
                      hintText: 'XXXX XXXX XXXX XXXX',
                    ),
                    expiryDateDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Expiry Date',
                      hintText: 'MM/YY',
                    ),
                    cvvCodeDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'CVV',
                      hintText: 'XXX',
                    ),
                    cardHolderDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Card Holder',
                    ),
                  ),
                ),

                SizedBox(height: 24),
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
                    child: Text(
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

  void _onPay() {
    if (formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment submitted .'),
          backgroundColor: AppColors.secondary,
        ),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete valid card details'),
          backgroundColor: AppColors.secondary,
        ),
      );
    }
  }
}

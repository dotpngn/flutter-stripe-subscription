import 'package:flutter/material.dart';

class PaymentButton extends StatelessWidget {
  final String buttonTitle;
  final Function() onPressed;

  const PaymentButton({
    super.key,
    this.buttonTitle = 'Pay order',
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed.call(),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff9381ff),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.credit_card,
                color: Color(0xfff8f7ff),
              ),
              const SizedBox(width: 15),
              Text(
                buttonTitle,
                style: const TextStyle(
                  color: Color(0xfff8f7ff),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

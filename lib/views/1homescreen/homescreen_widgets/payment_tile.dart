import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentTile extends StatelessWidget {
  final String title;
  final String svgPath;
  const PaymentTile({
    super.key,
    required this.svgPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
          context, '/home_page/paymentlist_page/payment_page/',
          arguments: [svgPath, title]),
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Color(0xffDBDBDB),
          ),
        ),
        child: SizedBox(
          height: 115,
          width: 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 1,
                color: Colors.white,
                shape: const CircleBorder(),
                child: Hero(
                  tag: svgPath,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    child: Center(
                      child: SvgPicture.asset(
                        svgPath,
                        fit: BoxFit.contain,
                        height: 25,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

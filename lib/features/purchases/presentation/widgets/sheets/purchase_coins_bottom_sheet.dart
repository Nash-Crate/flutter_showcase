import 'package:flutter/material.dart';

/// A bottom sheet that allows the user to purchase coins.
class PurchaseCoinsBottomSheet extends StatelessWidget {
  /// Constructor for [PurchaseCoinsBottomSheet].
  const PurchaseCoinsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Purchase Coins',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handle coin purchase logic here
            },
            child: const Text('via Paywall'),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle coin purchase logic here
            },
            child: const Text('Buy 100 Coins'),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle coin purchase logic here
            },
            child: const Text('Buy 500 Coins'),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle coin purchase logic here
            },
            child: const Text('Buy 1000 Coins'),
          ),
        ],
      ),
    );
  }
}

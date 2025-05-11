import 'package:flutter/material.dart';

class NutrientInfo extends StatelessWidget {
  final String label, amount, percent;
  final Color color;

  const NutrientInfo({
    super.key,
    required this.label,
    required this.amount,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(amount),
        Text(percent, style: TextStyle(color: color)),
      ],
    );
  }
}

class NutrientsRow extends StatelessWidget {
  const NutrientsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        NutrientInfo(
          label: "Carbs",
          amount: "250g",
          percent: "50%",
          color: Colors.green,
        ),
        NutrientInfo(
          label: "Fat",
          amount: "67g",
          percent: "30%",
          color: Colors.green,
        ),
        NutrientInfo(
          label: "Protein",
          amount: "100g",
          percent: "20%",
          color: Colors.green,
        ),
      ],
    );
  }
}

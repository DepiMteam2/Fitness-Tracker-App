import 'package:fitness_app/src/models/food_item.dart';
import 'package:fitness_app/src/widgets/add_food_item_card.dart';
import 'package:fitness_app/src/widgets/calories_header.dart';
import 'package:fitness_app/src/widgets/calories_progress.dart';
import 'package:fitness_app/src/widgets/nutrients_row.dart';
import 'package:flutter/material.dart';

class CaloriesDetailsScreen extends StatefulWidget {
  const CaloriesDetailsScreen({super.key});

  @override
  State<CaloriesDetailsScreen> createState() => _CaloriesDetailsScreenState();
}

class _CaloriesDetailsScreenState extends State<CaloriesDetailsScreen> {
  final List<FoodItem> breakfastItems = [
    FoodItem(name: 'Apple', quantity: '2 apple', calories: 40),
    FoodItem(name: 'Chicken', quantity: '100g Chicken', calories: 165),
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool showForm = false;

  int get totalCalories =>
      breakfastItems.fold(0, (sum, item) => sum + item.calories);

  double get progress => totalCalories / 2000;

  void addFoodItem() {
    if (formKey.currentState!.validate()) {
      setState(() {
        breakfastItems.add(
          FoodItem(
            name: nameController.text,
            quantity: quantityController.text,
            calories: int.parse(caloriesController.text),
          ),
        );
        nameController.clear();
        quantityController.clear();
        caloriesController.clear();
        showForm = false;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    caloriesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calories Details'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              setState(() {
                showForm = !showForm;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CaloriesHeader(),
                  const SizedBox(height: 16),
                  CaloriesProgress(calories: totalCalories, progress: progress),
                  const SizedBox(height: 20),
                  const NutrientsRow(),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Breakfast",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // ...breakfastItems.map((item) => FoodItemTile(item: item)),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          if (showForm)
            AddFoodItemCard(
              formKey: formKey,
              nameController: nameController,
              quantityController: quantityController,
              caloriesController: caloriesController,
              onSubmit: addFoodItem,
            ),
        ],
      ),
    );
  }
}

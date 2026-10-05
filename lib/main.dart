import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RecipePage(),
    );
  }
}

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("BROWSE CATEGORY"),
            Text("Not sure about exactly which recipe you're looking for? Do a dive into our most popular categories"),
            Text("BY MEAT"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                foodImage("assets/image/Lab3/beef.jpg", "beef", Alignment.center),
                foodImage("assets/image/Lab3/chicken.jpg", "chicken", Alignment.center),
                foodImage("assets/image/Lab3/pork.jpg", "pork", Alignment.center),
                foodImage("assets/image/Lab3/seafood.jpg", "seafood", Alignment.center),
              ],
            ),
            Text("BY COURSE"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                foodImage("assets/image/Lab3/maindish.jpg", "Main Dishes", Alignment.bottomCenter),
                foodImage("assets/image/Lab3/salad.jpg", "Salad Recipes",Alignment.bottomCenter),
                foodImage("assets/image/Lab3/sidedish.jpg", "Side Dishes",Alignment.bottomCenter),
                foodImage("assets/image/Lab3/crockpot.jpg", "Crockpot",Alignment.bottomCenter),
              ],
            ),
            Text("BY DESSERT"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                foodImage("assets/image/Lab3/icecream.jpg", "Ice Cream", Alignment.bottomCenter),
                foodImage("assets/image/Lab3/brownie.jpg", "Brownies",Alignment.bottomCenter),
                foodImage("assets/image/Lab3/pies.jpg", "Pies",Alignment.bottomCenter),
                foodImage("assets/image/Lab3/cookies.jpg", "Cookies",Alignment.bottomCenter),
              ],
            ),
          ]
        ),
      )
    );
  }
  Widget foodImage(String path, String label, Alignment textPosition) {
    return Stack(
      alignment: textPosition,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(path),
          radius: 40,
        ),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            backgroundColor: Colors.white
          )
        )
      ],
    );
  }

}
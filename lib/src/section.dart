import 'package:flutter/material.dart';
import 'package:gemini/src/game/fruit_game.dart';
import 'package:gemini/src/chat%20/home_screen.dart';


class Section extends StatefulWidget {
  const Section({super.key});

  @override
  State<Section> createState() => _SectionState();
}

class _SectionState extends State<Section> {
  @override
  Widget build(BuildContext context) {
    //Media Query
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Gemini Chat"),
      ),
      body:  Center(
        child:  Column(
          children: [
            const Text('switch between case study'),
            SizedBox(height: height*0.02,),
            GestureDetector(
              child: Container(
                height: height*.05,
                width: width*.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black
                ),
                child: const Center(
                  child: Text('Chat with Gamini', style: TextStyle(color: Colors.white),),
                ),
              ),
              onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return const HomeScreen();
                  }));
            },
            ),

            SizedBox(height: height*0.02,),
            GestureDetector(
              child: Container(
                height: height*.05,
                width: width*.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black
                ),
                child: const Center(
                  child: Text('Simple Game with Gemini', style: TextStyle(color: Colors.white),),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return const FruitGame();
                    }));
              },
            )
          ],
        ),
      ),
    );
  }
}

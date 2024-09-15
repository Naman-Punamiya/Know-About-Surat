import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[200],
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            const SizedBox(height: 25),
            Text("Know About Surat", style: GoogleFonts.dmSerifDisplay(
              fontSize: 28,
              color: Colors.black,
            ),),
            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Image.asset('assets/diet.png'),
            ),
            const SizedBox(height: 25),

            Text("The Beauty Of Surat", style: GoogleFonts.dmSerifDisplay(
              fontSize: 44,
              color: Colors.black,
            ),),
            const SizedBox(height: 10),

            Text("Taste the Best Surat Food And Best Places To Explore In Surat", style: TextStyle(
              // fontSize: 44,
              color: Colors.grey[600],
              height: 2
            ),),
            const SizedBox(height: 25,),

            InkWell(
              onTap: () async {
                final pres = await SharedPreferences.getInstance();
                await pres.setBool('hasSeenIntro', true);
                Navigator.pushReplacementNamed(context, '/homepage');
              },
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
                padding: const EdgeInsets.all(20),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Get Started", style: TextStyle(color: Colors.black),),
                    SizedBox(width: 10,),
                    Icon(Icons.arrow_forward, color: Colors.black,)
                  ],
                ),
              ),
            ),
          ]
        ),
      ) 
    );
  }
}
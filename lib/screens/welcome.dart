import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:focus_room/screens/loading.dart';
import 'package:focus_room/services/auth.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final AuthService _auth = AuthService();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
              children: [
                // Main content
                AnimateGradient(
                  primaryColors: [
                    Colors.blue[900]!,
              Colors.white70,
              
            ],
            secondaryColors: [
              Colors.deepPurple[900]!,     
              Colors.white70,
            ],
            //  curve: Curves.elasticInOut,

            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Logo
                  // Container(
                  //   height: 80,
                  //   width: 80,
                  //   decoration: BoxDecoration(
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.blue[600]!.withAlpha(200),
                  //         blurRadius: 20,
                  //         spreadRadius: 2,
                  //         offset: Offset(2, 2),
                  //       ),
                  //     ],
                  //   ),
                  //   child: Image.asset('lib/assets/clock_image.png'),
                  // ),
                  SizedBox(height: 5,),
                  SpinKitPouringHourGlassRefined(
                    color:Colors.blue[900]!,
                    duration: Duration(seconds: 3),
                    strokeWidth: 7,
                    size: 120,
                    ),
                  SizedBox(height: 50),
                  // Texts
                  Text(
                    'Welcome To',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 0),
                  Text(
                    'FocusRoom',
                    style: TextStyle(
                      fontFamily: 'inter',
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  SizedBox(height: 0),
                  Text(
                    'Stay Focused and Productive',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 50),
                  // Button
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AnimateGradient(
                        primaryColors: [
                            Colors.blue[900]!,
                            Colors.blue[900]!
                          ],
                          secondaryColors: [
                          Colors.deepPurple[900]!,
                          Colors.purpleAccent
                        
                          ],
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                          ),
                          onPressed: () async {
                            if (!mounted) return;
                                    
                            setState(() {
                              isLoading = true;
                            });
                                    
                            dynamic result = await _auth.signInAnon();
                                    
                            if (!mounted) return;
                                    
                            if (result == null) {
                              setState(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Sign-in failed! Try again."),
                                ),
                              );
                            } else {
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Continue as Guest',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                size: 40,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Loading overlay
          if (isLoading)
            Container(
              color: Colors.black.withAlpha(150),
              child: const Center(child: Loading()),
            ),
        ],
      ),
    );
  }
}

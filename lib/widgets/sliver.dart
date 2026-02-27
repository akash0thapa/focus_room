import 'package:flutter/material.dart';
import 'package:focus_room/screens/welcome.dart';
import 'package:focus_room/styles/text_design.dart';

class Sliver extends StatelessWidget {
  const Sliver({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 100,
              expandedHeight: 100,
              backgroundColor: Color(0xFF003E8F),
              flexibleSpace: FlexibleSpaceBar(           
              background: Padding(
                padding: EdgeInsetsGeometry.fromLTRB(10, 50, 10, 0),
                child: Column(
                  children: [
                  Text('Welcome To FocusRoom', 
                  style: textDesign.copyWith(fontSize: 30)
                  ),
                Text('Stay Focused and Productive',
                  style: textDesign.copyWith(fontSize: 18,
                  color: Colors.grey[400]) )    
                  ],
                ),
              ),
              ),
            ),
            
            SliverAppBar(
              backgroundColor: Color(0xFF003E8F),
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(               
                background: Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(10, 30, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Rooms',
                      style: textDesign.copyWith(
                        fontSize: 24
                      ),                  
                      ),
                      IconButton(onPressed: (){}, 
                      icon: Icon(Icons.logout_outlined,
                      size: 28,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 10
                        )
                      ]
                      ))
                    ],
                  ),
                ),
                ),
            ),           
            SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lightbulb_outline, 
                  size: 100, 
                  color: Colors.grey[700],),
                   SizedBox(height: 20,),
                  Text('Create New Rooms!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 30,
                    color: Colors.grey),
                    ),
                    Text('Stay Focused and Productive',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700
                    ),)
                ],
              ),
            )
          ],
        ),
      
    );
  }
}
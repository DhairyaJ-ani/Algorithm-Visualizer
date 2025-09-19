import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //drawer header
          Column(
            children: [
              DrawerHeader(
            child: Icon(Icons.favorite,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            ),

            const SizedBox(height: 20,),
          //home tile
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ListTile(
              leading: Icon(Icons.home,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text("Visualizer",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.w600,
              ),
              ),
              onTap: () {
                //aready on home so just pop
                Navigator.pop(context);
              },
            ),
          ),
          //profile tile
           Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ListTile(
              leading: Icon(Icons.auto_graph_sharp,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text("Algorithms",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.w600,
              ),
              ),
              onTap: () {
                //pop the drawer
                Navigator.pop(context);
                //go to profile_page

                Navigator.pushNamed(context, '/algorithms_page');
          
              },
            ),
          ),     
          ],
        ),   
        ],
      ),
      ); 
  }
}
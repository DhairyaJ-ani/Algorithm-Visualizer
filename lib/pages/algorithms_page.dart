import 'package:algorithm_visualizer/algorithms/algos.dart';
import 'package:flutter/material.dart';

class AlgorithmsPage extends StatelessWidget {
  const AlgorithmsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Algorithms",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w600),),
        backgroundColor: Theme.of(context).colorScheme.secondary, 
      ),
      body: ListView.builder(
        
        itemCount: AlgorithmCount.count,
        itemBuilder: (context,index){
          final algo = Algorithm.values[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(12,12,12,0),
            child: ListTile(
            title: Text(algo.toString().split('.').last.replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}').trim(),style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: (){
              // Navigate to algorithm detail page
            },
            hoverColor: Theme.of(context).colorScheme.primary,
            selectedColor: Theme.of(context).colorScheme.primary,
            tileColor: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            ),
          );
        },
        ),
    );
  }
}


// Container(
//               decoration: BoxDecoration(),
//               child: Column(
//                children: [
//                 Text(
//                 algo.toString().split('.').last.replaceAllMapped(RegExp(r'([A-Z])'),(match) => '${match.group(0)}').trim(),
//                   style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text("Approach: ")
//                   ],
//                 )
//                ],
//               ),
//             ),
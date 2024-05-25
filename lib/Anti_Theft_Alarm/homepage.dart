import 'package:antitheftalarm/theme/theme_text.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
        final width=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text('Anti Theft Alarm'),
      centerTitle: true,
      actions: [
        IconButton(onPressed: (){

        }, icon: Icon(Icons.sort))
      ],),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Feature'),
            SizedBox(height: height*0.01,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: height*0.13,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border(
                 bottom: BorderSide(width: 2.0,style: BorderStyle.solid)
                  )
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Intruder Alert',style: Themetext.atextstyle,),
                          Icon(Icons.warning_amber,color: Colors.red,),
                        ],
                      ),
                      
                    ),
                    Text('capture intruder photos upon')
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'HELP & SUPPORT',
        ),
        backgroundColor: const Color.fromARGB(255, 34, 152, 95),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              margin: const EdgeInsets.only(left: 10),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "If you can't find what you need, please reach out to us at [sumitaggarwal12022002@gmail.com]. We're here to assist you.",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      color: Color.fromARGB(255, 12, 85, 94)),
                ),
              ),
            ),
            SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    getQuestionContainer(title: 'About Profile Image'),
                    Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
                      child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                             createRowOfAnswer(
                                'To set Profile Image Long press\n on your Profile In settings'),
                            SizedBox(height: 10,),
                             createRowOfAnswer(
                                'To Delete Profile Image Long press\n on your REMOVE DP\nButton inside settings'),   
                                
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container getQuestionContainer({required String title}) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(left: 10),
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Row createRowOfAnswer(String answer) {
    return  Row(
      children: [
        const Icon(
          Icons.square_outlined,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(answer),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_caliana/const/colors.dart';
import 'package:my_caliana/widgets/clock.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgGrey,
        leading: Container(
          margin: EdgeInsets.only(left: 16),
          child: Image.asset('assets/images/icon-removebg-preview.png'),
        ),
        actions: [
          // Container(
          //   color: Colors.red,
          //   child: Text(
          //     'recruitment',
          //     style: TextStyle(color: customGrey, fontSize: 16),
          //   ),
          // ),
          // Container(
          //   child: Stack(
          //     fit: StackFit.expand,
          //     alignment: Alignment.center,
          //     children: [
          //       CircleAvatar(
          //         backgroundColor: Colors.white,
          //         backgroundImage: AssetImage('assets/images/profile.jpg'),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.only(right: 16),
              child: Material(
                color: Colors.white,
                child: InkWell(
                  child: Icon(
                    Icons.notifications_none_rounded,
                    size: 30,
                    color: customGrey,
                  ),
                ),
              ))
        ],
      ),
      body: Container(
        color: bgGrey,
        child: SingleChildScrollView(
          child: Column(
            children: [Clock()],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number_outlined),
            label: 'Tiket',
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}

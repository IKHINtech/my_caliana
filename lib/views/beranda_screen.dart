import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_caliana/const/colors.dart';
import 'package:my_caliana/views/identitas_screen.dart';
import 'package:my_caliana/widgets/clock.dart';
import 'package:my_caliana/widgets/custom_text_fields.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  ValueNotifier<bool> isDialOpen = ValueNotifier<bool>(false);

  final TextEditingController _searchController = TextEditingController();

  var renderOverlay = true;
  var visibled = true;
  var switchLabelPosition = false;
  var extend = false;
  var mini = false;
  var rmicons = false;
  var customDialRoot = false;
  var closeManually = false;
  var useRAnimation = true;
  var speedDialDirection = SpeedDialDirection.up;
  var buttonSize = const Size(56.0, 56.0);
  var childrenButtonSize = const Size(56.0, 56.0);

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: bgGrey,
      //   leading: Container(
      //     margin: EdgeInsets.only(left: 16),
      //     child: Image.asset('assets/images/icon-removebg-preview.png'),
      //   ),
      //   actions: [
      //     // Container(
      //     //   color: Colors.red,
      //     //   child: Text(
      //     //     'recruitment',
      //     //     style: TextStyle(color: customGrey, fontSize: 16),
      //     //   ),
      //     // ),
      //     // Container(
      //     //   child: Stack(
      //     //     fit: StackFit.expand,
      //     //     alignment: Alignment.center,
      //     //     children: [
      //     //       CircleAvatar(
      //     //         backgroundColor: Colors.white,
      //     //         backgroundImage: AssetImage('assets/images/profile.jpg'),
      //     //       ),
      //     //     ],
      //     //   ),
      //     // ),
      //     Container(
      //         padding: EdgeInsets.all(8),
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           borderRadius: BorderRadius.circular(12),
      //         ),
      //         margin: EdgeInsets.only(right: 16),
      //         child: Material(
      //           color: Colors.white,
      //           child: InkWell(
      //             child: Icon(
      //               Icons.notifications_none_rounded,
      //               size: 30,
      //               color: customGrey,
      //             ),
      //           ),
      //         ))
      //   ],
      // ),
      // body: Container(
      //   color: bgGrey,
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: [Clock()],
      //     ),
      //   ),
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.business),
      //       label: 'Business',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.confirmation_number_outlined),
      //       label: 'Tiket',
      //     ),
      //   ],
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      // ),

      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        color: bgGrey,
        child: customTextField(
            border: false,
            controller: _searchController,
            label: "Cari",
            hint: "Cari Fitur",
            prefixIcon: Icon(Icons.search),
            required: false,
            onSaved: (val) {}),
      ),
      extendBody: true,
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        icon: Icons.add,
        // activeIcon: Icons.add,
        spacing: 2,
        mini: mini,
        openCloseDial: isDialOpen,
        childPadding: const EdgeInsets.all(5),
        spaceBetweenChildren: 4,
        buttonSize: buttonSize,
        label: extend ? const Text("Open") : null,
        activeLabel: extend ? const Text("Close") : null,
        childrenButtonSize: childrenButtonSize,
        visible: visibled,
        direction: speedDialDirection,
        switchLabelPosition: switchLabelPosition,
        closeManually: closeManually,
        renderOverlay: renderOverlay,
        onOpen: () => debugPrint('OPENING DIAL'),
        onClose: () => debugPrint('DIAL CLOSED'),
        useRotationAnimation: useRAnimation,
        tooltip: 'Open Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        elevation: 8.0,
        animationCurve: Curves.elasticInOut,
        isOpenOnStart: false,
        children: [
          SpeedDialChild(
            shape: CircleBorder(),
            child: !rmicons ? const Icon(Icons.document_scanner) : null,
            backgroundColor: Colors.blue[50],
            foregroundColor: Colors.blue[500],
            label: 'Pra Registrasi',
            visible: true,
            onTap: () async {},
          ),
          SpeedDialChild(
            shape: CircleBorder(),
            child: !rmicons ? const Icon(Icons.person_add) : null,
            backgroundColor: Colors.blue[50],
            foregroundColor: Colors.blue[500],
            label: 'Registrasi',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IdentitasScreen(),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipPath(
        clipper: MyBottomAppBarClipper(),
        child: BottomAppBar(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          height: 70,
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Container(
                    color: mainColor,
                    height: 4,
                    width: 50,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.home_filled,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(
                  Icons.confirmation_number_outlined,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyBottomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double notchRadius = 24.0;
    path.moveTo(0, notchRadius);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, notchRadius);
    path.arcToPoint(
      Offset(size.width - notchRadius, 0),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(notchRadius, 0);
    path.arcToPoint(
      Offset(0, notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

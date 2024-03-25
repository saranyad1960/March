
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat_app.dart';

void main() {
  runApp(MyApp7());
}

class MyApp7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebSocket Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MessageScreen(),
    );
  }
}

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    Text('Explore Page'),
    Text('Shop Page'),
    Text('Favorites Page'),
    Text('Account Page'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 0 ? HomeTab() : SizedBox(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: PlusButtonInContainer(),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigoAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}

class PlusButtonInContainer extends StatelessWidget {

  const PlusButtonInContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(50),
          color: Colors.indigoAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}




class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: ListTile(
                  leading: Image.asset('lib/assets/catimage5-removebg-preview.png',),
                  title: Text("Messages",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                  trailing: Icon(Icons.search,color: Colors.grey,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blue.withOpacity(0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20,left: 20,bottom: 10),
                        child: Text("Stories",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                        ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20,bottom: 10,left: 30),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                 padding: EdgeInsets.all(10),
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white,
                                    border: Border.all(color: Colors.blue.shade800, width: 2),
                                  ),
                                  child: Center(child: Image.asset('lib/assets/catimage3.png',)),
                                ),
                                Positioned(
                                  left: 30,
                                  top: 30,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.blue.shade800
                                    ),
                                    child: Center(child: Icon(Icons.add,color: Colors.white,size: 15,),),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20,),
                            Container(
                              padding: EdgeInsets.all(5),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                                border: Border.all(color: Colors.blue.shade800, width: 2),
                              ),
                              child: Center(child: Image.asset('lib/assets/woman1-removebg-preview.png',)),
                            ),
                            SizedBox(width: 20,),
                            Container(
                              padding: EdgeInsets.all(5),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                                border: Border.all(color: Colors.blue.shade800, width: 2),
                              ),
                              child: Center(child: Image.asset('lib/assets/man1-removebg-preview.png',)),
                            ),
                            SizedBox(width: 20,),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                              ),
                              child: Center(child: Image.asset('lib/assets/woman2-removebg-preview.png',)),
                            ),
                            SizedBox(width: 20,),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                              ),
                              child: Center(child: Image.asset('lib/assets/man2-removebg-preview.png',)),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text("Add yours",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              fontFamily: 'Roboto',
                            ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Text("Sofia",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Text("Jack",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 45),
                            child: Text("Maria",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: Text("Samuel",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                                border: Border.all(color: Colors.blue.shade800, width: 2),
                              ),
                              child: Image.asset('lib/assets/woman1-removebg-preview.png',),
                            ),
                          ),
                          Positioned(
                            left: 45,
                            top: 12,
                            child: Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.green.withOpacity(0.9),
                                border: Border.all(color: Colors.white, width: 1),
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Sofia Lee",
                          style: TextStyle(
                            fontSize: 15,fontWeight: FontWeight.w500
                          ),
                          ),
                          Row(
                            children: [
                              Text("wanna play some data?",
                                style: TextStyle(
                                    fontSize: 12,fontWeight: FontWeight.w500,color: Colors.blue
                                ),
                              ),
                              SizedBox(width: 10,),
                              Icon(Icons.local_play,size: 12,)
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("10:20AM",
                              style: TextStyle(
                                  fontSize: 12,fontWeight: FontWeight.w500,color: Colors.grey
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.indigoAccent
                              ),
                              child: Center(child: Text("1",style: TextStyle(color: Colors.white),)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp6(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.indigoAccent, width: 2),
                      color: Colors.blue.withOpacity(0.05),
                    ),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                  border: Border.all(color: Colors.blue.shade800, width: 2),
                                ),
                                child: Image.asset('lib/assets/catimage3.png',),
                              ),
                            ),
                            Positioned(
                              left: 45,
                              top: 12,
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.green.withOpacity(0.9),
                                  border: Border.all(color: Colors.white, width: 1),
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Gurs Nicholson",
                              style: TextStyle(
                                  fontSize: 15,fontWeight: FontWeight.w500
                              ),
                            ),
                            Row(
                              children: [
                                Text("Hey, How are you today ?",
                                  style: TextStyle(
                                      fontSize: 12,fontWeight: FontWeight.w500,color: Colors.blue
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Spacer(),
                        Container(
                         height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.purpleAccent.withOpacity(0.5),
                            border: Border.all(color: Colors.purpleAccent.withOpacity(0.5), width: 2),
                          ),
                          child: Center(child: Icon(Icons.video_camera_back_outlined,color: Colors.purple,size: 18,)),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.redAccent.withOpacity(0.5),
                            border: Border.all(color: Colors.redAccent.withOpacity(0.5), width: 2),
                          ),
                          child: Center(child: Icon(Icons.delete_outline_outlined,color: Colors.red,size: 18,)),
                        ),
                        SizedBox(width: 10,),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                                border: Border.all(color: Colors.blue.shade800, width: 2),
                              ),
                              child: Image.asset('lib/assets/woman2-removebg-preview.png',),
                            ),
                          ),
                          Positioned(
                            left: 45,
                            top: 12,
                            child: Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.green.withOpacity(0.9),
                                border: Border.all(color: Colors.white, width: 1),
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Maria Smith",
                            style: TextStyle(
                                fontSize: 15,fontWeight: FontWeight.w500
                            ),
                          ),
                          Row(
                            children: [
                              Text("Okay, that's cool",
                                style: TextStyle(
                                    fontSize: 12,fontWeight: FontWeight.w500,color: Colors.blue
                                ),
                              ),
                              SizedBox(width: 5,),
                              Icon(Icons.favorite,color: Colors.red,size: 15,)
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("10:20AM",
                              style: TextStyle(
                                  fontSize: 12,fontWeight: FontWeight.w500,color: Colors.grey
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.indigoAccent
                              ),
                              child: Center(child: Text("3",style: TextStyle(color: Colors.white),)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                            border: Border.all(color: Colors.blue.shade800, width: 2),
                          ),
                          child: Image.asset('lib/assets/man1-removebg-preview.png',),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Jack Harris",
                            style: TextStyle(
                                fontSize: 15,fontWeight: FontWeight.w500
                            ),
                          ),
                          Row(
                            children: [
                              Text("yeah bro, I was expecting this",
                                style: TextStyle(
                                    fontSize: 12,fontWeight: FontWeight.w500,color: Colors.grey
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("10:20AM",
                              style: TextStyle(
                                  fontSize: 12,fontWeight: FontWeight.w500,color: Colors.grey
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
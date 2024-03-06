// import 'dart:developer';

// import 'package:database/update.dart';
// import 'package:flutter/material.dart';
// import 'package:database/databasehelper.dart';
// import 'package:flutter/services.dart';

// class Insert extends StatefulWidget {
//   const Insert({super.key});

//   @override
//   State<Insert> createState() => _InsertState();
// }

// class _InsertState extends State<Insert> {
//   final namecontroller = new TextEditingController();
//   final agecontroller = new TextEditingController();
//   List<Map<String, dynamic>> dataList = [];

//   void _saveData() async {
//     final name = namecontroller.text;
//     final age = int.tryParse(agecontroller.text) ?? 0;
//     int insertId = await DatabaseHelper.insertUser(name, age);
//     log("insertid>>>>>>" + insertId.toString());

//      List<Map<String, dynamic>> updateData = await DatabaseHelper.getData();
//     setState(() {
//       dataList = updateData;
//     });
  
//   }

//   @override
//   void initState() {
//     _fetchUser();
//     super.initState();
//   }

//   void _fetchUser() async {
//     List<Map<String, dynamic>> userList = await DatabaseHelper.getData();
//     setState(() {
//       dataList = userList;
//     });
//   }

//    void fetchdata() async {
//     List<Map<String, dynamic>> fetchdata = await DatabaseHelper.getData();
//     setState(() {
//       dataList = fetchdata;
//     });
//   }

//   void delete(int id) async{
//     int id= await DatabaseHelper.deleteData(_id);
//      List<Map<String, dynamic>> updateData = await DatabaseHelper.getData();
//     setState(() {
//       dataList = updateData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(50),
//         child: Container(
//           color: Colors.blueGrey,
//           child: Padding(
//             padding: const EdgeInsets.only(top: 40),
//             child: Column(
//               children: [
//                 Text(
//                   "Insert Record",
//                   style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white,
//                       fontSize: 24),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
//             child: Container(
//               child: TextField(
//                 controller: namecontroller,
//                 decoration: InputDecoration(
//                     labelText: 'Name',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5))),
//               ),
//             ),
//           ),
//           Padding(
//             padding:
//                 const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
//             child: Container(
//               child: TextField(
//                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                 keyboardType: TextInputType.number,
//                 controller: agecontroller,
//                 decoration: InputDecoration(
//                     labelText: 'Age',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5))),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 20, left: 20),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blueGrey),
//                       onPressed: () {
//                         _saveData();
//                         namecontroller.clear();
//                         agecontroller.clear();
//                         setState(() {
                          
//                         });
//                       },
//                       child: Text(
//                         "Insert",
//                         style: TextStyle(color: Colors.white),
//                       )),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//               child: ListView.builder(
//             itemCount: dataList.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
//                 child: Card(
//                   child: Container(
//                     height: 60,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 dataList[index]['name'],
//                                 style: TextStyle(fontSize: 20),
//                               ),
//                               Text('Age : ${dataList[index]['age']}'),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 10),
//                           child: Row(
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(context, MaterialPageRoute(builder: (context) => Update(userID: dataList[index]['id']),)).then((value) {
//                                     if(value == true)
//                                     {
//                                       fetchdata();
//                                     }
//                                   });
//                                 },
//                                 child: Icon(
//                                   Icons.edit,
//                                   color: Colors.blueGrey,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   _delete(dataList[index]['id']);
//                                 },
//                                     child: Icon(Icons.delete))
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ))
//         ],
//       ),
//     );
//   }
// }

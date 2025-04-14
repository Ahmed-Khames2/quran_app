// import 'package:flutter/material.dart';

// class ManualLocationPage extends StatefulWidget {
//   final Function(double latitude, double longitude) onLocationUpdated;

//   const ManualLocationPage({Key? key, required this.onLocationUpdated}) : super(key: key);

//   @override
//   _ManualLocationPageState createState() => _ManualLocationPageState();
// }

// class _ManualLocationPageState extends State<ManualLocationPage> {
//   final _latitudeController = TextEditingController();
//   final _longitudeController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('تعديل الموقع يدويًا'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _latitudeController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 labelText: 'خط العرض',
//               ),
//             ),
//             TextField(
//               controller: _longitudeController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 labelText: 'خط الطول',
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 final latitude = double.tryParse(_latitudeController.text);
//                 final longitude = double.tryParse(_longitudeController.text);

//                 if (latitude != null && longitude != null) {
//                   widget.onLocationUpdated(latitude, longitude);
//                   Navigator.pop(context);
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('يرجى إدخال إحداثيات صحيحة')),
//                   );
//                 }
//               },
//               child: const Text('تأكيد الموقع'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// Scaffold(
//       body: SafeArea(
//         child: StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection('users')
//               .doc(currentUser.email)
//               .snapshots(),
//           builder: (BuildContext context,
//               AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
//             if (snapshot.hasData) {
//               return Consumer<MarketProvider>(
//                 builder: (context, marketProvider, child) {
//                   return ListView.separated(
//                     itemCount: favC.length,
//                     itemBuilder: (context, index) {
//                       CryptoCurrency selectedCrypto =
//                           marketProvider.fetchCryptoById(favC[index]);
//                       return ListTile(
//                         leading: CircleAvatar(
//                           backgroundColor: Colors.white,
//                           backgroundImage: NetworkImage(selectedCrypto.image!),
//                         ),
//                         title: Text(
//                           selectedCrypto.name!,
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         subtitle: Text(
//                           "₹ " + selectedCrypto.currentPrice!,
//                           style: TextStyle(fontSize: 17),
//                         ),
//                       );
//                     },
//                     separatorBuilder: (__, ___) {
//                       return Divider();
//                     },
//                   );
//                 },
//               );
//             }
//             return Text("No data Found");
//           },
//         ),
//       ),
//     );



  // var currentUser = FirebaseAuth.instance.currentUser!;
  // var arr;
  // static var favC = [];

  // void fetchFavData() async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(currentUser.email)
  //       .get()
  //       .then((ds) {
  //     arr = ds.data();
  //     favC = arr['fav'];
  //     print(favC);
  //   });
  // }
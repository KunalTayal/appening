import 'package:appening/api.dart';
import 'package:flutter/material.dart';
import 'package:appening/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String text = "";
  GetRequestData getRequestData = GetRequestData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 20,
        toolbarHeight: 70,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: FutureBuilder<List?>(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // ignore: prefer_is_empty
              if (snapshot.data?.length == 0) {
                return const Center(
                  child: Text(
                    'No Profile found',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  cacheExtent: 100.0,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    text = snapshot.data![index]['first_name'] +
                        " " +
                        snapshot.data![index]['last_name'];
                    // print(snapshot.data?[index]);
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                          snapshot.data?[index]['avatar'],
                        ),
                        radius: 24.0,
                      ),
                      title: Text(
                        text,
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        snapshot.data?[index]['email'],
                        style: const TextStyle(fontSize: 15),
                      ),
                    );
                  },
                );
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<dynamic>?> getUser() async {
    // Map<String, dynamic> k = await getRequestData.fetchUserList();
    // User user = User(id: int.parse(k[""]),firstName: "",lastName: "",avatar: "", email: "",);
    try {
      return await getRequestData.fetchUserList();
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}

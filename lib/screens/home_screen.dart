import 'package:flutter/material.dart';
import 'package:rest_api_app/apis/dio_api_helper.dart';
import 'package:rest_api_app/apis/http_api_helper.dart';
import 'package:rest_api_app/local_data/local_data.dart';
import 'package:rest_api_app/model/user_list_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserData> userList = [];
  int page = 1;

  //For get users list api calling
  bool loading = true, loadMore = false;
  usersList() async {
    if (await checkApiHttpType()) {
      await httpApi.getUserList(page).then((value) {
        if (value.isNotEmpty) {
          page = page + 1;
          userList = value;
        }
        setState(() {
          loading = false;
        });
      });
    } else {
      await dioApi.getUserList(page).then((value) {
        if (value.isNotEmpty) {
          page = page + 1;
          userList = value;
        }
        setState(() {
          loading = false;
        });
      });
    }
  }

  loadMoreUsersList() async {
    setState(() {
      loadMore = true;
    });
    if (await checkApiHttpType()) {
      await httpApi.getUserList(page).then((value) {
        if (value.isNotEmpty) {
          page = page + 1;
          userList.addAll(value);
        }
        setState(() {
          loadMore = false;
        });
      });
    } else {
      await dioApi.getUserList(page).then((value) {
        if (value.isNotEmpty) {
          page = page + 1;
          userList.addAll(value);
        }
        setState(() {
          loadMore = false;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    usersList();
  }

  Future<bool> checkApiHttpType() async {
    String? type = await localData.getApiType();
    return type == 'http';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body:
          loading
              ? Center(child: CircularProgressIndicator())
              : userList.isNotEmpty == true
              ? ListView.builder(
                itemCount: userList.length,
                itemBuilder:
                    (context, index) => Column(
                      children: [
                        ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              userList[index].avatar ?? '',
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      Icon(Icons.person),
                            ),
                          ),
                          title: Text(
                            "${userList[index].firstName ?? ''} ${userList[index].lastName ?? ''}",
                          ),
                          subtitle: Text(userList[index].email ?? ''),
                        ),
                        if (userList.length == index + 1)
                          loadMore
                              ? Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                onPressed:
                                    loadMore
                                        ? () {}
                                        : () {
                                          loadMoreUsersList();
                                        },
                                child: Text(
                                  'Load More',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ],
                    ),
              )
              : Center(
                child: TextButton(
                  onPressed: () {
                    usersList();
                  },
                  child: Text("Retry"),
                ),
              ),
    );
  }
}

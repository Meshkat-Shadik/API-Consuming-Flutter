import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_riverpod_api/providers.dart';

class ApiPage extends StatefulWidget {
  const ApiPage({Key? key}) : super(key: key);

  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  @override
  void didChangeDependencies() {
    context
        .read(userStateNotifierProvider.notifier)
        .getUser("https://jsonplaceholder.typicode.com/users");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, watch, child) {
        final state = watch(userStateNotifierProvider);

        return state.maybeWhen(
          loading: () => CircularProgressIndicator(),
          success: (data) => Center(
            // child: Text(data.toString()),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index].name),
                  subtitle: Text(data[index].email),
                  leading: CircleAvatar(
                    child: Text(
                      data[index].username,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 8,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          error: (e) => Center(
            child: Text("Error occurred, $e"),
          ),
          orElse: () => Center(
            child: ElevatedButton(
                child: Text(
                  "Get Single User",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  context
                      .read(userStateNotifierProvider.notifier)
                      .getUser("https://jsonplaceholder.typicode.com/users");
                }),
          ),
        );
      }),
    );
  }
}

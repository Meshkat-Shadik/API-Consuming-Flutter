
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_riverpod_api/Api/api_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Consumer(
          builder: (context, watch, child) {
            final getUserValue = watch(userFutureProvider(
                "https://jsonplaceholder.typicode.com/users"));
            return getUserValue.map(
              data: (data) => ListView.builder(
                itemCount: data.value.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data.value[index].name),
                    subtitle: Text(data.value[index].email),
                    leading: CircleAvatar(
                      child: Text(
                        data.value[index].username,
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 8,
                        ),
                      ),
                    ),
                  );
                },
              ),
              loading: (_) => CircularProgressIndicator(),
              error: (_) => Text(
                _.error.toString(),
                style: TextStyle(color: Colors.red),
              ),
            );
          },
        ),
      ),
    );
  }
}

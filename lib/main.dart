import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_riverpod_api/Api/States/api_state.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod with Freezed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Consumer(
            builder: (context, watch, child) {
              final responseAsyncValue = watch(responseProvider(
                  "https://jsonplaceholder.typicode.com/users"));
              return responseAsyncValue.map(
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
      ),
    );
  }
}

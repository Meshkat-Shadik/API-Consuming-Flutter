# Future Provider way

Api consuming in Riverpod using ***FutureProvider***

## Freezed
FutureProvider এ যাওয়ার আগে আমাদের Data Class Generator এবং JSON Serializable সম্পর্কে জানতে হবে। 
সেজন্য আমাদের Freezed প্যাকেজ ব্যবহার করতে হবে। কেনো Freezed প্যাকেজ গুরুত্বপূর্ণ সেটা নিচের লিংকগুলো ঘাটাঘাটি করলে বুঝা যাবে। আমি সিরিয়াল অনুযায়ী পয়েন্ট করে দিচ্ছি যেনো সে অনুযায়ী স্টাডি করলে ব্যাপারগুলো ক্লিয়ার হয়ে যায়।

- [***Immutability and Equality*** কি জিনিস? কেনো দরকার হয় এটার? (*Written Tutorial*)](https://developer.school/immutability-and-equality-in-dart-and-flutter/)
- [***Freezed Package*** কি জিনিস? কেনো দরকার হয় এটার? (*Written Tutorial*)](https://developer.school/how-to-use-freezed-with-flutter/)
- [***Freezed ❄*** – Data Class & Union in One Dart Package (*Video Tutorial*)](https://www.youtube.com/watch?v=ApvMmTrBaFI)


আশাকরি বুঝতে পেরেছেন কেনো আমাদের ***Freezed*** প্যাকেজ এর দরকার। 

## Riverpod
Riverpod মূলত আমাদের State Management এর সলুশন দেয়।
Riverpod সম্পর্কে জানতে হলে ***Provider*** নিয়ে ড্রব্যাক জানতে হবে। ড্রব্যাক জানার আগে ধরে নিলাম ***Provider*** সম্পর্কে আপনি মুটামুটি জানেন। তারপরও একটা ওভারভিউ এর জন্য এ ভিডিওটা দেখতে পারেন।

- [7 Common Flutter Providers Explained (*Video Tutorial*)](https://www.youtube.com/watch?v=zYdl_Lb-rj0&list=PLZCeGzfbi2lVaAdAeaTUS51nwdeVMgj-k&index=6) 

আচ্ছা এবার ড্রব্যাক+সলুশনে আসা যাক। সেটার জন্য আপনি এই ভিডিও টা দেখতে পারেন।
- [Flutter Riverpod Tutorial - The Better Provider (*Video Tutorial*)](https://www.youtube.com/watch?v=atwWbkBdepE&list=PLB6lc7nQ1n4gO6a7frcfge5_l7ptIzD_Y&index=3)

এই ভিডিও প্রথমবার দেখে না বুঝলে আবার দেখেন, এটা বেশ ভালো একটা আইডিয়া দিবে আপনাকে। এরপর আপনি চাইলে এই ***রিপোজিটরির***  কোডিং প্যাটার্ন দেখতে পারেন। 
 

## Future Provider
আপনি Flutter Riverpod এর ভিডিওটা দেখেছেন, তারমানে এখন আপনি এই way টাও বুঝবেন আশাকরি।


আমাদের ৩ টা জায়গায় কাজ করতে হবে।
- userRepository (*infrastructure*)
   > getUser() ফাংশন কল করবে এবং Server থেকে ডাটা নিয়ে আসবে 
- api_state (*api*)
   > এখানে আমরা normal Provider এবং FutureProvider ব্যবহার করে স্টেট আপডেট করবো 
- UI (*presentation*)
   > এখানে স্টেট থেকে আসা ভ্যালু ব্যবহার করে UI আপডেট করবো 


### user_repository.dart

```dart
class UserRepository {
  final http.Client _client;
  UserRepository(this._client);

  Future<List<User>> getUser(String url) async {
    final http.Response response = await _client.get(Uri.parse(url));
    final Iterable parsed = jsonDecode(response.body);
    final users = parsed.map((user) => User.fromJson(user)).toList();
    return users;
  }
}
```
উপরে User লেখা দেখে ঘাবড়ানোর কোনো কিছু নাই। ওটা Model যেটা Freezed এর সাহায্য নিয়ে বানিয়েছিলাম সেখান থেকে এসেছে। 

### api_state.dart

```dart
final userProvider = Provider((ref) => UserRepository(http.Client()));

final userFutureProvider =
    FutureProvider.autoDispose.family<List<User>, String>((ref, url) async {
  final httpClient = ref.read(userProvider);
  return httpClient.getUser(url);
});
```
এখানে userProvider দিয়ে নরমাল Provider কে ইমপ্লিমেন্ট করেছি যেখানে এর মূল কাজ হলো UserRepository কে ইনিশিয়ালাইজ করা।
এরপর যেহেতু userRepository থেকে আমরা getUser() কল করার মাধ্যমে Future টাইপ ডাটা পাচ্ছি সেহেতু আমরা Future Provider ব্যবহার করেছি।

### HomePage.dart

```dart
Consumer(
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
```
এখানে Consumer widget নিয়েছি কারণ আমাদের userFutureProvider কে read/watch করতে হবে। 


```
final getUserValue = watch(userFutureProvider("https://jsonplaceholder.typicode.com/users"));
```

এরপর এই getUserValue কে আমরা when/map দিয়ে গ্র্যাব করতে পারি। 




## Inspired From
- [Make An API Call with Riverpod and Freezed package (*Medium Tutorial*)](https://aidooyaw1992.medium.com/make-an-api-call-with-riverpod-and-freezed-package-ab17c631641d)


# State Notifier way

Api consuming in Riverpod using ***StateNotifier***

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

উপরের ভিডিও দেখে থাকলে এবং আমার  ***[Future Provider way](https://github.com/Meshkat-Shadik/API-Consuming-Flutter/tree/futureProviderWay)*** এর রিপোজিটরি দেখে থাকলে ধরে নিলাম, আপনি FutureProvider দিয়ে সহজেই Api থেকে ডাটা নিয়ে ব্যবহার করতে পারবেন। 


এই লেখার টাইটেল (*State Notifier Way*) দেখে বুঝতে পেরেছেন হয়তো যে Future Provider Way ইউজ না করে আমরা State Notifier Way ব্যবহার করতে যাচ্ছি। কিন্তু কেনো? সেটার উত্তর আছে **নিচের লিংকের ভিডিওতে**, আশাকরি সেটা দেখে এরপর এখানে আসবেন। 
 
- [***Flutter StateNotifier*** + Riverpod Tutorial – Immutable State Management (*Video Tutorial*)](https://www.youtube.com/watch?v=3OdciTLjSNA&list=PLB6lc7nQ1n4gO6a7frcfge5_l7ptIzD_Y&index=4
)


## State Notifier

আমাদের ৫ টা জায়গায় কাজ করতে হবে।
- userRepository (*infrastructure*)
   > getUser() ফাংশন কল করবে এবং Server থেকে ডাটা নিয়ে আসবে 
- api_state (*api*)
   > এখানে আমরা Freezed এর Union এর কনসেপ্ট কাজে লাগিয়ে স্টেট ডিক্লেয়ার করবো 
- userNotifier (*application*)
   > এখানে আগের ধাপের স্টেট গুলোর উপর বেজ করে স্টেট আপডেট করবো 
- providers
   > এখানে নরমাল Provider এবং StateNotifier ডিক্লেয়ার করে ভ্যালু লিসেন করবো 
- UI (presentation)
   > এখানে স্টেট থেকে আসা ভ্যালু ব্যবহার করে UI আপডেট করবো 


### user_repository.dart

```dart
abstract class UserRepository {
  Future<List<User>> getUser(String url);
}

class UserRepositoryImpl implements UserRepository {
  final http.Client _client;
  UserRepositoryImpl(this._client);

  @override
  Future<List<User>> getUser(String url) async {
    final http.Response response = await _client.get(Uri.parse(url));
    final Iterable parsed = jsonDecode(response.body);
    final users = parsed.map((user) => User.fromJson(user)).toList();
    return users;
  }
}

```
এখানে একটা abstract class খুলেছি, এটা user এর ডাটা পাওয়ার জন্য যেসব ফাংশনালিটি ব্যবহার করবো তার ব্লু-প্রিন্ট হিসাবে কাজ করবে। (*বিঃদ্রঃ FutureProvider এর ক্ষেত্রেও এভাবে ইউজ করা যাবে, আমি ভূলবঃশত করিনি*)

### api_state.dart

```dart
abstract class UserState with _$UserState {
  const factory UserState.initial() = _UserInitial;
  const factory UserState.loading() = _UserLoading;
  const factory UserState.success(List<User> user) = _UserLoadedSuccess;
  const factory UserState.error([String? message]) = _UserLoadedError;
}
```
চারটা আলাদা আলাদা স্টেট হতে পারে ডাটা গ্র্যাব করার ক্ষেত্রে, সেগুলোই *Freezed* এর সাহায্য নিয়ে বানিয়েছি। 

 


### userNotifier.dart

```dart
class UserStateNotifier extends StateNotifier<UserState> {
  final UserRepository userRepository;
  UserStateNotifier(this.userRepository) : super(UserState.initial());
  Future<void> getUser(String url) async {
    try {
      state = UserState.loading();
      var data = await userRepository.getUser(url);
      state = UserState.success(data);
    } catch (e) {
      state = UserState.error("$e");
    }
  }
}
```
আগেরবার যে চারটা State তৈরি করেছিলাম, সেটা এখানে শুরুতে ইনিশিয়ালাইজ করেছি এরপর state আপডেট করে ফাংশনালিটি কল করেছি। 


### providers.dart

```dart
final httpClientProvider =
    Provider<UserRepository>((ref) => UserRepositoryImpl(http.Client()));

final userStateNotifierProvider =
    StateNotifierProvider<UserStateNotifier, dynamic>(
        (ref) => UserStateNotifier(ref.watch(httpClientProvider)));
```

এখানে userProvider দিয়ে নরমাল Provider কে ইমপ্লিমেন্ট করেছি যেখানে এর মূল কাজ হলো UserRepository কে ইনিশিয়ালাইজ করা।
এরপর যেহেতু userRepository থেকে আমরা getUser() কল করার মাধ্যমে কাজ করছি সেহেতু আমরা সেই httpClientProvider কে watch করছি। 


### HomePage.dart

```dart
Consumer(builder: (context, watch, child) {
        final state = watch(userStateNotifierProvider);
        return state.maybeWhen(
          loading: () => CircularProgressIndicator(),
          success: (data) => Center(
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
```
এখানে Consumer widget নিয়েছি কারণ আমাদের userStateNotifierProvider কে read/watch করতে হবে। এরপর যেহেতু userStateNotifierProvider এটা অই চারটা স্টেট (initial, loading, success, error) কে এক্সটেন্ড করেছিলো, তাই এই চারটা কন্ডিশনে কি কি কাজ করবো সেগুলো করেছি। 
যেমন loading স্টেটে CircularProgessIndicator শো করেছি। আর এই loading, success, error এসব কন্ডিশনে না পড়লে আরেকটা কন্ডিশন আছে যেটাকে orElse বলা হচ্ছে, এখানে মূলঃত একটা Button নিয়েছি, যেটায় প্রেস করলে StateNotifier থেকে getUser() ফাংশনকে কল করবে। 



পেইজ লোড হওয়ার সাথে সাথেই যদি getUser() থেকে আসা ডাটা শো করতে চাই তাহলে সেটা initState এর মধ্যে কল করতে হবে। 
```dart
 void initState() {
    context
        .read(userStateNotifierProvider.notifier)
        .getUser("https://jsonplaceholder.typicode.com/users");
    super.initState();
  }
```



## Inspired From
- [Make An API Call with Riverpod and Freezed package (*Medium Tutorial*)](https://aidooyaw1992.medium.com/make-an-api-call-with-riverpod-and-freezed-package-ab17c631641d)


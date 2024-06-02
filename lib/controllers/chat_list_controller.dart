import 'package:get/get.dart';

class ChatListController extends GetxController {

  RxList<ChatContact> contactList = [
    ChatContact(
      imageUrl: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixabay.com%2Fimages%2Fsearch%2Fsample%2F&psig=AOvVaw2xmX0Qf8K2_4z4OrZhWx2a&ust=1717372862886000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCJiU1szOu4YDFQAAAAAdAAAAABAE',
      name: 'John Doe',
      lastMessage: 'Hey there!',
      unreadCount: 2,
      lastMessageTime: DateTime.now().subtract(Duration(minutes: 10)),
    ),
    ChatContact(
      imageUrl: 'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
      name: 'John Doe1',
      lastMessage: 'Hey there!',
      unreadCount: 0,
      lastMessageTime: DateTime.now().subtract(Duration(minutes: 10)),
    ),
  ].obs;


}

class ChatContact {
  final String imageUrl;
  final String name;
  final String lastMessage;
  final int unreadCount;
  final DateTime lastMessageTime;

  ChatContact({
    required this.imageUrl,
    required this.name,
    required this.lastMessage,
    required this.unreadCount,
    required this.lastMessageTime,
  });
}
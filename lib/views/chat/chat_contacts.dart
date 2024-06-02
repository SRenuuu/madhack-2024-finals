import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/controllers/chat_list_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class ChatListPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    ChatListController controller = Get.put(ChatListController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(), // Handle menu open
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search messages',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: controller.contactList.length,
              separatorBuilder: (context, index) => const Divider(color: Colors.grey),
              itemBuilder: (context, index) {
                return ChatContactItem(contact: controller.contactList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}


class ChatContactItem extends StatelessWidget {
  final ChatContact contact;

  const ChatContactItem({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18.0),
        child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(contact.imageUrl),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(contact.lastMessage),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              Column(
                children: [
                  if (contact.unreadCount > 0)
                    Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Center(
                        child: Text(
                          contact.unreadCount.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                      ),
                    ),
                  const SizedBox(height: 2.0),
                  Text(
                      DateFormat('hh:mm a').format(contact.lastMessageTime),
                      style: TextStyle(fontSize: 10.0),
                    ),
                ],
              ),
              const Divider(
                  color: Colors.black
              )
            ],
    )
    );
  }
}
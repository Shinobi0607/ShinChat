// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatsapp_ui/features/chat/controller/chat_controller.dart';
import 'package:whatsapp_ui/info.dart';
import 'package:whatsapp_ui/widgets/my_message_card.dart';
import 'package:whatsapp_ui/widgets/sender_message_card.dart';

class ChatList extends ConsumerWidget {
  final String receiverUserId;
  const ChatList({
    Key? key,
    required this.receiverUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: ref.read(chatControllerProvider).chatStream(receiverUserId),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            if (messages[index]['isMe'] == true) {
              //MyMessage -> Card
              return MyMessageCard(
                  message: messages[index]['text'].toString(),
                  date: messages[index]['time'].toString(),
                  );
            }
            //SenderMessage -> Card
            return SenderMessageCard(
              message: messages[index]['text'].toString(),
              date: messages[index]['time'].toString(),
            );
          },
        );
      }
    );
  }
}

import 'dart:io';

import 'package:chat_app/models/chat.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/user_profile.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/database_service.dart';
import 'package:chat_app/services/media_service.dart';
import 'package:chat_app/services/storage_service.dart';
import 'package:chat_app/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ChatPage extends StatefulWidget {
  final UserProfile chatUser;

  const ChatPage({super.key, required this.chatUser});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final GetIt _getIt = GetIt.instance;

  late AuthService _authService;
  late DatabaseService _databaseService;
  late ChatUser currentUser, otherUser;
  late MediaService _mediaService;
  late StorageService _storageService;

  @override
  void initState() {
    super.initState();
    _databaseService = _getIt.get<DatabaseService>();
    _authService = _getIt.get<AuthService>();
    _mediaService = _getIt.get<MediaService>();
    _storageService = _getIt.get<StorageService>();

    // Initialize currentUser
    currentUser = ChatUser(
      id: _authService.user!.uid,
      firstName: _authService.user!.displayName!,
      profileImage: _authService.user!.photoURL, // Optional
    );

    // Initialize otherUser
    otherUser = ChatUser(
      id: widget.chatUser.uid!,
      firstName: widget.chatUser.name!,
      profileImage: widget.chatUser.pfpURL, // Optional
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatUser.name!),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return StreamBuilder(
      stream: _databaseService.getChatData(currentUser.id, otherUser.id),
      builder: (context, snapshot) {
        Chat? chat = snapshot.data?.data();
        List<ChatMessage> messages = [];
        if (chat != null && chat.messages != null) {
          messages = _generateChatMessagesList(chat.messages!);
        }
        return DashChat(
          messageOptions: MessageOptions(
            showOtherUsersAvatar: true,
            showTime: true,
          ),
          inputOptions: InputOptions(
              alwaysShowSend: true, trailing: [_mediaMessageButton()]),
          // _mediaMessageButton();
          messages: [], // Manage this based on your chat logic
          currentUser: currentUser,
          onSend: (message) {
            // Implement sending message logic here
          },
        );
      },
    );
  }

  Future<void> _sentMessage(ChatMessage chatmessage) async {
    if (chatmessage.medias?.isEmpty ?? false) {
      if (chatmessage.medias!.first.type == MediaType.image) {
        Message message = Message(
          senderID: chatmessage.user.id,
          content: chatmessage.medias!.first.url,
          messageType: MessageType.Image,
          sentAt: Timestamp.fromDate(chatmessage.createdAt),
        );
        await _databaseService.sendChatMessage(
            currentUser.id, otherUser.id, message);
      }
    } else {
      Message message = Message(
        senderID: currentUser.id,
        content: chatmessage.text,
        messageType: MessageType.Text,
        sentAt: Timestamp.fromDate(chatmessage.createdAt),
      );
      await _databaseService.sendChatMessage(
          currentUser.id, otherUser.id, message);
    }
  }

  List<ChatMessage> _generateChatMessagesList(List<Message> messages) {
    List<ChatMessage> chatMessages = messages.map((m) {
      if (m.messageType == MessageType.Image) {
        return ChatMessage(
            user: m.senderID == currentUser.id ? currentUser : otherUser,
            createdAt: m.sentAt!.toDate(),
            medias: [
              ChatMedia(url: m.content!, fileName: '', type: MediaType.image)
            ]);
      } else {
        return ChatMessage(
          user: m.senderID == currentUser.id ? currentUser : otherUser,
          text: m.content!,
          createdAt: m.sentAt!.toDate(),
        );
      }
    }).toList();
    chatMessages.sort((a, b) {
      return b.createdAt.compareTo(a.createdAt);
    });
    return chatMessages;
  }

  Widget _mediaMessageButton() {
    return IconButton(
      onPressed: () async {
        File? file = await _mediaService.getImageFromGallery();
        if (file != null) {
          String chatID =
              generateChatID(uid1: currentUser.id, uid2: otherUser.id);
          String? downLoadUrl = await _storageService.uploadImageToChat(
              file: file, chatID: chatID);
          if (downLoadUrl != null) {
            ChatMessage chatMessage = ChatMessage(
              user: currentUser,
              createdAt: DateTime.now(),
              medias: [
                ChatMedia(
                  url: downLoadUrl,
                  fileName: '',
                  type: MediaType.image,
                ),
              ],
            );
            _sentMessage(chatMessage);
          }
        }
      },
      icon: Icon(Icons.image),
      color: Theme.of(context).colorScheme.primary,
    );
  }
}

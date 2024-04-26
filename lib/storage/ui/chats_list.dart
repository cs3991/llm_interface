import 'package:flutter/material.dart';

class ChatsList extends StatelessWidget {
  final chats = [
    'Test',
    'Selected',
    'other chats',
  ];
  final selected = 1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(2),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          dense: true,
          selected: index == selected,
          enabled: true,
          onTap: () {},
          title: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            chats[index],
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../model/playercard.dart';
import 'addcard.dart';

class CardListScreen extends StatefulWidget {
  const CardListScreen({super.key});

  @override
  State<CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("รายการการ์ดนักเตะ"),
        backgroundColor: Colors.orange,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddCardScreen()),
              );
              setState(() {});
            },
          ),
        ],
      ),
      body: myCards.isEmpty
          ? const Center(child: Text("ไม่มีข้อมูลนักเตะ"))
          : ListView.builder(
              itemCount: myCards.length,
              itemBuilder: (context, index) {
                final card = myCards[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(card.playerPic.image), // แก้ไขตรงนี้เป็น .image
                      onBackgroundImageError: (_, __) {},
                      child: const Icon(Icons.person_outline),
                    ),
                    title: Text("${card.name} (#${card.number})"),
                    subtitle: Text("${card.club} | ${card.nationality}\n${card.heightWeight}"),
                    isThreeLine: true,
                  ),
                );
              },
            ),
    );
  }
}
import 'package:flutter/material.dart';
import '../model/playercard.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  int _number = 0;
  String _nationality = '';
  String _club = '';
  int _age = 0;
  String _heightWeight = '';
  PlayerPic _playerPic = PlayerPic.card1;

  // Pattern สำหรับตรวจสอบว่ามีตัวอักษรภาษาไทยหรือไม่
  final RegExp _thaiRegExp = RegExp(r'[\u0E00-\u0E7F]');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("เพิ่มข้อมูลนักเตะ"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // ฟิลด์: ชื่อนักเตะ (บังคับกรอก + ตรวจสอบภาษาไทย)
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    labelText: "ชื่อนักเตะ (ภาษาไทย)",
                    hintText: "เช่น ลิโอเนล เมสซี",
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "กรุณากรอกชื่อนักเตะ";
                    }
                    if (!_thaiRegExp.hasMatch(value)) {
                      return "กรุณากรอกชื่อนักเตะเป็นภาษาไทย";
                    }
                    return null;
                  },
                  onSaved: (value) => _name = value!.trim(),
                ),

                // ฟิลด์: หมายเลขเสื้อ
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "หมายเลขเสื้อ"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "กรุณากรอกหมายเลขเสื้อ";
                    }
                    if (int.tryParse(value) == null) {
                      return "กรุณากรอกเฉพาะตัวเลข";
                    }
                    return null;
                  },
                  onSaved: (value) => _number = int.parse(value!),
                ),

                // ฟิลด์: สัญชาติ (ตรวจสอบภาษาไทยถ้ามีการกรอก)
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "สัญชาติ (ภาษาไทย)",
                    hintText: "เช่น อาร์เจนตินา",
                  ),
                  validator: (value) {
                    if (value != null && value.trim().isNotEmpty) {
                      if (!_thaiRegExp.hasMatch(value)) {
                        return "กรุณากรอกสัญชาติเป็นภาษาไทย";
                      }
                    }
                    return null;
                  },
                  onSaved: (value) => _nationality = value?.trim() ?? '',
                ),

                // ฟิลด์: สโมสร (ตรวจสอบภาษาไทยถ้ามีการกรอก)
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "สโมสร (ภาษาไทย)",
                    hintText: "เช่น อินเตอร์ ไมอามี",
                  ),
                  validator: (value) {
                    if (value != null && value.trim().isNotEmpty) {
                      if (!_thaiRegExp.hasMatch(value)) {
                        return "กรุณากรอกชื่อสโมสรเป็นภาษาไทย";
                      }
                    }
                    return null;
                  },
                  onSaved: (value) => _club = value?.trim() ?? '',
                ),

                // ฟิลด์: อายุ
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "อายุ"),
                  onSaved: (value) => _age = int.tryParse(value ?? '0') ?? 0,
                ),

                // ฟิลด์: ส่วนสูง / น้ำหนัก
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "ส่วนสูง / น้ำหนัก",
                    hintText: "เช่น 170 ซม. / 72 กก.",
                  ),
                  onSaved: (value) => _heightWeight = value?.trim() ?? '',
                ),

                // Dropdown เลือกรูปภาพ
                DropdownButtonFormField<PlayerPic>(
                  value: _playerPic,
                  decoration: const InputDecoration(labelText: "เลือกรูปภาพ"),
                  items: PlayerPic.values.map((pic) {
                    return DropdownMenuItem(
                      value: pic,
                      child: Row(
                        children: [
                          Text(pic.playerName),
                          const SizedBox(width: 10),
                          Image.asset(
                            pic.image,
                            width: 30,
                            height: 30,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.person, size: 30),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _playerPic = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // ปุ่มบันทึก
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      myCards.add(
                        PlayerCard(
                          name: _name,
                          number: _number,
                          nationality: _nationality,
                          club: _club,
                          age: _age,
                          heightWeight: _heightWeight,
                          playerPic: _playerPic,
                        ),
                      );

                      _formKey.currentState!.reset();

                      Navigator.pop(context);
                    }
                  },
                  style: FilledButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text("บันทึก", style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:baby_milestone_app/constant/bottombar_navigation.dart';
import 'package:baby_milestone_app/constant/textStyle.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../commonwidget/appbar.dart';
import '../constant/build_textfield.dart';

class AddMilestonePage extends StatefulWidget {
  final Map<String, dynamic>? initialData;

  const AddMilestonePage({Key? key, this.initialData}) : super(key: key);

  @override
  State<AddMilestonePage> createState() => _AddMilestonePageState();
}

class _AddMilestonePageState extends State<AddMilestonePage> {
  final milestoneBox = Hive.box('milestone_box');

  String _selectedItem = 'Physical';
  Map<String, List<String>> milestoneItems = {
    'Physical': [
      'First Smile',
      'First Tooth',
      'Crawling',
      'Standing',
      'First Steps',
      'Walking',
      'Other (Physical)',
    ],
    'Cognitive': [
      'Recognizing Faces',
      'Responding to Sounds',
      'Object Permanence',
      'Simple Problem Solving',
      'Other (Cognitive)',
    ],
    'Language': [
      'Babbling',
      'First Words',
      'Building Vocabulary',
      'Simple Sentences',
      'Other (Language)',
    ],
    'Health-Related': [
      'Growth Metrics (Weight, Height)',
      'Vaccinations',
      'Teething',
      'Sleep Patterns',
      'Other (Health-Related)',
    ],
  };

  DateTime? _pickedDate;
  final description = TextEditingController();

  final otherMilestone = TextEditingController();

  String? selectedMilestone;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _pickedDate) {
      setState(() {
        _pickedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _selectedItem = widget.initialData!['type'];
      _pickedDate = widget.initialData != null
          ? DateTime.parse(widget.initialData!['date'] as String)
          : null;

      description.text = widget.initialData!['notes'];
      selectedMilestone = widget.initialData!['milestone'];
    }
  }

  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('dd MMM, yyyy'); // Date format

    return Scaffold(
      appBar: const BuildAppBar(title: 'Add Milestone', icon: Icons.edit),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerMilestone('Milestone Type'),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(246, 247, 249, 1),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                    ),
                    value: _selectedItem,
                    items: milestoneItems.keys
                        .map((key) => DropdownMenuItem<String>(
                              value: key,
                              child: Text(key),
                            ))
                        .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedItem = newValue!;
                        selectedMilestone = null;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  headerMilestone('Milestone'),
                  if (milestoneItems.containsKey(_selectedItem))
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromRGBO(246, 247, 249, 1),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none),
                          ),
                          value: selectedMilestone,
                          items: milestoneItems[_selectedItem]!
                              .map((value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (newValue) {
                            if (newValue != null &&
                                newValue.startsWith('Other')) {
                              setState(() {
                                selectedMilestone = null;
                              });
                            } else {
                              setState(() {
                                selectedMilestone = newValue;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            headerMilestone('Other Milestone'),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              onChanged: (newValue) {
                                if (newValue != null &&
                                    newValue.startsWith('Other')) {
                                  setState(() {
                                    selectedMilestone = null;
                                    otherMilestone
                                        .clear(); // Clear the text field
                                  });
                                } else {
                                  setState(() {
                                    selectedMilestone = newValue;
                                  });
                                }
                              },
                              controller: otherMilestone,
                              decoration: InputDecoration(
                                fillColor:
                                    const Color.fromRGBO(246, 247, 249, 1),
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 12),
                                hintText: 'Other Milestone',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            headerMilestone('Milestone Date'),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () => _selectDate(context),
                              child: AbsorbPointer(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    fillColor:
                                        const Color.fromRGBO(246, 247, 249, 1),
                                    filled: true,
                                    hintText:
                                        ' ${_pickedDate != null ? dateFormatter.format(_pickedDate!) : DateFormat('dd MMM, yyyy').format(DateTime.now())}',
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 12),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  controller: TextEditingController(
                                    text: _pickedDate != null
                                        ? dateFormatter.format(_pickedDate!)
                                        : '',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  headerMilestone('Milestone Notes'),
                  BuildTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the description';
                      } else {
                        return null;
                      }
                    },
                    maxline: 5,
                    hint: 'Description ',
                    controller: description,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: backGBcolor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            if (widget.initialData != null) {
                              _updateMilestone(widget.initialData!['key']);
                            } else {
                              _addMilestone();
                            }
                            Get.offAll(() => const BottomNavigation());
                          }
                        },
                        child: Text(
                          widget.initialData != null
                              ? 'Update Milestone'
                              : 'Add Milestone',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          )),
    );
  }

  void _addMilestone() async {
    await milestoneBox.add({
      'type': _selectedItem.toString(),
      'date': _pickedDate?.toIso8601String() ?? '',
      'notes': description.text,
      'milestone': selectedMilestone.toString(),
    });
  }

  void _updateMilestone(int key) {
    milestoneBox.put(key, {
      'type': _selectedItem.toString(),
      'date': _pickedDate?.toIso8601String() ?? '',
      'notes': description.text,
      'milestone': selectedMilestone.toString(),
    });
  }

  Text headerMilestone(String title) {
    return Text(
      title,
      style: appStyle(size: 14, fw: FontWeight.w600, color: backGBcolor),
    );
  }
}

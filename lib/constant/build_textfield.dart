import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final int? maxline;
  final String? Function(String?) validator;
  final TextEditingController controller;
  const BuildTextField({
    super.key,
    required this.hint,
    this.icon,
    this.maxline,
    required this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return 
    TextFormField(
      controller: controller,
      maxLines: maxline ?? 1,
      validator: validator,
      decoration: InputDecoration(
        fillColor: const Color.fromRGBO(246, 247, 249, 1),
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        hintText: hint,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
        suffixIcon: Icon(
          icon,
          color: Colors.grey,
        ),
      ),
    );
  }
}

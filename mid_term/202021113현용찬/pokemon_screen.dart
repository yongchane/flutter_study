import 'package:flutter/material.dart';

import '../const/colors.dart';

class PokemonScreen extends StatelessWidget {
  final int nums;
  final VoidCallback onRoll;

  const PokemonScreen({
    required this.nums,
    required this.onRoll,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Center(
          child: Image.asset('asset/img/poke$nums.png'),
        ),
        SizedBox(height: 20.0),
        Text(
          '아래버튼클릭',
          style: TextStyle(
            color: primaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w200,
          ),
        ),

        IconButton(
          onPressed: onRoll,
          icon: Icon(
            Icons.cake,
          ),
        ),
      ],
    );
  }
}

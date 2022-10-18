import 'package:flutter/material.dart';
import 'package:mobile_app/views/fields/fields_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FieldView extends StatelessWidget {
  const FieldView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FieldsViewModel>.reactive(
      viewModelBuilder: () => FieldsViewModel(),
      builder: (context, model, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            "Field Configuration",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
            width: 10,
          ),
          Image(
            image: AssetImage('lib/assets/court.jpg'),
          ),
        ],
      ),
    );
  }
}

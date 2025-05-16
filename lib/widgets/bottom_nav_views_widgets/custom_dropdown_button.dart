import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/utils/textstyles.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({required this.validator,required this.onSaved,super.key});

final String? Function(String?)? validator;
final void Function(String?)? onSaved;
  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
 final List<String> issuesItems = ['Potholes', 'Cracks', 'Speed Bumps', 'Other'];

String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return  DropdownButtonFormField2<String>(
               isExpanded: true,
               barrierDismissible: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff9D9D9D)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: 
                 OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  
                ),
                hint:  Text(
                  'Select the issue',
                  style: Styles.styleblack16,
                ),
                items: issuesItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: Styles.styleblack16
                          ),
                        ))
                    .toList(),
                validator: widget.validator,
                onChanged: (value) {
                  //Do something when selected item is changed.
                },
                onSaved:widget.onSaved,
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 8),
                
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: kPrimaryColor,
                  ),
                  iconSize: 24,
                ),
                dropdownStyleData: DropdownStyleData(
                  elevation: 0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              );
  }
}
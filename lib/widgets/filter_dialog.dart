import 'package:flutter/material.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/utils/textstyles.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({required this.selectedFilter,
  required this.applyFilter,
  required this.cancel,required this.groupedValue,
  
   super.key});
  final Function(String) selectedFilter;
  final VoidCallback applyFilter;
  final VoidCallback cancel;
  final String groupedValue;
 

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 245,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            height: 49,
            width: 240,
            padding: EdgeInsets.all(12),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Color(0xffEFEEF1),
              border: Border(
                bottom: BorderSide(color: Color(0xffD8D7DD), width: 1),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text("Choose Filter", style: Styles.stylePrimaryColorbold16),
          ),
           Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 49,

                      child: RadioListTile(
                        activeColor: kPrimaryColor,
                        title: Text(
                          "Shortest Path",
                          style: Styles.styledarkgrey16,
                        ),
                        value: "Shortest Path",
                        groupValue: widget.groupedValue,
                        onChanged: (value) {
                    widget.selectedFilter(value!);
                        },
                      ),
                    ),
                    Divider(color: Color(0xffD8D7DD), height: 0),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 49,

                      child: RadioListTile(
                        activeColor: kPrimaryColor,
                        title: Text(
                          "Best RQI(Quality)",
                          style: Styles.styledarkgrey16,
                        ),
                        value: "Best RQI (Quality)",
                        groupValue:widget.groupedValue,
                        onChanged: (value) {
                               widget.selectedFilter(value!);
                        },
                      ),
                    ),
                    Divider(color: Color(0xffD8D7DD), height: 0),
                    SizedBox(
                      height: 49,

                      child: RadioListTile(
                        activeColor: kPrimaryColor,
                        title: Text("Most used", style: Styles.styledarkgrey16),
                        value: "Most used",
                        groupValue: widget.groupedValue,
                        onChanged: (value) {
                              widget.selectedFilter(value!);
                        },
                      ),
                    ),
                    Divider(color: Color(0xffD8D7DD), height: 0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed:widget.cancel,
                          child: Text("cancel", style: Styles.stylegrey16),
                        ),
                       
                         
                            TextButton(
                              onPressed: widget.applyFilter,
                              child: Text(
                                "Apply Filter",
                                style: Styles.stylePrimaryColorbold16,
                              ),
                            )
                         
                          
                        
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/features/job_screens/controller/filter_controller.dart';
class FilterDialog extends StatelessWidget {
  final controller = Get.put(FilterController());

  FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Filter',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 24),
              buildDropdown(
                'Company',
                controller.companies,
                controller.selectedCompany,
              ),
              buildDropdown(
                'Position',
                controller.positions,
                controller.selectedPosition,
              ),
              buildDropdown('Year', controller.years, controller.selectedYear),
              buildDropdown(
                'Location',
                controller.locations,
                controller.selectedLocation,
              ),
              buildDropdown(
                'Status',
                controller.statuses,
                controller.selectedStatus,
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(
    String label,
    List<String> items,
    RxString selectedValue,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),
          Obx(
            () => Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<String>(
                value: selectedValue.value,
                isExpanded: true,
                underline: SizedBox(),
                icon: Icon(Icons.arrow_drop_down),
                style: TextStyle(color: Colors.green, fontSize: 16),
                items:
                    items
                        .map(
                          (item) =>
                              DropdownMenuItem(value: item, child: Text(item)),
                        )
                        .toList(),
                onChanged: (value) {
                  if (value != null) selectedValue.value = value;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

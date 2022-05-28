import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/classify_model.dart';
import '../controllers/classify_controller.dart';

class ClassifyView extends GetView<ClassifyController> {
  const ClassifyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DataTable(
            columns: [
              DataColumn(
                onSort: (columnIndex, ascending) {},
                label: const Text(
                  'Phân loại',
                  maxLines: 1,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Age',
                  maxLines: 1,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Role',
                  maxLines: 1,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
            rows: _createRows(),
          ),
        ],
      ),
    );
  }

  List<DataRow> _createRows() {
    return listClassify
        .map((book) => DataRow(cells: [
              DataCell(Text(book['title'])),
              DataCell(Text(book['defaultAmount'].toString())),
              DataCell(Text(book['currentAmount'].toString()))
            ]))
        .toList();
  }
}

// class _DataColumnCustom extends DataTableSource {
//   _DataColumnCustom() : super();

//   @override
//   Widget build(BuildContext context) {
//     return;
//   }

//   @override
//   DataRow? getRow(int index) {
//     return DataRow(cells: []);
//   }

//   @override
//   // TODO: implement isRowCountApproximate
//   bool get isRowCountApproximate => throw UnimplementedError();

//   @override
//   // TODO: implement rowCount
//   int get rowCount => throw UnimplementedError();

//   @override
//   // TODO: implement selectedRowCount
//   int get selectedRowCount => throw UnimplementedError();
// }

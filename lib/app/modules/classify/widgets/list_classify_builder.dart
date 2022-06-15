import 'dart:math' as math;

import 'package:get/get.dart' hide ContextExtensionss;

import '../../../core/styles/style.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/error_widget/error_widget.dart';
import '../../../widgets/indicators/loading_indicator.dart';
import '../controllers/classify_controller.dart';

class ListClassifyBuilder extends GetView<ClassifyController> {
  const ListClassifyBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: controller.obx(
        (state) => Obx(
          () => DataTable(
            dataRowHeight: 60,
            sortColumnIndex: 0,
            sortAscending: controller.sortAscending,
            showCheckboxColumn: false,
            columns: [
              DataColumn(
                onSort: controller.sortList,
                label: const _HeaderTitle(
                  'Phân loại',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const DataColumn(
                numeric: true,
                label: _HeaderTitle(
                  'Ước tính',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const DataColumn(
                numeric: true,
                label: _HeaderTitle(
                  'Thực tế',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            rows: state!.map(
              (data) {
                bool isExceed = (data.defaultBalance <= data.currentBalance) ||
                    ((data.currentBalance) >= data.defaultBalance * 2 / 3);

                return DataRow(
                  onLongPress: () => controller.onEditClassify(data),
                  cells: [
                    DataCell(
                      _HeaderTitle(data.title),
                    ),
                    DataCell(
                      _HeaderTitle(
                        data.defaultBalance == 0
                            ? '\t'
                            : data.defaultBalance.format + '\t₫',
                      ),
                    ),
                    DataCell(
                      _HeaderTitle(
                        data.currentBalance.format + '\t₫',
                        style: TextStyle(
                          color: isExceed ? context.error : null,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ).toList(),
          ),
        ),
        onLoading: const IntrinsicHeight(
          child: Center(child: LoadingIndicator()),
        ),
        onEmpty: const IntrinsicHeight(
          child: EmptyWidget(title: "Chưa có danh mục nào"),
        ),
        onError: (error) => const IntrinsicHeight(child: ErrorCustomWidget()),
      ),
    );
  }
}

class _HeaderTitle extends StatelessWidget {
  final String title;
  final TextStyle? style;

  const _HeaderTitle(
    this.title, {
    this.style,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        title,
        style: context.bodyText2.copyWith(
          fontSize: style?.fontSize,
          fontWeight: style?.fontWeight,
          color: style?.color,
        ),
        maxLines: 1,
      ),
    );
  }
}

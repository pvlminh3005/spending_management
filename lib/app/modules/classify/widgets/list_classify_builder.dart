import 'package:get/get.dart' hide ContextExtensionss;

import '../../../core/constants/enum.dart';
import '../../../core/styles/style.dart';
import '../../../widgets/indicators/loading_indicator.dart';
import '../controllers/classify_controller.dart';

class ListClassifyBuilder extends GetView<ClassifyController> {
  const ListClassifyBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Obx(
        () => controller.loadingTable
            ? const LoadingIndicator()
            : DataTable(
                dataRowHeight: 60,
                sortColumnIndex: 0,
                columnSpacing: 20,
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
                rows: controller.getListClassify().map(
                  (data) {
                    bool isExceed = (data.defaultBalance <=
                            data.currentBalance) ||
                        ((data.currentBalance) >= data.defaultBalance * 4 / 5);

                    return DataRow(
                      onLongPress: () => controller.onEditClassify(data),
                      cells: [
                        DataCell(
                          _HeaderTitle(data.title),
                        ),
                        DataCell(
                          _HeaderTitle(
                            (data.isChargeType)
                                ? ' '
                                : data.defaultBalance.format + ' ₫',
                          ),
                        ),
                        DataCell(
                          _HeaderTitle(
                            data.currentBalance.format + ' ₫',
                            style: TextStyle(
                              color: data.type == CategoryType.charge
                                  ? null
                                  : isExceed
                                      ? context.error
                                      : null,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
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
          fontSize: style?.fontSize?.sp,
          fontWeight: style?.fontWeight,
          color: style?.color,
        ),
        overflow: TextOverflow.visible,
        softWrap: true,
        maxLines: 1,
      ),
    );
  }
}

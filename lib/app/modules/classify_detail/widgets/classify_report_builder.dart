import 'package:get/get.dart' hide ContextExtensionss;

import '../../../core/constants/enum.dart';
import '../../../core/styles/style.dart';
import '../../../widgets/dropdown_custom.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/error_widget/error_widget.dart';
import '../../../widgets/indicators/loading_indicator.dart';
import '../controllers/classify_detail_controller.dart';

class ClassifyReportBuilder extends GetView<ClassifyDetailController> {
  const ClassifyReportBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 10,
              top: 5,
              bottom: 6,
            ),
            child: SizedBox(
              width: 100.w,
              child: Obx(
                () => DropDownCustom(
                  categoryType: controller.classifyType,
                  onChanged: controller.onChangedFilter,
                ),
              ),
            ),
          ),
          controller.obx(
            (state) => DataTable(
              dataRowHeight: 60,
              sortColumnIndex: 0,
              columnSpacing: 20,
              // sortAscending: controller.sortAscending,
              showCheckboxColumn: false,
              columns: const [
                DataColumn(
                  // onSort: controller.sortList,
                  label: _HeaderTitle(
                    'Phân loại',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  numeric: true,
                  label: _HeaderTitle(
                    'Ước tính',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
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
                  bool isExceed = (data.defaultBalance <=
                          data.currentBalance) ||
                      ((data.currentBalance) >= data.defaultBalance * 2 / 3);

                  return DataRow(
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
            onLoading: const IntrinsicHeight(
              child: Center(child: LoadingIndicator()),
            ),
            onEmpty: const Center(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Không có danh mục nào'),
            )),
            onError: (error) =>
                const IntrinsicHeight(child: ErrorCustomWidget()),
          ),
        ],
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

import '../core/styles/style.dart';
import 'skeleton_loading/item_skeleton.dart';

const _heightSkeleton = 25.0;
const _widthSkeleton = 90.0;

class ListLoading extends StatelessWidget {
  const ListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (ctx, index) {
        return Container(
          color: index % 2 == 0
              ? context.background
              : context.tertiary.withOpacity(.6),
          padding: EdgeInsets.symmetric(
            vertical: 11.h,
            horizontal: 7.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ItemLoading(
                width: _widthSkeleton - 20,
                height: _heightSkeleton,
                radius: 4.0,
              ),
              SizedBox(height: 5.h),
              const ItemLoading(
                width: double.infinity,
                height: 90,
                radius: 4.0,
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  ItemLoading(
                    width: _widthSkeleton,
                    height: _heightSkeleton,
                    radius: 4.0,
                  ),
                  ItemLoading(
                    width: _widthSkeleton + _heightSkeleton,
                    height: _heightSkeleton + 5,
                    radius: 4.0,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

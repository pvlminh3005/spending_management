class Classify {
  final String uid;
  final String title;
  final int defaultAmount;
  final int currentAmount;

  Classify({
    required this.uid,
    required this.title,
    this.defaultAmount = 0,
    this.currentAmount = 0,
  });
}

List<Map> listClassify = [
  {
    'uid': 'cls01',
    'title': 'Flutter Basics 1',
    'defaultAmount': 200000,
  },
  {
    'uid': 'cls02',
    'title': 'Flutter Basics 2',
    'defaultAmount': 300000,
  },
  {
    'uid': 'cls03',
    'title': 'Git and GitHub',
    'defaultAmount': 400000,
  },
];

void main(List<String> args) {
  tasks();
}

void tasks() async {
  task1();
  String tsk = await task2();
  task3(tsk);
}

void task3(String task2data) {
  print("task3 with ${task2data}");
}

Future<String> task2() async {
  // sleep(Duration(seconds: 3));

  String res = '';

  await Future.delayed(const Duration(seconds: 3), () {
    res = 'hellos';
    print("task2 ");
  });

  return res;
}

void task1() {
  print("task1 ");
}

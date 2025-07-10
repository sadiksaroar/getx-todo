import 'package:get/get.dart';
import 'package:getx_todo/model/task_model.dart';
import 'package:hive/hive.dart';

class TaskController extends GetxController{

  var taskList = <Task>[].obs;

@override

void onInit(){
  super.onInit();
  openBox();
}
/// open hive databse of todoTasks box 
void openBox() async{
  var box = await Hive.openBox<Task>("todoTask");
  taskList.addAll(box.values);
}

// add box 

void addTask(Task task) async{
  var box = Hive.box<Task>("todoTasks");
  await box.add(task);
  taskList.add(task);
}

void deleteTask(int index) async{
  var box = Hive.box<Task>("todoTasks");
  await box.deleteAt(index);
  taskList.removeAt(index);
}

void editTask(int index, Task newTask) async{
  var box = Hive.box<Task>("todoTasks");
  await box.put(index, newTask);
  taskList[index] = newTask;

}


  
void toggleTaskCompletion(int index, Task newTask) async{
  taskList[index].isCompleted = !taskList[index].isCompleted;
  taskList.refresh();
}

}
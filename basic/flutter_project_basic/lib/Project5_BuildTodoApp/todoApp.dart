import 'package:flutter/material.dart';

class todoApp extends StatefulWidget {
  @override
  State<todoApp> createState() => _todoAppState();
}

class _todoAppState extends State<todoApp> {
  List<String> todoList = ['1', '2'];
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo App",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 90,
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (content, index) {
                  return Card(
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              todoList[index],
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _editTask(todoList[index], index);
                            },
                            icon: Icon(
                              Icons.edit,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _deleteTask(index);
                            },
                            icon: Icon(
                              Icons.delete,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 10,
              child: Row(
                children: [
                  Expanded(
                    flex: 60,
                    child: TextFormField(
                      controller: _taskController,
                      decoration: InputDecoration(
                        labelText: "Create Task",
                        hintText: "Nhập",
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  FloatingActionButton(
                    onPressed: () {
                      addList(_taskController.text);
                    },
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addList(String text) {
    setState(() {
      todoList.add(text);
      _taskController.clear();
    });
  }

  void _deleteTask(index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  void _editTask(task, index) async {
    final TextEditingController _editTaskController = TextEditingController();
    _editTaskController.text = task;
    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Edit task"),
          content: TextField(
            controller: _editTaskController,
            decoration: InputDecoration(
              labelText: "Edit",
              hintText: "chỉnh sửa",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = _editTaskController.text.trim();
                if (name.isNotEmpty) {
                  updatedTask(name, index);
                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void updatedTask(String name, index) async {
    setState(() {
      todoList[index] = name;
    });
  }
}

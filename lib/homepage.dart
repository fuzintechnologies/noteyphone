import 'package:flutter/material.dart';
import 'package:notey/notepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color _color = Colors.teal;
  final String _font = 'Nunito Sans';
  final List semester = [
    'First Semseter',
    'Second Semseter',
    'Third Semseter',
    'Fourth Semseter',
    'Fifth Semseter',
    'Sixth Semseter',
    'Seventh Semseter',
    'Eighth Semseter',
  ];
  final Map subject = {
    'BIT201': 'Principles of Management',
    'BIT202': 'Operating System',
    'BIT203': 'Numerical Analysis',
    'BIT204': 'DataBase Management Systems',
    'BIT205': 'Data Structure and Algorithms',
  };
  @override
  Widget build(BuildContext context) {
    final Orientation _orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Noety',
          style: TextStyle(fontFamily: _font),
        ),
        centerTitle: true,
        backgroundColor: _color,
        actions: [
          IconButton(
            tooltip: 'Admin',
            icon: Icon(Icons.supervised_user_circle_sharp),
            onPressed: () {},
          ),
          // IconButton(
          //   tooltip: 'Notifications',
          //   icon: Icon(Icons.notifications),
          //   onPressed: () {},
          // ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Third Semester',
                    style: TextStyle(fontSize: 30, fontFamily: _font),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: subject.length,
                  itemBuilder: (BuildContextcontext, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SubjectCard(
                        code: '${subject.values.elementAt(index)}',
                        name: '${subject.keys.elementAt(index)}',
                        fun: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotePage(
                              code: '${subject.keys.elementAt(index)}',
                              title: '${subject.values.elementAt(index)}',
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Select Semester',
                    style: TextStyle(fontSize: 30, fontFamily: _font),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 1,
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: _orientation == Orientation.portrait ? 2 : 4,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  children: semester.length > 0
                      ? semester.map((semester) {
                          return SemesterCard(
                            semester: semester,
                          );
                        }).toList()
                      : [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final String _font = 'Nunito Sans';
  SubjectCard({
    required this.code,
    required this.name,
    required this.fun,
  });
  final String code;
  final String name;
  final VoidCallback fun;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          code,
          style: TextStyle(fontFamily: _font),
        ),
        subtitle: Text(
          name,
          style: TextStyle(fontFamily: _font),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: fun,
      ),
    );
  }
}

class SemesterCard extends StatelessWidget {
  SemesterCard({required this.semester});
  final String semester;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Card(
          elevation: 10,
          child: Center(
            child: Text(
              semester,
              textAlign: TextAlign.center,
              softWrap: true,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

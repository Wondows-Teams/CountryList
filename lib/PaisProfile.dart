import 'package:flutter/material.dart';

class PaisProfile extends StatefulWidget {

  @override
  State<PaisProfile> createState() => _PaisProfile();

}

class _PaisProfile extends State<PaisProfile>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'AFGHANISTAN',
              style: Theme.of(context).textTheme.headlineMedium,
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.blue,
                    ),
                    const Text('7.5'),
                  ],
                ),
                Icon( //Image flags
                  Icons.rectangle,
                  color: Colors.red,
                  size: 50.0,
                ),
                const Text(
                  'AFG',
                ),
              ],
            ),



            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Capital: Kabul',
                ),
                const Text(
                  'Población: 40218234',
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Continente: Asia',
                ),
                const Text(
                  'Región: Southern Asia',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Timezone: UTC+04:30',
                ),
                const Text(
                  'Area: 652230.0',
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }


}
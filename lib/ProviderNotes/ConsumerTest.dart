import 'package:flutter/material.dart';
import 'package:consumer/consumer.dart';

/**
 * Created by YHF at 15:52 on 2021-09-15.
 */
class ExampleState {
  int counter = 0;
  String time = DateTime.now().toString();
}

var consumer = Consumer(ExampleState());

class ConsumerTest extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('counter:'),
          consumer.build((ctx, state) {
              return Text(
                state.counter.toString(),
                style: Theme.of(ctx).textTheme.headline4,
              );
            },
            memo: (state) => [state.counter],//订阅只监听哪些值
          ),
          Container(
            child: TextButton(
              onPressed: () {
                consumer.setState((state) {
                  state.counter += 1;
                });
              },
              child: Text("Only Change counter",
                  style: TextStyle(fontSize: 24)),
            ),
            margin: EdgeInsets.only(top: 20, bottom: 40),
          ),
          Text('time:'),
          consumer.build((ctx, state) {
              return Text(
                state.time.toString(),
                style: Theme.of(ctx).textTheme.headline4,
              );
            },
            memo: (state) => [state.time],
          ),
          Container(
            child: TextButton(
              onPressed: () {
                consumer.setState((state) {
                  state.time = DateTime.now().toString();
                });
              },
              child:
              Text("Only Change time", style: TextStyle(fontSize: 24)),
            ),
            margin: EdgeInsets.only(top: 20),
          ),
        ],
      ),
    );
  }
}
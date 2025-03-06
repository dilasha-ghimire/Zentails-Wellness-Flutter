import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:zentails_wellness/features/sensors/presentation/view_model/bloc/sensor_bloc.dart';

class SensorDemoPage extends StatefulWidget {
  const SensorDemoPage({super.key});

  @override
  State<SensorDemoPage> createState() => _SensorDemoPageState();
}

class _SensorDemoPageState extends State<SensorDemoPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<SensorBloc>().add(StartAccelerometerStream());
  }

  @override
  void dispose() {
    context.read<SensorBloc>().add(StopAccelerometerStream());
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollWithTilt(AccelerometerEvent event) {
    double sensitivity = 2.5; // Adjust scrolling speed
    double maxSpeed = 30; // Limit max scrolling speed

    double downwardThreshold =
        1.53; // Only scroll down if Y < 1.53 (phone top tilted downward)
    double delta = 0; // Default: no movement

    if (event.y < downwardThreshold) {
      // Scroll DOWN when phone top is tilted downward
      delta = (downwardThreshold - event.y) * sensitivity;
    }

    // Limit the scrolling speed
    if (delta > maxSpeed) delta = maxSpeed;

    if (_scrollController.hasClients) {
      double offset = _scrollController.offset + delta;

      _scrollController.animateTo(
        offset.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 200), // Smooth transition
        curve: Curves.easeOut, // Natural easing effect
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: BlocBuilder<SensorBloc, SensorState>(
      //     builder: (context, state) {
      //       if (state is ScrollPositionUpdated) {
      //         return Text(
      //             "X: ${state.accelerometerEvent.x.toStringAsFixed(2)}, "
      //             "Y: ${state.accelerometerEvent.y.toStringAsFixed(2)}, "
      //             "Z: ${state.accelerometerEvent.z.toStringAsFixed(2)}");
      //       }
      //       return const Text("Accelerometer Scroll Test");
      //     },
      //   ),
      // ),
      body: BlocListener<SensorBloc, SensorState>(
        listener: (context, state) {
          if (state is ScrollPositionUpdated) {
            _scrollWithTilt(state.accelerometerEvent);
          }
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: 50,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("Item $index"),
              tileColor: index.isEven ? Colors.grey[200] : Colors.white,
            );
          },
        ),
      ),
    );
  }
}

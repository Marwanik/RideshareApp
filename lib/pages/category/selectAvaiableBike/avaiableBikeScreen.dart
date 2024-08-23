import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/Login/AuthBlocLogin.dart';
import 'package:rideshare/bloc/bisycle/bisycle_bloc.dart';
import 'package:rideshare/bloc/bisycle/bisycle_event.dart';
import 'package:rideshare/bloc/bisycle/bisycle_state.dart';
import 'package:rideshare/widget/listTile/bikeAvaiableCatrgoryList.dart';

class AvailableBicyclesScreen extends StatefulWidget {
  final String category;

  AvailableBicyclesScreen({required this.category});

  @override
  _AvailableBicyclesScreenState createState() => _AvailableBicyclesScreenState();
}

class _AvailableBicyclesScreenState extends State<AvailableBicyclesScreen> {
  @override
  void initState() {
    super.initState();
    final token = BlocProvider.of<AuthBlocLogin>(context).authToken;
    if (token != null) {
      context.read<BicycleBloc>().add(FetchBicyclesByCategory(token: token, category: widget.category));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Bicycles'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<BicycleBloc, BicycleState>(
        builder: (context, state) {
          if (state is BicycleLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BicycleLoaded) {
            if (state.bicycles.isEmpty) {
              return Center(child: Text('No bicycles available'));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '${state.bicycles.length} bicycles found',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: state.bicycles.length,
                    itemBuilder: (context, index) {
                      final bicycle = state.bicycles[index];

                      // Convert maintenance to List<String>
                      final maintenanceDetails = (bicycle.maintenance as List<dynamic>)
                          .map((e) => e.toString())
                          .toList();

                      return BicycleItemCategory(
                        model: bicycle.modelPrice.model,
                        price: bicycle.modelPrice.price,
                        size: bicycle.size,
                        type: bicycle.type,
                        photoPath: bicycle.photoPath,
                        note: bicycle.note,
                        maintenanceDetails: maintenanceDetails,
                        onTap: () {
                          // Handle bicycle selection
                          showMaintenanceDetails(context, maintenanceDetails);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is BicycleError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void showMaintenanceDetails(BuildContext context, List<String> maintenanceDetails) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Maintenance Details'),
          content: maintenanceDetails.isEmpty
              ? Text('No maintenance records available.')
              : Column(
            mainAxisSize: MainAxisSize.min,
            children: maintenanceDetails
                .map((detail) => ListTile(
              title: Text(detail),
            ))
                .toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

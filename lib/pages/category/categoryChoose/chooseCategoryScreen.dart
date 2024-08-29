import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rideshare/bloc/Login/AuthBlocLogin.dart';
import 'package:rideshare/bloc/category/category_bloc.dart';
import 'package:rideshare/bloc/category/category_event.dart';
import 'package:rideshare/bloc/category/category_state.dart';
import 'package:rideshare/pages/category/selectAvaiableBike/selectAvaiableBikeScreen.dart';


class SelectBikeScreen extends StatefulWidget {
  @override
  _SelectBiketScreenState createState() => _SelectBiketScreenState();
}

class _SelectBiketScreenState extends State<SelectBikeScreen> {
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    final authBloc = BlocProvider.of<AuthBlocLogin>(context);
    final token = authBloc.authToken;
    if (token != null) {
      context.read<CategoryBloc>().add(FetchCategories(token: token));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Bicycle Category'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select your bicycle category',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is CategoryLoaded) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        final category = state.categories[index];
                        final isSelected = selectedCategory == category.name;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = category.name;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AvailableBicyclesScreen(
                                  category: category.name,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                color: isSelected ? Colors.green : Colors.grey.shade300,
                                width: 2,
                              ),
                            ),
                            color: isSelected ? Colors.green.shade50 : Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.directions_bike,
                                  size: 50,
                                  color: isSelected ? Colors.green : Colors.black,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  category.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: isSelected ? Colors.green : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is CategoryError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Container(); // Should not reach here
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

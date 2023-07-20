import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/ragistar/ragistar_cubit.dart';
import '../forminsert/forminsert_cubit.dart';
import '../forminsert/forminsertscreens.dart';

class FormViewScreens extends StatelessWidget {
  const FormViewScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => FormInsertCubit(),
        child: BlocBuilder<FormInsertCubit, FormInsertState>(
          builder: (context, state) {
            return StreamBuilder(
              stream: FirebaseFirestore.instance.collection("form").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.size <= 0) {
                    return const Center(
                      child: Text("No Data"),
                    );
                  } else {
                    return ListView(
                      children: snapshot.data!.docs.map((document) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.pink.shade50,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(document["name"].toString()),
                                          Text(document["email"].toString()),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                print("itemid===============${document.id.toString()}");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          FormInsertScreens(updateId:document.id.toString()),
                                                    ));
                                              },
                                              icon: const Icon(Icons.update)),
                                          IconButton(
                                              onPressed: () {
                                                context
                                                    .read<FormInsertCubit>()
                                                    .deleteFormData(context, document.id.toString());
                                              },
                                              icon: const Icon(Icons.delete)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:uia_hackathon_app/constants/text_styles.dart';
import 'dart:math';

import '../constants/color_constants.dart';
import '../custom_widgets/custom_button.dart';
import '../custom_widgets/custom_input_field.dart';
import 'main_page.dart';

class DiseaseClassification extends StatefulWidget {
  const DiseaseClassification({super.key});

  @override
  State<DiseaseClassification> createState() => _DiseaseClassificationState();
}

class _DiseaseClassificationState extends State<DiseaseClassification> {
  CollectionReference dbRef = FirebaseFirestore.instance.collection('initial');
  Random random = Random();
  List<Map> descriptions = [
    {
      'disease': 'Potato Early blight',
      'description':
          'Early blight is primarily a disease of stressed or senescing plants. Symptoms appear first on the oldest foliage. Affected leaves develop circular to angular dark brown lesions 0.12 to 0.16 inch (3–4 mm) in diameter. Concentric rings often form in lesions to produce characteristic target-board effect.',
      'pesticides': [
        'Katyayani Copper Oxy Chloride 50% Broad Spectrum Fungicide For Plants & Home Garden Controls Early And Late Blight Leaf',
        'chlorothalonil'
      ]
    },
    {'disease': 'Potato Healthy', 'description': '', 'pesticide': []},
    {
      'disease': 'Potato Late blight',
      'description':
          'Late blight is caused by the fungal-like oomycete pathogen Phytophthora infestans. The primary host is potato, but P. infestans also can infect other solanaceous plants, including tomatoes, petunias and hairy nightshade. These infected species can act as source of inoculum to potato.',
      'pesticides': [
        'Katyayani Ametoctradin 27% + Dimethomorph 20.27% SC Systemic fungicide',
        'Katyayani Copper Oxy Chloride 50% Broad Spectrum Fungicide',
      ]
    },
  ];
  late File image;
  late List results;
  bool imageSelected = false;
  bool isOut = false;
  int index = 0;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    String? res;
    res = await Tflite.loadModel(
        model: 'assets/model.tflite', labels: 'assets/labels.txt');
    print(res);
  }

  Future classifyDisease(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path, // required
      imageMean: 127.5, // defaults to 117.0
      imageStd: 127.5, // defaults to 1.0
      numResults: 2, // defaults to 5
      threshold: 0.2, // defaults to 0.1
    );

    setState(() {
      results = recognitions!;
      if (results[0]['index'].toInt() > 2) {
        setState(() {
          index = -1;
        });
        print('It is not a potato image ');
      } else {
        setState(() {
          index = results[0]['index'].toInt();
        });
      }
      print(index);
      image = image;
      imageSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: dbRef.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Select an image of the plant',
                          style: kHeaderStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'We will predict the disease of your plant and suggest some measures to prevent it',
                          textAlign: TextAlign.center,
                          style: kSubtitleStyle,
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: InkWell(
                          onTap: () async {
                            await dbRef.doc('values').update({
                              "kval": random.nextDouble() +
                                  random.nextInt(170) +
                                  30,
                              "nval": random.nextDouble() +
                                  random.nextInt(170) +
                                  30,
                              "pval":
                                  random.nextDouble() + random.nextInt(170) + 30
                            });
                            pickImageFromCamera();
                          },
                          child: CustomButton(
                            icon: Icon(Icons.camera),
                            title: 'Capture Image with Camera',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: InkWell(
                          onTap: () async {
                            await dbRef.doc('values').update({
                              "kval": random.nextDouble() +
                                  random.nextInt(170) +
                                  30,
                              "nval": random.nextDouble() +
                                  random.nextInt(170) +
                                  30,
                              "pval":
                                  random.nextDouble() + random.nextInt(170) + 30
                            });
                            pickImageFromGallery();
                          },
                          child: CustomButton(
                            icon: Icon(Icons.file_open_rounded),
                            title: 'Pick Image From Gallery',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      imageSelected
                          ? index == -1
                              ? Column(
                                  children: [
                                    LottieBuilder.asset('assets/error.json'),
                                    Text(
                                      'oops! it is not a potato image',
                                      style: kNameStyle,
                                    ),
                                  ],
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            height: 300,
                                            width: 500,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                              image: FileImage(image),
                                              fit: BoxFit.fill,
                                            ))),
                                      ),
                                      Text(
                                        'Disease : ${descriptions[index]['disease']}',
                                        style: kValueStyle,
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      index != 1
                                          ? Text(
                                              'About the disease',
                                              style: kTileValueStyle,
                                            )
                                          : Text(''),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          descriptions[index]['description'],
                                          style: kSubtitleStyle,
                                        ),
                                      ),
                                      index != 1
                                          ? Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'N = ${(streamSnapshot.data!.docs[0]['nval']).round()}',
                                                        style: kNameStyle,
                                                      ),
                                                      Text(
                                                        'p = ${streamSnapshot.data!.docs[0]['pval'].round()}',
                                                        style: kNameStyle,
                                                      ),
                                                      Text(
                                                        'k = ${streamSnapshot.data!.docs[0]['kval'].round()}',
                                                        style: kNameStyle,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            _buildPopupDialog(
                                                                context,
                                                                index,
                                                                descriptions),
                                                      );
                                                    },
                                                    child: CustomButton(
                                                        icon:
                                                            Icon(Icons.search),
                                                        title:
                                                            'search for pesticides'),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Text(''),
                                    ],
                                  ),
                                )
                          : const Text(''),
                    ],
                  ),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
      // bottomNavigationBar: InkWell(
      //     child: Container(
      //         height: 60,
      //         width: MediaQuery.of(context).size.width,
      //         decoration: BoxDecoration(
      //           color: kprimaryGreenColor,
      //         ),
      //         child: Center(child: Text('Next', style: kButtonStyle))),
      //     onTap: () {
      //       setState(() {
      //         isOut = true;
      //       });
      //       classifyDisease(image);
      //     }),
    );
  }

  Future pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      image = File(pickedFile!.path);
    });

    print('done');
    classifyDisease(image);
  }

  Future pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      image = File(pickedFile!.path);
    });

    print('done');
    classifyDisease(image);
  }
}

Widget _buildPopupDialog(BuildContext context, int index, List descriptions) {
  return AlertDialog(
    title: const Text('Pesticide List'),
    content: Container(
      height: 200,
      width: 400,
      child: ListView.builder(
          itemCount: descriptions[index]['pesticides'].length,
          itemBuilder: ((context, indexx) {
            return Text(
              textAlign: TextAlign.start,
              '${indexx + 1} ${descriptions[index]['pesticides'][indexx]}',
              style: kTileValueStyle,
            );
          })),
    ),
    actions: <Widget>[
      new TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}

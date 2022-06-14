
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import '../data/db_manager.dart';
import '../models/animal.dart';
import '../providers/sex_selection_provider.dart';
import '../util/custom_alert.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/sex_selection.dart';


class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

 
   late TextEditingController labelController;
   late TextEditingController ageController;
   late TextEditingController categoryController;
   late TextEditingController annotationController;

    late FocusNode labelNode;
    late FocusNode ageNode;
    late FocusNode categoryNode;
    late FocusNode annotationNode;

    late List<TextEditingController> controllers;
    
    @override
    void initState() {
      labelController      = TextEditingController();
      ageController        = TextEditingController();
      categoryController   = TextEditingController();
      annotationController = TextEditingController();
      controllers = [labelController,ageController,categoryController];
    
      labelNode      =  FocusNode();
      ageNode        =  FocusNode();
      categoryNode   =  FocusNode();
      annotationNode =  FocusNode();

      super.initState();
    }

   

     Future<void> scanBarcodeNormal() async {
      String barcodeScanRes;
    
      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.BARCODE
        );
       
      } on PlatformException {
        barcodeScanRes = 'Error al momento de leer el código de barras';
      }
      if (!mounted) return;

      setState(() {
        labelController.text = barcodeScanRes;
      });
    }

    
    @override
    void dispose() { 
      labelController.dispose();
      ageController.dispose();
      categoryController.dispose();
      annotationController.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final selectionProv = Provider.of<SexSelectionProvider>(context);

    bool validate(){
      int countError = 0; 
      for (var controller in controllers) {
        if (controller.text == '') {
          countError ++;
          break;
        }
      }
      return countError == 0 ? true : false;
    }

    void _clearTextsFields() {
      labelController.text      = '';    
      ageController.text        = '';  
      categoryController.text   = '';  
      annotationController.text = '';
    }



    void _onTapCreate() async{

       if ( validate()) {

        var list  = await DBManager.db.getAll();
        final int  id = list.isEmpty ?  0 : (list[0].id) + 1 ;
      
        var animal = Animal(
          id:id,
          label: labelController.text,
          sex: selectionProv.isFemaleSelected ? 0 : 1,
          age: ageController.text,
          category: categoryController.text,
          annotations: annotationController.text

        );
        try {
          DBManager.db.create(
            animal: animal
          );
          CustomAlert.showSucces(context: context , desc: 'Registro creado');
          _clearTextsFields();
        } catch (e) {
          CustomAlert.showError(context: context );
        }
          
      }else{
         CustomAlert.showErrorCustomText(context: context , desc: 'Complete al menos los primeros 3 campos' );
      }
    }




    return Padding(
      padding: EdgeInsets.only(top:size.height * 0.03),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()) ,
        child: Form(
          child: ListView(
            children: [
              const SexSelection(),
              SizedBox(
                height:size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    isExtended: false,
                    focusNode: labelNode,
                    nextFocusNode: ageNode,
                    controller: labelController,
                    label: 'Etiqueta',
                  ),
                 Container(
                   width: 50.0,
                   height: 50.0,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(20),
                     color: Theme.of(context).highlightColor,
                     boxShadow: const [
                       BoxShadow(
                          color: Color(0xFFBDBDBD),
                          offset: Offset(3, 3),
                          blurRadius: 7
                       )
                     ]
                   ),
                   child: IconButton(
                      icon: const Icon(Icons.camera),
                      onPressed: ()=>scanBarcodeNormal(),
                      color: Colors.white,
                    ),
                 ),
                ],
              ),
              CustomTextField(
                isExtended: false,
                focusNode: ageNode,
                nextFocusNode: categoryNode,
                controller: ageController,
                label: 'Edad',
              ),
              CustomTextField(
                isExtended: false,
                focusNode: categoryNode,
                nextFocusNode: annotationNode,
                controller: categoryController,
                label: 'Raza',
              ),
              CustomTextField(
                isExtended: true,
                focusNode:annotationNode,
                controller: annotationController,
                label: 'Observación',
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: size.width * 0.30 , vertical:  size.height * 0.02),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:  MaterialStateProperty.all(Theme.of(context).highlightColor),
                    shape:  MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    )
                  ),
                  onPressed: _onTapCreate,
                  child: const  Text('Crear' , style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }

 
  
}
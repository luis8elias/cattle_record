
import 'dart:io';
import 'package:cattle_record/models/animal.dart';
import 'package:cattle_record/util/custom_alert.dart';
import 'package:cattle_record/widgets/custom_text_field.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../data/db_manager.dart';


class ExportPage extends StatefulWidget {
  const ExportPage({Key? key}) : super(key: key);

  @override
   State<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {

  late TextEditingController sheetNameController;


  @override
  void dispose() {
    sheetNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    sheetNameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    void _onTapExportButton() async{

      var list  = await DBManager.db.getAll();

      if (list.isEmpty){
          CustomAlert.showErrorCustomText(context: context , desc: 'No hay registros que exportar');
      }else{

        if( sheetNameController.text != ''){
          final directory = await getExternalStorageDirectory();
       
          var now = DateTime.now();
          String docName = '${now.day}-${now.month}-${now.year}-${now.hour}-${now.minute}-${now.second}';
          File file = File('${directory?.path}/$docName.xlsx');
          var excel = Excel.createExcel();
          Sheet sheetObject = excel[sheetNameController.text];

        final CellStyle headerCellStyle = CellStyle(
          backgroundColorHex: "#A6A6A6",
          bold : true,
          verticalAlign: VerticalAlign.Center,
          horizontalAlign: HorizontalAlign.Center,
          fontSize: 12
        );
        final  CellStyle noLectorCellStyle = CellStyle(
            backgroundColorHex: "#D0CECE",
            bold : false,
            verticalAlign: VerticalAlign.Center,
            horizontalAlign: HorizontalAlign.Center,
            fontSize: 11
          );

          final CellStyle defaultCellStyle = CellStyle(
            backgroundColorHex: "#FFFFFF",
            bold : false,
            verticalAlign: VerticalAlign.Center,
            horizontalAlign: HorizontalAlign.Center,
            fontSize: 11
          );


          var noLecCellHeader = sheetObject.cell(CellIndex.indexByString("B3"));
          noLecCellHeader.cellStyle = headerCellStyle;
          noLecCellHeader.value = 'No. Lector';
          

          var areteCellHeader = sheetObject.cell(CellIndex.indexByString("C3"));
          areteCellHeader.value = 'Arete';
          areteCellHeader.cellStyle = headerCellStyle;

          var sexCellHeader = sheetObject.cell(CellIndex.indexByString("D3"));
          sexCellHeader.value = 'Sexo';
          sexCellHeader.cellStyle = headerCellStyle;

          var ageCellHeader = sheetObject.cell(CellIndex.indexByString("E3"));
          ageCellHeader.value = 'Edad';
          ageCellHeader.cellStyle = headerCellStyle;

          var razaCellHeader = sheetObject.cell(CellIndex.indexByString("F3"));
          razaCellHeader.value = 'Raza';
          razaCellHeader.cellStyle = headerCellStyle;

          var obCellHeader = sheetObject.cell(CellIndex.indexByString("G3"));
          obCellHeader.value = 'Observación';
          obCellHeader.cellStyle = headerCellStyle;


          int cellCount = 4 ; 


          for (var i = 0; i < list.length; i++) {

            Animal tempAn = list[i];
            
          
            var noLecCell = sheetObject.cell(CellIndex.indexByString("B$cellCount"));
            noLecCell.value = tempAn.label;
            noLecCell.cellStyle = noLectorCellStyle;
            String subLabel= '';
           
           try {
             subLabel = tempAn.label.substring(0,10);
           } catch (e) {
             CustomAlert.showErrorCustomText(context: context , desc: 'Numero de etiqueta demasiado corto');
             break;
           }


            var areteCell = sheetObject.cell(CellIndex.indexByString("C$cellCount"));
            areteCell.value = subLabel;
            areteCell.cellStyle = defaultCellStyle;

           
            var sexCell = sheetObject.cell(CellIndex.indexByString("D$cellCount"));
            sexCell.value = tempAn.sex == 0 ? 'Hembra' : 'Macho';
            sexCell.cellStyle = defaultCellStyle;

            
            var ageCell = sheetObject.cell(CellIndex.indexByString("E$cellCount"));
            ageCell.value = tempAn.age;
            ageCell.cellStyle = defaultCellStyle;

            
            var razaCell = sheetObject.cell(CellIndex.indexByString("F$cellCount"));
            razaCell.value = tempAn.category;
            razaCell.cellStyle = defaultCellStyle;

           
            var obsCell = sheetObject.cell(CellIndex.indexByString("G$cellCount"));
            obsCell.value = tempAn.annotations == '' ? 'Ninguna'  : tempAn.annotations;
            obsCell.cellStyle = defaultCellStyle;

            cellCount++;
            
          }

          var isSet = excel.setDefaultSheet(sheetNameController.text);
          if ( ! isSet) {
            CustomAlert.showError(context: context );
          } 

          excel.delete('Sheet1');


          try {
            var decodedExcel = excel.encode();
            file.writeAsBytesSync(decodedExcel!);
          } catch (e) {
            CustomAlert.showError(context: context );
          }

          CustomAlert.showSucces(context: context , desc: 'Guradado en ${directory?.path}/$docName.xlsx');
          await DBManager.db.deleteAll();
          sheetNameController.text  ='';

        }else {
          CustomAlert.showErrorCustomText(context: context , desc: 'Introduzca el nombre de la hoja de cálculo');
        }

     
        
      }
    }

    return SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()) ,
            child: SizedBox(
                  height: size.height -  size.height * 0.10,
                  width: size.width,
                  child: Stack(children: <Widget>[
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Color(0xFFBDBDBD),
                                offset: Offset(5, 5),
                                blurRadius: 3)
                          ],
                          
                           color: Theme.of(context).highlightColor,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget> [
                              Text(
                                "Exportar a Excel",
                                style: TextStyle(color: Colors.white, fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding:  EdgeInsets.only(top: size.height * 0.25),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child:  Image.asset('assets/excel.png'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: CustomTextField(
                                isExtended: false,
                                controller: sheetNameController,
                                label: 'Nombre de la hoja',
                                focusNode: null,
                              ),
                            ),
                             Padding(
                              padding:  EdgeInsets.symmetric(horizontal: size.width * 0.30 , vertical:  size.height * 0.05),
                              child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:  MaterialStateProperty.all(Theme.of(context).highlightColor),
                                shape:  MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                )
                              ),
                              onPressed: _onTapExportButton,
                              child: const  Text('Crear' , style: TextStyle(color: Colors.white, fontSize: 16)),
                            ),
                            )
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
          ),
    );
  }
}
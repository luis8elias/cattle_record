import 'package:cattle_record/models/animal.dart';
import 'package:cattle_record/providers/count_elements.dart';
import 'package:cattle_record/util/custom_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../data/db_manager.dart';

class CustomTile extends StatelessWidget {

  final Animal animal;

  const CustomTile({ Key? key, required this.animal}) : super(key: key) ;
  @override
  Widget build(BuildContext context) {


    var elementsProv = Provider.of<CountElementsProvider>(context, listen: false);

   

    _onTapDelete() async {

      try {
        DBManager.db.delete(
          id: animal.id
        );
        var list =  await DBManager.db.getAll();
        elementsProv.count  = list.length;
        CustomAlert.showSucces(context: context , desc: 'Registro borrado');
         
      } catch (e) {
         CustomAlert.showError(context: context );
      }
    }
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: (BuildContext buildContext) => {
              _onTapDelete()
            },
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).errorColor,
            icon: Icons.delete,
            label: 'Eliminar',
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
           BoxShadow(
                color: Color(0xFFBDBDBD),
                offset: Offset(2, 2),
                blurRadius: 2
            )
        ],
        color: Colors.white,
      ),
      width: double.infinity,
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 3, color: Theme.of(context).highlightColor),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(animal.sex == 0 ? 'assets/cow.svg' : 'assets/bull.svg' ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.local_offer,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                     Text(
                      animal.label,
                        style: TextStyle(
                          color: Theme.of(context).highlightColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.calendar_today,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      animal.age,
                        style: TextStyle(
                            color: Theme.of(context).highlightColor, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.panorama_fish_eye,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      animal.sex == 0 ? 'Hembra' : 'Macho',
                      style: TextStyle(
                      color: Theme.of(context).highlightColor, fontSize: 13, letterSpacing: .3)
                    ),
                  ],
                ),
                 const SizedBox(
                  height: 6,
                ),
                 Row(
                  children: <Widget>[
                    Icon(
                      Icons.remove_red_eye,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      animal.annotations == '' ? 'Ninguna' : animal.annotations,
                        style: TextStyle(
                          color: Theme.of(context).highlightColor,
                          fontSize: 13,
                          letterSpacing: .3
                        )
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ), 
      ),
     
      

    );


    /* return Slidable(
      actionPane: SlidableDrawerActionPane(), 
      actionExtentRatio: 0.25,
      child: Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
           BoxShadow(
                color: Colors.grey[400],
                offset: Offset(2, 2),
                blurRadius: 2
            )
        ],
        color: Colors.white,
      ),
      width: double.infinity,
      height: 120,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 3, color: Theme.of(context).accentColor),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(animal.sex == 0 ? 'assets/cow.svg' : 'assets/bull.svg' ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.local_offer,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                     Text(
                      '${animal.label}',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      ),
                  ],
                ),
               
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.calendar_today,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${animal.age}',
                        style: TextStyle(
                            color: Theme.of(context).accentColor, fontSize: 13, letterSpacing: .3)),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.panorama_fish_eye,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${animal.sex == 0 ? 'Hembra' : 'Macho'}',
                        style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 13, letterSpacing: .3)
                    ),
                  ],
                ),
                 SizedBox(
                  height: 6,
                ),
                 Row(
                  children: <Widget>[
                    Icon(
                      Icons.remove_red_eye,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${animal.annotations == '' ? 'Ninguna' : animal.annotations}',
                        style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 13, letterSpacing: .3)
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ), 
      ),
      actions: [
        IconSlideAction(
          color:Color(0xfff0f0f0),
          iconWidget: Icon(Icons.delete , color: Theme.of(context).accentColor,),
          onTap: _onTapDelete
        ),
      ],
    ); */
  }
}
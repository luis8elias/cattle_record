import 'package:cattle_record/models/animal.dart';
import 'package:cattle_record/util/custom_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/db_manager.dart';
import '../providers/count_elements.dart';
import '../widgets/custom_tile.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var elementsProv = Provider.of<CountElementsProvider>(context, listen: false);

    _onTapDeleteAll() async {

      var list  = await DBManager.db.getAll();

      if (list.isEmpty) {
        CustomAlert.showErrorCustomText(context: context , desc: 'No hay registros que borrar');
      }else{
        try {
          DBManager.db.deleteAll();
          var list =  await DBManager.db.getAll();
          elementsProv.count  = list.length;
          CustomAlert.showSucces(context: context , desc: 'Todos los registros borrados');
        } catch (e) {
          CustomAlert.showError(context: context );
        }
      }
      
    }

    return Consumer<CountElementsProvider>(
        builder: (context, elementProv, _) => SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 110),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: FutureBuilder<List<Animal>>(
                  future: DBManager.db.getAll(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final List<Animal> records = snapshot.data;
                    records.sort((a, b) => a.id.compareTo(b.id));
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      elementProv.count = records.length;
                    });
                    if (records.isEmpty) {
                      return const Center(
                        child: Text('No hay Registros'),
                      );
                    }
                    return ListView.builder(
                        itemCount: records.length,
                        itemBuilder: (context, index) => CustomTile(
                              animal: records[index],
                        )
                    );
                  },
                ),
              ),
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
                      borderRadius: const  BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)
                        )
                      ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget> [
                          const Text(
                            "Registros",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          IconButton(
                            onPressed: _onTapDeleteAll,
                            icon: const Icon(
                              Icons.delete_sweep,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]
            ),
          )
    );
  }

 
}

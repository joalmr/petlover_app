import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proypet/src/model/mascota/mascota_req.dart';
import 'package:proypet/src/model/raza/raza_model.dart';
import 'package:proypet/src/pages/shared/appbar_menu.dart';
import 'package:intl/intl.dart';
import 'package:proypet/src/pages/shared/ddl_control.dart';
import 'package:proypet/src/pages/shared/form_control/button_primary.dart';
import 'package:proypet/src/pages/shared/form_control/text_from.dart';
import 'package:proypet/src/pages/shared/styles/styles.dart';
import 'package:proypet/src/providers/mascota_provider.dart';
import 'package:proypet/src/providers/raza_provider.dart';
import 'package:proypet/src/utils/utils.dart';

final tipopet = [{'id':'1','name':'Gato',},{'id':'2','name':'Perro'}];

class MascotaAgregarPage extends StatefulWidget {
  @override
  _MascotaAgregarPageState createState() => _MascotaAgregarPageState();
}

class _MascotaAgregarPageState extends State<MascotaAgregarPage> {
  String _fecha ='';
  final _shape = BorderRadius.circular(10.0);
  TextEditingController _inputFechaController=new TextEditingController();

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final mascotaProvider = new MascotaProvider();
  final razaProvider = new RazaProvider();
  MascotaReq petReq = new MascotaReq();

  bool btnBool = true;
  String datoPet = tipopet[0]['id'];
  File foto;

  String opcRaza= '390'; // : razaGato[0]['cod'] ;

  @override
  Widget build(BuildContext context) {
    
    petReq.specie= int.tryParse(datoPet);
    petReq.breed= int.tryParse(opcRaza);

    return Scaffold(
      key: scaffoldKey,
      appBar: appbar(
        // null,
        Text('Agregar mascota',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal
          ),
        ),
        null,
      ),
      body: Stack(
        children: <Widget>[
            SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(                
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 25.0,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35.0, 0, 35.0, 10.0),
                      child: Center(
                        child: Stack(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: _mostrarFoto(),//AssetImage('images/no-image.png'),
                              radius: 80.0,
                            ),
                            Positioned(
                              bottom: 1.5,
                              right: 10.0,
                              child: CircleAvatar(
                                child: IconButton(
                                  icon: Icon(Icons.camera_enhance,color: Colors.white), 
                                  onPressed: ()=>showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return SimpleDialog(
                                      //title: const Text('Select assignment'),
                                      children: <Widget>[
                                        SimpleDialogOption(
                                          child: const Text('Tomar foto'),
                                          onPressed: _tomarFoto,                                          
                                        ),
                                        SimpleDialogOption(
                                          child: const Text('Seleccionar foto'),
                                          onPressed: _seleccionarFoto,                                          
                                        ),
                                      ],
                                    );
                                  }
                                ),                                  
                                ),
                                backgroundColor: colorMain,
                                radius: 22.0,
                              )
                            )
                          ],
                        ),
                      ) //Text('Foto de mi mascota'),
                    ),
                    SizedBox(height: 10.0,),
                    textForm('Nombre de mascota', Icons.pets, false, (value)=>petReq.name=value, TextCapitalization.words),
                    SizedBox(height: 10.0,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35.0, 0, 35.0, 10.0),
                      child: Text('Seleccione tipo de mascota'),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35.0, 0, 35.0, 10.0),
                      child: ddlMain(datoPet, tipopet, 
                        (opt){ setState(() {
                          datoPet=opt; 
                          petReq.specie= int.tryParse(opt);
                          if(datoPet=='1'){
                            opcRaza='390';
                          } 
                          else{
                            opcRaza='1';
                          }  
                        }
                      );}),
                    ),
                    SizedBox(height: 10.0,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35.0, 0, 35.0, 10.0),
                      child: Text('Seleccione raza'),
                    ),
                    FutureBuilder(
                      future: razaProvider.getBreed(datoPet),
                      builder: (BuildContext context, AsyncSnapshot<RazaModel> snapshot) {
                        if(!snapshot.hasData){
                          return Center(child: CircularProgressIndicator());
                        }
                        else{
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(35.0, 0, 35.0, 10.0),
                            child: ddlFuture( opcRaza , snapshot.data.breeds , 
                              (opt){ setState(() { 
                                opcRaza=opt;
                                petReq.breed=int.tryParse(opt);
                              }); }
                            ),
                          );
                        } 
                      },
                    ),
                    // ddlSearchFuture(opcRaza , snapshot.data.breeds , 
                    //   (opt){ setState(() { 
                    //     opcRaza=opt;
                    //     petReq.breed=int.tryParse(opt);
                    //   }); }),
                    SizedBox(height: 10.0,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35.0, 0, 35.0, 10.0),
                      child: Text('Fecha de nacimiento'),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35.0, 0, 35.0, 10.0),
                      child: _crearFecha(context),
                    ),
                    SizedBox(height: 10.0,),                    
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35.0, 0, 35.0, 10.0),
                      child: _sexo()
                    ),
                    SizedBox(height: 25.0,),
                    Center(
                      child: buttonPri('Agregar mascota', btnBool ? _onAdd : null ) //()=>agregarDialog()
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  
  

  Widget _crearFecha(BuildContext context){
    return Material(
      elevation: 0.0,
      borderRadius: _shape,
      color: Colors.grey[200],
      child: TextFormField(
        enableInteractiveSelection: false,
        controller: _inputFechaController,
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        },
        //onChanged: (value)=>petReq.birthdate=value,
        onSaved: (value)=>petReq.birthdate=value,
        cursorColor: colorMain,
        decoration: InputDecoration(
          hintText: 'Fecha de nacimiento',
          hintStyle: TextStyle(fontSize: 14.0),
          prefixIcon: Material(
            //elevation: 0.0,
            borderRadius: _shape,
            color: Colors.grey[200],
            child: Icon(
              Icons.calendar_today,
              color: colorMain,
            ),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0)
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context, 
      initialDate: new DateTime.now(), 
      //firstDate: new DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day), 
      firstDate: new DateTime(DateTime.now().year-25),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year
    );

    if(picked!=null){
      final f = new DateFormat('yyyy-MM-dd');
      setState(() {
        _fecha= f.format(picked);
        _inputFechaController.text = _fecha;
      });
    }
  }

  Widget _sexo(){
    return SwitchListTile(
      value: petReq.genre,
      title: Text('Sexo'),
      subtitle: petReq.genre ? Text('Macho') : Text('Hembra'),
      activeColor: colorMain,
      onChanged: (value)=> setState((){
        petReq.genre = value;
      }),
    );
  }

  _mostrarFoto(){
    //return AssetImage(foto?.path ?? 'images/no-image.png');

    if(foto!=null){
      return FileImage(foto);
    }
    //foto?.path ?? 
    return AssetImage('images/no-image.png');

  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    var imagen = await ImagePicker.pickImage(source: origen);

    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imagen.path,
      maxHeight: 350,
      maxWidth: 350,
      cropStyle: CropStyle.circle,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 80,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Recortar',
        toolbarColor: colorMain,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: true,
        activeControlsWidgetColor: colorMain,
        showCropGrid: false,
      ),
      iosUiSettings: IOSUiSettings(
        title: 'Recortar',
        minimumAspectRatio: 1.0,
        aspectRatioLockEnabled: true, 
      )
    );

    // var result = await FlutterImageCompress.compressAndGetFile(
    //     croppedFile.path, 
    //     croppedFile.path,
    //     quality: 65,
    //   );
    
    if(foto!=null){
      //limpieza
    }
    
    setState(() {
      foto = croppedFile;
    });
    // print(foto.lengthSync());
    Navigator.pop(context);
  }

  void _onAdd() async {
    try {
      setState(() {
        formKey.currentState.save();
        btnBool = false;      
      });
      
      if(petReq.name.trim()=='' || petReq.birthdate.trim()=='') setState(() {
        mostrarSnackbar('Debe completar los datos de la mascota.', Colors.red[300]);  
        btnBool = true;      
      });

      else {

        final resp = await mascotaProvider.savePet(petReq, foto);

        if(resp){
          mostrarSnackbar('Mascota agregada.', colorMain);  
          Timer(
            Duration(milliseconds: 2500), (){
              Navigator.pop(context);
            }
          );
        
        }
        else setState(() {
          mostrarSnackbar('No se agregadó la mascota.', Colors.red[300]);  
          btnBool = true;      
        });

      }
      
    }
    
    catch(e) {
      setState(() {
        mostrarSnackbar('No se agregadó la mascota.', Colors.red[300]);
        btnBool = true;      
      });
    }
  }
  //Colors.red[300]
  void mostrarSnackbar(String mensaje, Color color){
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 2500),
      backgroundColor: color,
    );
    scaffoldKey.currentState.showSnackBar(snackbar);    
  }

}
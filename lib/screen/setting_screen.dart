import 'package:calculatebadminton/model/setting_model.dart';
import 'package:calculatebadminton/repository/setting_repository.dart';
import 'package:calculatebadminton/widgets/leftnavigation.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var txtCostCortController = TextEditingController();
  var txtCostShuttleCockController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getSetting();
  }

  _getSetting() async {
    SettingRepository settingRepository = SettingRepository();
    List listSetting = await settingRepository.getAll();
    List list = await listSetting;
    for (var setting in list) {
      txtCostCortController.text = setting['costCort'].toString();
      txtCostShuttleCockController.text = setting['costShuttleCock'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: LeftNavigation(),
        appBar: AppBar(
          title: Text('ตั้งค่าระบบ', style: TextStyle(color: Colors.white)),
        ),
        body: Padding(
            padding: const EdgeInsets.all(25),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
                children: [
                  TextField(
                    controller: txtCostCortController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(label: Text('ค่าคอดแบด')),
                  ),
                  TextField(
                    controller: txtCostShuttleCockController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(label: Text('ค่าลูกแบด')),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.pinkAccent),
                    onPressed: () async {
                      SettingRepository settingRepository = SettingRepository();
                      List listSetting = await settingRepository.getAll();
                      List list = await listSetting;
                      SettingModel settingModel = SettingModel();
                      settingModel.costCort =
                          int.parse(txtCostCortController.text);
                      settingModel.costShuttleCock =
                          int.parse(txtCostShuttleCockController.text);
                      if (list.length > 0) {
                        settingRepository.edit(settingModel);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('แก้ไขข้อมูลเรียบร้อย'),
                            duration: Duration(
                                seconds: 3), // ระยะเวลาในการแสดง SnackBar
                          ),
                        );
                      } else {
                        settingRepository.add(settingModel);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('บันทึกข้อมูลเรียบร้อย'),
                            duration: Duration(
                                seconds: 3), // ระยะเวลาในการแสดง SnackBar
                          ),
                        );
                      }
                    },
                    child: Text('บันทึก'),
                  )
                ],
              ),
            )));
  }
}

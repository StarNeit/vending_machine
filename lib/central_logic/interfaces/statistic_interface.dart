import 'package:vending_machine/central_logic/database/vending_machine_data_model.dart';

abstract class IStatistic {
  Future<VendingMachineDataModel?> getMachineData();
}

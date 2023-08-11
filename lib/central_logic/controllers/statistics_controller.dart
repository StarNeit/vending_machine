import 'package:vending_machine/central_logic/database/vending_machine_data_cached_client.dart';
import 'package:vending_machine/central_logic/database/vending_machine_data_model.dart';
import 'package:vending_machine/central_logic/interfaces/statistic_interface.dart';

class StatisticController implements IStatistic {
  @override
  Future<VendingMachineDataModel?> getMachineData() async {
    return await VendingMachineDataCachedClient.instance.getData();
  }
}

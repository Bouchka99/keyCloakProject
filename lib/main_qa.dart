import 'package:keycloack_proj/flavor_config.dart';
import 'package:keycloack_proj/main_common.dart';

void main(){
  //final qaConfig = FlavorConfig(variable: "from test");

  FlavorConfig.initialize(Flavor.TESTING);
  FlavorConfig flavorConfig = FlavorConfig.getInstance();
  print("voilaaaaaaaaaaaaaa ${flavorConfig.variable}");
  mainCommon();

}


import 'package:keycloack_proj/flavor_config.dart';
import 'package:keycloack_proj/main_common.dart';

void main(){
  //FlavorConfig(variable: "from deve");
  FlavorConfig.initialize(Flavor.DEVELOPMENT);
  FlavorConfig flavorConfig = FlavorConfig.getInstance();
  print("voilaaaaaaaaaaaaaaa ${flavorConfig.variable}");
  mainCommon();


}
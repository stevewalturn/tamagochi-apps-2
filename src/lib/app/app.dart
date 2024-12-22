import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/ui/views/home/home_view.dart';
import 'package:my_app/ui/views/startup/startup_view.dart';
import 'package:my_app/features/pet_creation/pet_creation_view.dart';
import 'package:my_app/features/pet_home/pet_home_view.dart';
import 'package:my_app/features/pet_stats/pet_stats_view.dart';
import 'package:my_app/features/mini_games/feeding/feeding_game_view.dart';
import 'package:my_app/features/mini_games/cleaning/cleaning_game_view.dart';
import 'package:my_app/features/mini_games/exercise/exercise_game_view.dart';
import 'package:my_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:my_app/ui/bottom_sheets/pet_shop/pet_shop_sheet.dart';
import 'package:my_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:my_app/ui/dialogs/pet_evolution/pet_evolution_dialog.dart';
import 'package:my_app/ui/dialogs/pet_death/pet_death_dialog.dart';
import 'package:my_app/services/pet_service.dart';
import 'package:my_app/services/game_service.dart';
import 'package:my_app/services/time_service.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: PetCreationView),
    MaterialRoute(page: PetHomeView),
    MaterialRoute(page: PetStatsView),
    MaterialRoute(page: FeedingGameView),
    MaterialRoute(page: CleaningGameView),
    MaterialRoute(page: ExerciseGameView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: PetService),
    LazySingleton(classType: GameService),
    LazySingleton(classType: TimeService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: PetShopSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: PetEvolutionDialog),
    StackedDialog(classType: PetDeathDialog),
  ],
)
class App {}

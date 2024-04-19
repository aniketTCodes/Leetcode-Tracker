import 'package:bloc/bloc.dart';
import 'package:leetcode_tracker/di/di.dart';
import 'package:leetcode_tracker/features/revist_solutions/data/repository/revisit_solution_repository.dart';
import 'package:leetcode_tracker/features/solutions/data/models/solution_model.dart';
import 'package:meta/meta.dart';

part 'revisit_solution_event.dart';
part 'revisit_solution_state.dart';

class RevisitSolutionBloc
    extends Bloc<RevisitSolutionEvent, RevisitSolutionState> {
  final RevisitSolutionRepository repository =
      getIt<RevisitSolutionRepository>();
  RevisitSolutionBloc() : super(RevisitLoadingState()) {
    on<GetUserSolutionEvent>((event, emit) async {
      final solutionResult = await repository.getAllSolutions();
      solutionResult.fold(
          (l) => emit(RevisitSolutionErrorState(errorMessage: l.message)),
          (r) => emit(RevisitSolutionsLoadedState(solutions: r)));
    });
  }
}

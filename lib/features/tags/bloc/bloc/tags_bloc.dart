import 'package:bloc/bloc.dart';
import 'package:leetcode_tracker/features/tags/data/model/tag_model.dart';
import 'package:leetcode_tracker/features/tags/data/repository/tag_repository.dart';
import 'package:meta/meta.dart';

part 'tags_event.dart';
part 'tags_state.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  final TagRepository repository;
  TagsBloc({required this.repository}) : super(TagLoadingState()) {
    on<LoadUserTagEvent>((event, emit) => _loadUserTagEvent(event, emit));
  }

  _loadUserTagEvent(LoadUserTagEvent event, Emitter<TagsState> emit) async {
    final userTagResult = await repository.getUserTags();
    userTagResult.fold(
        (l) => emit(
              TagErrorState(errorMessage: l.message),
            ),
        (r) => emit(
              TagDoneState(tags: r),
            ));
  }
}

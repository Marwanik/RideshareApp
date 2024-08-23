import 'package:bloc/bloc.dart';
import 'package:rideshare/repos/categoryRepo.dart';
import 'category_event.dart';
import 'category_state.dart';


class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc(this.categoryRepository) : super(CategoryInitial()) {
    on<FetchCategories>((event, emit) async {
      emit(CategoryLoading());
      try {
        final categories = await categoryRepository.getCategories(event.token);
        emit(CategoryLoaded(categories: categories));
      } catch (e) {
        emit(CategoryError(message: 'Failed to fetch categories: $e'));
      }
    });
  }
}

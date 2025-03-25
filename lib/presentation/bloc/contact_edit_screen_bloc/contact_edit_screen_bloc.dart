import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'contact_edit_screen_event.dart';
part 'contact_edit_screen_state.dart';

class ContactEditScreenBloc
    extends Bloc<ContactEditScreenEvent, ContactEditScreenState> {
  ContactEditScreenBloc() : super(ContactEditScreenInitial()) {
    on<ImagePickEvent>((event, emit) async {
      final ImagePicker imagePicker = ImagePicker();
      final XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      emit(ImagePickLoadedState(image: image));
    });
    on<ResetImageEvent>((event, emit) {
      emit(ImageInitialState());
    });
  }
}

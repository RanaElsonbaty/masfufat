
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/domain/models/support_reply_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/domain/models/support_ticket_body.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/domain/models/support_ticket_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/domain/services/support_ticket_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_document/my_files/init.dart';
import 'package:path_provider/path_provider.dart';

class SupportTicketController extends ChangeNotifier {
  final SupportTicketServiceInterface supportTicketServiceInterface;
  SupportTicketController({required this.supportTicketServiceInterface});

  List<SupportTicketModel>? _supportTicketList;
  List<SupportReplyModel>? _supportReplyList;
  bool _isLoading = false;

  List<SupportTicketModel>? get supportTicketList => _supportTicketList;
  List<SupportReplyModel>? get supportReplyList => _supportReplyList != null ? _supportReplyList!.reversed.toList() : _supportReplyList;
  bool get isLoading => _isLoading;



  Future<ApiResponse> createSupportTicket(SupportTicketBody supportTicketBody) async {
    _isLoading = true;
    notifyListeners();
  ApiResponse response = await supportTicketServiceInterface.createNewSupportTicket(supportTicketBody ,);
    if (response.response!=null&&response.response!.statusCode == 200) {
      showCustomSnackBar('${getTranslated('support_ticket_created_successfully', Get.context!)}', Get.context!, isError: false);
      Navigator.pop(Get.context!);
      getSupportTicketList();
      _pickedImageFiles = [];
      pickedImageFileStored = [];
      _isLoading = false;
    } else {
      _isLoading = false;

    }
    _pickedImageFiles = [];
    pickedImageFileStored = [];
    _isLoading = false;
    notifyListeners();
    return response;
  }

  Future<void> getSupportTicketList() async {
    ApiResponse apiResponse = await supportTicketServiceInterface.getList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _supportTicketList = [];
      apiResponse.response!.data.forEach((supportTicket) => _supportTicketList!.add(SupportTicketModel.fromJson(supportTicket)));
      getSearch('',isFilter,filterType);
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }

  Future<void> getSupportTicketReplyList(BuildContext context, int? ticketID) async {
    _supportReplyList = null;
    ApiResponse apiResponse = await supportTicketServiceInterface.getSupportReplyList(ticketID.toString());
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _supportReplyList = [];
      apiResponse.response!.data.forEach((supportReply) => _supportReplyList!.add(SupportReplyModel.fromJson(supportReply)));
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }



  Future<ApiResponse> sendReply(int? ticketID, String message) async {
    _isLoading = true;
    notifyListeners();
    print('object');
    ApiResponse response = await supportTicketServiceInterface.sendReply(ticketID.toString(), message, pickedImageFileStored);
    print('object');

    if (response.response!=null&&response.response!.statusCode == 200) {
      getSupportTicketReplyList(Get.context!, ticketID);
      _pickedImageFiles = [];
      pickedImageFileStored = [];
      _isLoading = false;
    } else {
      _isLoading = false;
    }
    _pickedImageFiles = [];
    pickedImageFileStored = [];
    _isLoading = false;
    notifyListeners();
    return response;
  }


  Future<void> closeSupportTicket(int? ticketID) async {
    ApiResponse apiResponse = await supportTicketServiceInterface.closeSupportTicket(ticketID.toString());
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      getSupportTicketList();
      showCustomSnackBar('${getTranslated('ticket_closed_successfully', Get.context!)}', Get.context!, isError: false);
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }



  List<String> type = ['website_problem', 'partner_request', 'complaint', 'info_inquiry'];
  int selectedTypeIndex = -1;
  String selectedType = getTranslated('website_problem', Get.context!)??'';
  void setSelectedType(int index, {bool reload = true}){
    selectedTypeIndex = index;
    selectedType = getTranslated(type[selectedPriorityIndex], Get.context!)??'High';
    notifyListeners();
  }
  List<String> priority = ['urgent', 'high', 'medium', 'low'];
  int selectedPriorityIndex = -1;
  String selectedPriority = getTranslated('select_priority', Get.context!)??'';
  void setSelectedPriority(int index, {bool reload = true}){
    selectedPriorityIndex = index;
    selectedPriority = getTranslated(priority[selectedPriorityIndex], Get.context!)??'High';
    notifyListeners();
  }

  List <XFile> _pickedImageFiles =[];
  List <XFile>? get pickedImageFile => _pickedImageFiles;
  List <XFile>  pickedImageFileStored = [];
  void pickMultipleImage(bool isRemove,{int? index}) async {
    if(isRemove) {
      if(index != null){
        pickedImageFileStored.removeAt(index);
      }
    }else {
      _pickedImageFiles = await ImagePicker().pickMultiImage(imageQuality: 40);
      pickedImageFileStored.addAll(_pickedImageFiles);
    }
    notifyListeners();
  }
  Future pickImageCamera()async{
    print('object');
     try{
       XFile? file = await ImagePicker().pickVideo( source:ImageSource.gallery  );
       _pickedImageFiles.add(file!);
       pickedImageFileStored.addAll(_pickedImageFiles);
     }catch(e){
       print('object$e');
     }
    notifyListeners();
  }
  Future pickMultipleMedia(bool isRemove,{int? index}) async {
    // final pickedFile =
    if(isRemove) {
      if(index != null){
        pickedImageFileStored.removeAt(index);
      }
    }else {
      // _pickedImageFiles = await ImagePicker().pickMultipleMedia(
      //   requestFullMetadata: false,
      //   imageQuality: 50,
      //   maxHeight: 500,
      //   maxWidth: 500,
      // );
      FilePickerResult? result =
      await FilePicker.platform
          .pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf','docx'],
      );

      if (result != null) {
        List<File> file = [];
        file.add(File(
            result.files.single.path!));
        // support.addPhoto(
        //     file, false, false);
        for (var element in file) {
          pickedImageFileStored.add(XFile(element.path));

        }

        // print(
        //     "No file file ${support.file}");
        // print(
        //     "No file attachmentFile ${support.attachmentFile}");
      } else {
        print("No file selected");
      }
    }
    notifyListeners();

  }
  List<XFile> _pickImageOrVideoCam=[];
  List<XFile> get pickImageOrVideoCam=>_pickImageOrVideoCam;
  void pickImageOrVideoCamera(XFile file){
    _pickImageOrVideoCam.add(file);
    notifyListeners();
  }
  void removePickImageOrVideoCamera(int index){
    _pickImageOrVideoCam.removeAt(index);
    notifyListeners();
  }
void addPickCameraToList(){
   for (var element in _pickImageOrVideoCam) {
     pickedImageFileStored.add(element);
   }
   Timer(const Duration(seconds: 1), () {

   _pickImageOrVideoCam=[];
 });
  notifyListeners();
}
  RecorderController _recorderController = RecorderController();
  RecorderController get recorderController => _recorderController;
  String? _path = '';
  String? get path => _path;
  String? _musicFile = '';
  String? get musicFile => _musicFile;
  bool _isRecording = false;
  bool get isRecording => _isRecording;
  bool _isRecordingCompleted = false;
  bool get isRecordingCompleted => _isRecordingCompleted;
  // bool isLoading = true;
  late Directory _appDirectory;
  Directory get appDirectory => _appDirectory;
  void getDir() async {
    print('getDir');


    _isRecordingCompleted = false;
    _musicFile = '';
    _appDirectory = await getApplicationDocumentsDirectory();
    if(Platform.isIOS){
      _path = "${_appDirectory.path}/${DateTime.now()}.m4a";}else{
      _path = "${_appDirectory.path}/${DateTime.now()}.mp3";

    }
    // notifyListeners();

  }

  void initialiseControllers() async{
    print('initialiseControllers');
    _recorderController = RecorderController()

      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
    // final hasPermission = await controller.c();  // Check mic permission (also called during record)

    // notifyListeners();
  }

  Future startOrStopRecording() async {

    try {
      if (isRecording) {
        _recorderController.reset();
        final path = await _recorderController.stop(true);
        if (path != null) {
          _isRecordingCompleted = true;
          debugPrint(path);
          debugPrint("Recorded file size: ${File(path).lengthSync()}");
          pickedImageFileStored.add(XFile(path));
          notifyListeners();
        }
      //   2024-09-11 08:10:19.022797.m4a
      //   2024-09-11-66e1280a0552d
      //   2024-09-02-66d56710d74f9

      } else {
        await _recorderController.record(path: path!);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isRecording = !isRecording;
    }
    notifyListeners();
  }

  void refreshWave() {
    if (isRecording) {
      _recorderController.refresh();
      _path = '';
      _isRecordingCompleted = false;
      _musicFile = '';
      print('refresh wave and record done ');

    }
    getDir();
    initialiseControllers();
    notifyListeners();
  }

  void recorderControllerDispose() {
    _recorderController.dispose();
  }
bool _noTextEnter=false;
bool get noTextEnter=>_noTextEnter;
void textEmptyOrNot(String val){
  if(val.isNotEmpty&&val!=''){
    _noTextEnter=true;
  }else{
    _noTextEnter=false;
  }
  notifyListeners();
}
bool _micOn=false;
bool get micOn=>_micOn;
void getMicOn(bool val){
  _micOn=val;
  notifyListeners();

}
  int _seconds = 0;
  int get seconds =>_seconds;
  bool get isRunning =>_isRecording;
  Timer? _timer;
  String _formattedDuration='';
  String get formattedDuration=>_formattedDuration;
  void startTimer() {
    _seconds=0;
    _formattedDuration='';
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _seconds++;
        Duration duration = Duration(seconds: _seconds);
        _formattedDuration = duration.toString().substring(2, 7);
  notifyListeners();
    });
    // int milliseconds = 20000; // Example: 20 seconds

  }

  void stopTimer() {
    _timer?.cancel();
  }
  List<SupportTicketModel>?  _searchSupportTicket;

  List<SupportTicketModel> ?get searchSupportTicket => _searchSupportTicket;
  bool _isFilter=false;
  bool get isFilter=>_isFilter;
  String _filterType='';
  String get filterType=>_filterType;
  void getFilter(String filter){

    if(filter=='PENDING'){
    _filterType='pending';
    _isFilter=true;
    notifyListeners();

    }
  else  if(filter=='open'){
      _filterType='open';
      _isFilter=true;
      notifyListeners();

    }
    else if(filter=='closed'){
      _isFilter=true;
      _filterType='close';
      notifyListeners();

    }
    else if(filter=='all'){
      _isFilter=false;
      _filterType='';
      notifyListeners();

    }
    getSearch('',_isFilter,_filterType);
  }

void getSearch(String val,bool filter,String filterType){
    if(_supportTicketList!=null){
  _searchSupportTicket=[];
  if(val.isNotEmpty){
  for (var element in _supportTicketList!) {
    if(element.id.toString().contains(val)||element.type!.contains(val)||element.subject!.contains(val)){
      if(filter&&filterType==element.status!){
        _searchSupportTicket!.add(element);

      }
      notifyListeners();
    }
  }
  }else{
    if(filter) {
      for (var element in _supportTicketList!) {
        if(filterType==element.status!){
          if(filter&&filterType==element.status!){
            _searchSupportTicket!.add(element);

          }
          notifyListeners();
        }
      }

    }else{
      _searchSupportTicket!.addAll(_supportTicketList!);

    }
    notifyListeners();
  }
}
  }


}


import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dio/dio.dart';
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

  List<MultipartFile> _attachmentFile = [];
  List<MultipartFile> get attachmentFile =>_attachmentFile;


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
      _supportReplyList = null;
      _supportReplyList = [];
      apiResponse.response!.data.forEach((supportReply) => _supportReplyList!.add(SupportReplyModel.fromJson(supportReply)));
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }



  Future<ApiResponse> sendReply(int? ticketID, String message) async {
    _isLoading = true;
  try{
    List<Attachment> fileList=[];
    notifyListeners();
    if(pickedImageFileStored.isNotEmpty){
    for (var element in pickedImageFileStored) {
      fileList.add(Attachment(id: 0, ticketId: ticketID!, fileName: element.name, filePath: element.path, fileType: element.name, createdAt: DateTime.now(), updatedAt: DateTime.now(), ticketConvId: ticketID, fileUrl: element.path));
    }
    }

    SupportReplyModel sendModel=SupportReplyModel(
        id: 0, supportTicketId: ticketID!
        ,adminId: 0,
        customerMessage: message,
        attachment: null,
        adminMessage: message,
        position: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        ticketAttachments: [],
        attachments: fileList, ofline: true);
    if(_supportReplyList!=null){
      _supportReplyList!.add(sendModel);

    }else{
      _supportReplyList=[sendModel];

    }
  }catch(e){

  }

    notifyListeners();
    ApiResponse response = await supportTicketServiceInterface.sendReply(ticketID.toString(), message, attachmentFile);


    pickedImageFileStored.clear();
    _pickedImageFiles.clear();
notifyListeners();
    if (response.response!=null&&response.response!.statusCode == 200) {

      _attachmentFile=[];

      notifyListeners();
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






  List<String> type = ['website_problem', 'partner_request', 'complaint', 'info_inquiry','problem_with_request'];
  int selectedTypeIndex = -1;
  String selectedType = getTranslated('website_problem', Get.context!)??'';
  void setSelectedType(int index, {bool reload = true}){
    selectedTypeIndex = index;
    selectedType = getTranslated(type[index], Get.context!)??'High';
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
  void pickMultipleImage(bool isRemove,{int? index,}) async {
    if(isRemove) {
      if(index != null){
      try{
        pickedImageFileStored.removeAt(index);
      }catch(e){

      }
       try{
         _attachmentFile.removeAt(index);
       }catch(e){

       }
      }
      notifyListeners();
    }else {

      try{

        _pickedImageFiles = await ImagePicker().pickMultiImage(imageQuality: 40);
        pickedImageFileStored.addAll(_pickedImageFiles);
        for (var element in _pickedImageFiles) {
          _attachmentFile.add(await  MultipartFile.fromFile(element.path, filename: element.name));

        }
      }catch(E){

      }
    }
    notifyListeners();
  }
  Future pickImageCamera()async{
    print('object');
     try{
       XFile? file = await ImagePicker().pickVideo( source:ImageSource.gallery  );
       _pickedImageFiles.add(file!);
       pickedImageFileStored.addAll(_pickedImageFiles);
       // for (var element in _pickedImageFiles) {
         _attachmentFile.add(await  MultipartFile.fromFile(file.path, filename: file.name));
       //
       // }
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
        _attachmentFile.removeAt(index);
      }
    }else {

      FilePickerResult? result =
      await FilePicker.platform
          .pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf','docx','xlsx'],
      );

      if (result != null) {
        List<File> file = [];
        file.add(File(
            result.files.single.path!));
        // support.addPhoto(
        //     file, false, false);
        for (var element in file) {
          pickedImageFileStored.add(XFile(element.path));
try{
  _attachmentFile.add(await  MultipartFile.fromFile(element.path, filename: element.path));

}catch(e){}
        }
        // for (var element in _pickedImageFiles) {
        //
        // }

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
  void pickImageOrVideoCamera(XFile file)async{
    _pickImageOrVideoCam.add(file);
    _attachmentFile.add(await  MultipartFile.fromFile(file.path, filename: file.name));

    notifyListeners();
  }
  void removePickImageOrVideoCamera(int index){
    _pickImageOrVideoCam.removeAt(index);
    _attachmentFile.removeAt(index);
    notifyListeners();
  }
void addPickCameraToList()async{
   for (var element in _pickImageOrVideoCam) {
     pickedImageFileStored.add(element);
     _attachmentFile.add(await  MultipartFile.fromFile(element.path, filename: element.name));

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
      _path = "${_appDirectory.path}/${'recorde'}.m4a";
  }else{
      _path = "${_appDirectory.path}/${'recorde'}.mp3";
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
      // _recorderController.
      if (isRecording) {

        _recorderController.reset();

        final path = await _recorderController.stop(true);
        print('object');
        if (path != null) {
          _isRecordingCompleted = true;
          debugPrint(path);
          debugPrint("Recorded file size: ${File(path).lengthSync()}");
          pickedImageFileStored.add(XFile(path));

          notifyListeners();
        }
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
  Future<void> deleteSupportTicket(int? ticketID) async {
    ApiResponse apiResponse = await supportTicketServiceInterface.deleteSupportTicket(ticketID.toString());
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      getSupportTicketList();
      showCustomSnackBar('${getTranslated('The_ticket_has_been_successfully_deleted', Get.context!)}', Get.context!, isError: false);
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }
}

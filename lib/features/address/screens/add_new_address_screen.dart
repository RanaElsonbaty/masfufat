
import 'package:country_code_picker/country_code_picker.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/domain/models/address_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/checkout/controllers/checkout_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/location/controllers/location_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/country_code_helper.dart';
import 'package:flutter_sixvalley_ecommerce/helper/velidate_check.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/controllers/address_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/success_dialog_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart' as geocoding;


class AddNewAddressScreen extends StatefulWidget {
  final bool isEnableUpdate;
  final bool fromCheckout;
  final AddressModel? address;
  final  List<geocoding.Placemark> placemarks;
  final bool? isBilling;
  final bool? editLocation;

  const AddNewAddressScreen({super.key, this.isEnableUpdate = false, this.address, this.fromCheckout = false, this.isBilling, required this.placemarks, this.editLocation=false});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  String countryId='';
  String cityId='';
  final TextEditingController _contactPersonNameController = TextEditingController();
  final TextEditingController _contactPersonEmailController = TextEditingController();
  final TextEditingController _contactPersonNumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  final FocusNode _addressNode = FocusNode();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _numberNode = FocusNode();
  final FocusNode _cityNode = FocusNode();
  final FocusNode _zipNode = FocusNode();
  Address? _address;
  String zip = '',  country = 'IN';

  final GlobalKey<FormState> _addressFormKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    initData();

  }
void initData()async{
  if(widget.isBilling!){
    _address = Address.billing;
  }else{
    _address = Address.shipping;
  }

  Provider.of<AuthController>(context, listen: false).setCountryCode(CountryCode.fromCountryCode(Provider.of<SplashController>(context, listen: false).configModel!.countryCode).dialCode!, notify: false);
  _countryCodeController.text = CountryCode.fromCountryCode(Provider.of<SplashController>(context, listen: false).configModel!.countryCode).name??'Bangladesh';
  Provider.of<AddressController>(context, listen: false).getAddressType();
    await  Provider.of<AddressController>(context, listen: false).getCountyList();
  if (widget.isEnableUpdate && widget.address != null) {
    if(widget.editLocation!){

    try{
      _contactPersonNameController.text = '${widget.address?.contactPersonName}';
      String countryCode = CountryCodeHelper.getCountryCode(Provider.of<ProfileController>(Get.context!, listen: false).userInfoModel!.phone)!;
      Provider.of<AuthController>(Get.context!, listen: false).setCountryCode(countryCode);
      String phoneNumberOnly = CountryCodeHelper.extractPhoneNumber(countryCode, Provider.of<ProfileController>(Get.context!, listen: false).userInfoModel!.phone);
      _contactPersonNumberController.text = phoneNumberOnly;
      _zipCodeController.text=widget.placemarks.first.postalCode!;
    }catch(e){}

    Provider.of<LocationController>(Get.context!, listen: false).locationController.text=widget.placemarks.first.street!=null?widget.placemarks.first.street!:'';
    Provider.of<AddressController>(Get.context!, listen: false).countyList.forEach((element) async{

      if(widget.placemarks.first.isoCountryCode==element.code){
        await  Provider.of<AddressController>(context, listen: false).getCityList(element.id.toString()).then((value) {
          Provider.of<AddressController>(context, listen: false).cityList.forEach((element) {
            if(widget.placemarks.first.locality==element.name){
            setState(() {
              _cityController.text=element.name;
              cityId=element.id.toString();
            });
              }else{
              showCustomSnackBar(getTranslated('selected_city_is_found', context), context);
              _cityController.text='not found';
            }
          });
        });

        _countryCodeController.text=element.name;
        countryId=element.id.toString();


      }
    });
    setState(() {

    });
}else {
  _contactPersonNameController.text = '${widget.address?.contactPersonName}';
  Provider
      .of<AddressController>(Get.context!, listen: false)
      .countyList
      .forEach((element) {
    if (widget.address?.country != null &&
        element.name == widget.address?.country ||
        element.code == widget.address?.country ||
        element.id.toString() == widget.address?.country) {
      _countryCodeController.text = element.name;
      countryId = element.id.toString();
      Provider
          .of<LocationController>(context, listen: false)
          .locationController
          .text = widget.address!.address!;
      Provider.of<AddressController>(context, listen: false).getCityList(
          element.id.toString()).then((value) {
        if (widget.address?.city != null &&
            element.id.toString() == widget.address?.city ||
            element.name == widget.address?.city) {
          _cityController.text = element.name;
          cityId = element.id.toString();
        } else {
          _cityController.text = '';
        }
      });
    }
  });


  _zipCodeController.text = '${widget.address?.zip}';
  if (widget.address!.addressType == 'Home') {
    Provider.of<AddressController>(Get.context!, listen: false).updateAddressIndex(
        0, false);
  } else if (widget.address!.addressType == 'Workplace') {
    Provider.of<AddressController>(Get.context!, listen: false).updateAddressIndex(
        1, false);
  } else {
    Provider.of<AddressController>(Get.context!, listen: false).updateAddressIndex(
        2, false);
  }
  String countryCode = CountryCodeHelper.getCountryCode(
      widget.address?.phone ?? '')!;
  Provider.of<AuthController>(Get.context!, listen: false).setCountryCode(
      countryCode, notify: false);
  String phoneNumberOnly = CountryCodeHelper.extractPhoneNumber(
      countryCode, widget.address?.phone ?? '');
  _contactPersonNumberController.text = phoneNumberOnly;
}
  } else {

    if(Provider.of<ProfileController>(Get.context!, listen: false).userInfoModel!=null){
      _contactPersonNameController.text =
      ' ${Provider.of<ProfileController>(Get.context!, listen: false).userInfoModel!.name}';

   try{
     String countryCode = CountryCodeHelper.getCountryCode(Provider.of<ProfileController>(Get.context!, listen: false).userInfoModel!.phone)!;
     Provider.of<AuthController>(Get.context!, listen: false).setCountryCode(countryCode);
     String phoneNumberOnly = CountryCodeHelper.extractPhoneNumber(countryCode, Provider.of<ProfileController>(Get.context!, listen: false).userInfoModel!.phone);
     _contactPersonNumberController.text = phoneNumberOnly;
   }catch(e){}
    try{
      _zipCodeController.text=widget.placemarks.first.postalCode!;
    }catch(e){}
      Provider.of<LocationController>(Get.context!, listen: false).locationController.text=widget.placemarks.first.street!;
      Provider.of<AddressController>(Get.context!, listen: false).countyList.forEach((element) async{

          if(widget.placemarks.first.isoCountryCode==element.code){
        await  Provider.of<AddressController>(context, listen: false).getCityList(element.id.toString()).then((value) {
            Provider.of<AddressController>(context, listen: false).cityList.forEach((element) {
              if(widget.placemarks.first.locality==element.name){
                _cityController.text=element.name;
                cityId=element.id.toString();
              }
            });
          });

          _countryCodeController.text=element.name;
          countryId=element.id.toString();


        }
      });
      setState(() {

      });
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.isEnableUpdate ? getTranslated('update_address', context) : getTranslated('add_new_address', context)),
      body: SingleChildScrollView(
        child: Column(children: [
            Consumer<AddressController>(
              builder: (context, addressController, child) {
                return Consumer<LocationController>(
                  builder: (context, locationController, _) {
                    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      child: Form(
                        key: _addressFormKey,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [


                          Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
                            child: CustomTextFieldWidget(
                              required: true,
                              prefixIcon: Images.user,
                              labelText: getTranslated('enter_contact_person_name', context),
                              hintText: getTranslated('enter_contact_person_name', context),
                              showLabelText: false,
                              titleText: getTranslated('enter_contact_person_name', context) ,
                              inputType: TextInputType.name,
                              controller: _contactPersonNameController,
                              focusNode: _nameNode,
                              nextFocus: _numberNode,
                              inputAction: TextInputAction.next,
                              capitalization: TextCapitalization.words,
                              validator: (value)=> ValidateCheck.validateEmptyText(value, 'contact_person_name_is_required'),
                            )),

                          const SizedBox(height: Dimensions.paddingSizeDefaultAddress),
                          Consumer<AuthController>(
                              builder: (context, authProvider,_) {
                                return CustomTextFieldWidget(
                                  required: true,
                                  labelText: getTranslated('phone', context),
                                  hintText: getTranslated('enter_mobile_number', context),
                                  showLabelText: false,
                                  titleText: getTranslated('enter_mobile_number', context),
                                  controller: _contactPersonNumberController,
                                  focusNode: _numberNode,
                                  nextFocus: _emailNode,
                                  showCodePicker: true,
                                  countryDialCode: authProvider.countryDialCode,
                                  onCountryChanged: (CountryCode countryCode) {
                                    authProvider.countryDialCode = countryCode.dialCode!;
                                    authProvider.setCountryCode(countryCode.dialCode!);
                                  },
                                  isAmount: true,
                                  validator: (value)=> ValidateCheck.validatePhoneNumber(value, "phone_must_be_required"),
                                  inputAction: TextInputAction.next,
                                  inputType: TextInputType.phone,
                                );
                              }
                          ),
                          const SizedBox(height: Dimensions.paddingSizeDefaultAddress),

                          if(!Provider.of<AuthController>(context, listen: false).isLoggedIn())
                          CustomTextFieldWidget(
                            required: true,
                            prefixIcon: Images.email,
                            labelText: getTranslated('email', context),
                            hintText: getTranslated('enter_contact_person_email', context),
                            titleText: getTranslated('enter_contact_person_email', context),
                            showLabelText: false,

                            inputType: TextInputType.name,
                            controller: _contactPersonEmailController,
                            focusNode: _emailNode,
                            nextFocus: _addressNode,
                            inputAction: TextInputAction.next,
                            capitalization: TextCapitalization.words,
                            validator: (value)=> ValidateCheck.validateEmail(value),

                          ),


                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                              child: Text(getTranslated('label_us', context)!, style: textRegular.copyWith(
                                color: ColorResources.getHint(context),
                                fontSize: Dimensions.fontSizeLarge,
                              )),
                            ),

                            SizedBox(height: 50,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: addressController.addressTypeList.length,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () => addressController.updateAddressIndex(index, true),
                                  child: Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeLarge),
                                    margin: const EdgeInsets.only(right: 17),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                        border: Border.all(color: addressController.selectAddressIndex == index ?
                                        Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(.125))),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      SizedBox(width: 20, child: Image.asset(addressController.addressTypeList[index].icon,
                                          color: addressController.selectAddressIndex == index ?
                                      Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(.35))),
                                      const SizedBox(width: Dimensions.paddingSizeSmall,),
                                      Text(getTranslated(addressController.addressTypeList[index].title, context)!,
                                          style: textRegular.copyWith())]))))),


                            // Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                            //   child: SizedBox(height: 50,
                            //     child: Row(children: <Widget>[
                            //       Row(children: [
                            //           Radio<Address>(
                            //             value: Address.shipping,
                            //             groupValue: _address,
                            //             onChanged: (Address? value) {
                            //               setState(() {_address = value;});}),
                            //           Text(getTranslated('shipping_address', context)??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge),),]),
                            //
                            //
                            //       Row(children: [
                            //         Radio<Address>(
                            //           value: Address.billing,
                            //           groupValue: _address,
                            //           onChanged: (Address? value) {
                            //             setState(() {
                            //               _address = value;});}),
                            //           Text(getTranslated('billing_address', context)??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge))])]))),
                            const SizedBox(height: Dimensions.paddingSizeDefaultAddress,),

                            CustomTextFieldWidget(
                              labelText: getTranslated('delivery_address', context),
                              titleText: getTranslated('delivery_address', context),
                              showLabelText: false,

                              hintText: getTranslated('usa', context),
                              inputType: TextInputType.streetAddress,
                              inputAction: TextInputAction.next,
                              focusNode: _addressNode,
                              prefixIcon: Images.address,
                              required: true,
                              nextFocus: _cityNode,
                              controller: locationController.locationController,
                              validator: (value)=> ValidateCheck.validateEmptyText(value, "address_is_required"),


                            ),
                            const SizedBox(height: Dimensions.paddingSizeDefaultAddress),

                          ...[
                            // Text(getTranslated('country', context)!, style: textRegular.copyWith(
                            //   color: Theme.of(context).hintColor,
                            //   fontSize: Dimensions.fontSizeSmall,
                            // )),
                            const SizedBox(height: Dimensions.paddingSizeExtraSmall),


                            Consumer<AddressController>(
                                builder: (context, addressController, _) {
                                  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    InkWell(
                                      onTap: () {
                                        DropDownState(
                                          DropDown(
                                            bottomSheetTitle: Text(
                                              getTranslated('country', context)!,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                            data: addressController.countyList
                                                .map((e) => SelectedListItem(
                                              value: e.id.toString(),
                                              name: e.name,
                                            ))
                                                .toList(),
                                            isSearchVisible: true,

                                            selectedItems:
                                                (selectedList) async {

                                              if (selectedList.isNotEmpty) {
                                                _countryCodeController.text=selectedList.first.name;
                                                countryId=selectedList.first.value!;

                                                }



                                            },
                                            enableMultipleSelection: false,
                                          ),
                                        ).showModal(context);
                                      },
                                      child: CustomTextFieldWidget(
                                        labelText: getTranslated('country', context),
                                        hintText: getTranslated('country', context),
                                        titleText: getTranslated('country', context),
                                        showLabelText: false,

                                        inputType: TextInputType.streetAddress,
                                        inputAction: TextInputAction.next,
                                        focusNode: _cityNode,
                                        required: true,
                                        isEnabled: false,
                                        nextFocus: _zipNode,
                                        prefixIcon: Images.city,
                                        controller: _countryCodeController,
                                        validator: (value)=> ValidateCheck.validateEmptyText(value, 'country_is_required'),
                                      ),
                                    ),

                                  ]);}),
                          ],




                          const SizedBox(height: Dimensions.paddingSizeDefaultAddress),
                            InkWell(
                              onTap: () {
                                DropDownState(
                                  DropDown(
                                    bottomSheetTitle: Text(
                                      getTranslated('city', context)!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    data: addressController.cityList
                                        .map((e) => SelectedListItem(
                                      value: e.id.toString(),
                                      name: e.name,
                                    ))
                                        .toList(),
                                    isSearchVisible: true,

                                    selectedItems:
                                        (selectedList) async {

                                      if (selectedList.isNotEmpty) {
                                        _cityController.text=selectedList.first.name;
                                        cityId=selectedList.first.value!;

                                      }



                                    },
                                    enableMultipleSelection: false,
                                  ),
                                ).showModal(context);
                              },

                              child: CustomTextFieldWidget(
                                labelText: getTranslated('city', context),
                                hintText: getTranslated('city', context),
                                titleText: getTranslated('city', context),
                                showLabelText: false,
                                inputType: TextInputType.streetAddress,
                                inputAction: TextInputAction.next,
                                focusNode: _cityNode,
                                  required: true,
                                isEnabled: false,
                                nextFocus: _zipNode,
                                prefixIcon: Images.city,
                                controller: _cityController,
                                validator: (value)=> ValidateCheck.validateEmptyText(value, 'city_is_required'),
                              ),
                            ),
                          const SizedBox(height: Dimensions.paddingSizeDefaultAddress),


                          Provider.of<SplashController>(context, listen: false).configModel!.deliveryZipCodeAreaRestriction == 0?
                          CustomTextFieldWidget(
                            labelText: getTranslated('zip', context),
                            hintText: getTranslated('zip', context),
                            titleText: getTranslated('zip', context),
                            showLabelText: false,

                            inputAction: TextInputAction.done,
                            focusNode: _zipNode,
                            required: true,
                            prefixIcon: Images.city,
                            controller: _zipCodeController,
                            validator: (value)=> ValidateCheck.validateEmptyText(value, 'zip_code_is_required'),

                          ):

                          Container(width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: .1, color: Theme.of(context).hintColor.withOpacity(0.1))),
                            child: DropdownButtonFormField2<String>(
                              isExpanded: true,
                              isDense: true,
                              decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                              hint:  Row(children: [
                                Image.asset(Images.city),
                                const SizedBox(width: Dimensions.paddingSizeSmall,),
                                  Text(_zipCodeController.text, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color)),
                                ],
                              ),
                              items: addressController.restrictedZipList.map((item) => DropdownMenuItem<String>(
                                  value: item.zipcode, child: Text(item.zipcode!, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)))).toList(),
                              onChanged: (value) {
                                _zipCodeController.text = value!;

                              },
                              buttonStyleData: const ButtonStyleData(padding: EdgeInsets.only(right: 8),),
                              iconStyleData: IconStyleData(
                                  icon: Icon(Icons.arrow_drop_down, color: Theme.of(context).hintColor), iconSize: 24),
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5))),
                              menuItemStyleData: const MenuItemStyleData(padding: EdgeInsets.symmetric(horizontal: 16)),
                            ),
                          ),
                          const SizedBox(height: Dimensions.paddingSizeDefaultAddress),

                          Container(height: 50.0,
                            margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                            child: CustomButton(
                              isLoading: addressController.isLoading,
                              buttonText: widget.isEnableUpdate ? getTranslated('update_address', context) : getTranslated('save_location', context),
                              onTap: locationController.loading ? null : () {

                                if(_addressFormKey.currentState?.validate() ?? false) {
                                  AddressModel addressModel = AddressModel(
                                      addressType: getTranslated(addressController.addressTypeList[addressController.selectAddressIndex].title, context),
                                      contactPersonName: _contactPersonNameController.text,
                                      phone: '${Provider.of<AuthController>(context, listen: false).countryDialCode}${_contactPersonNumberController.text.trim()}',
                                      email: _contactPersonEmailController.text.trim(),
                                      city: _cityController.text.toString(),
                                      zip: _zipCodeController.text,
                                      title: '',
                                      customerId: 0,
                                      areaId: '',
                                      createdAt: '',
                                      state: true,
                                      updatedAt: '',
                                      country:  countryId.toString(),
                                      // guestId: Provider.of<AuthController>(context, listen: false).getGuestToken(),
                                      isBilling: _address == Address.billing?1:0,
                                      address: locationController.locationController.text,
                                      latitude: widget.isEnableUpdate ? locationController.position.latitude.toString() : locationController.position.latitude.toString(),
                                      longitude: widget.isEnableUpdate ? locationController.position.longitude.toString() : locationController.position.longitude.toString());


                                  if (widget.isEnableUpdate) {
                                    addressModel.id = widget.address!.id;
                                    addressController.updateAddress(context, addressModel: addressModel, addressId: addressModel.id);
                                    Navigator.pop(context);

                                  }else if(_countryCodeController.text.trim().isEmpty){
                                    showCustomSnackBar('${getTranslated('country_is_required', context)}', context);
                                  } else {
                                    addressController.addAddress(addressModel).then((value) {
                                      if (value.response?.statusCode == 200 ) {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        if (widget.fromCheckout) {
                                          Provider.of<CheckoutController>(context, listen: false).setAddressIndex(0);
                                        }
                                      }
                                    });
                                  }

                                }
                              },
                            ),
                          ),


                        ]),
                      ),
                    );
                  }
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  void _checkPermission(Function callback, BuildContext context) async {
    LocationPermission permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.denied || permission == LocationPermission.whileInUse) {
      InkWell(onTap: () async{
        Navigator.pop(context);
        await Geolocator.requestPermission();
        _checkPermission(callback,  Get.context!);
        },
          child: AlertDialog(content: SuccessDialog(icon: Icons.location_on_outlined, title: '',
              description: getTranslated('you_denied', Get.context!))));
    }else if(permission == LocationPermission.deniedForever) {
      InkWell(onTap: () async{
        if(context.mounted){}
        Navigator.pop(context);
        await Geolocator.openAppSettings();
        _checkPermission(callback, Get.context!);
        },
          child: AlertDialog(content: SuccessDialog(icon: Icons.location_on_outlined, title: '',
              description: getTranslated('you_denied', Get.context!))));
    }else {
      callback();
    }
  }
}

enum Address {shipping, billing }


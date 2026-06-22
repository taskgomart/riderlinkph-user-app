import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:ride_sharing_user_app/common_widgets/button_widget.dart';
import 'package:ride_sharing_user_app/common_widgets/expandable_bottom_sheet.dart';
import 'package:ride_sharing_user_app/features/auth/controllers/auth_controller.dart';
import 'package:ride_sharing_user_app/features/location/controllers/location_controller.dart';
import 'package:ride_sharing_user_app/features/map/controllers/map_controller.dart';
import 'package:ride_sharing_user_app/features/parcel/widgets/fare_input_widget.dart';
import 'package:ride_sharing_user_app/features/parcel/widgets/route_widget.dart';
import 'package:ride_sharing_user_app/features/payment/controllers/payment_controller.dart';
import 'package:ride_sharing_user_app/features/profile/controllers/profile_controller.dart';
import 'package:ride_sharing_user_app/features/ride/controllers/ride_controller.dart';
import 'package:ride_sharing_user_app/features/ride/widgets/ride_category.dart';
import 'package:ride_sharing_user_app/features/ride/widgets/trip_fare_summery.dart';
import 'package:ride_sharing_user_app/features/set_destination/widget/schedule_date_time_picker_widget.dart';
import 'package:ride_sharing_user_app/features/splash/controllers/config_controller.dart';
import 'package:ride_sharing_user_app/features/trip/screens/trip_details_screen.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/helper/ride_controller_helper.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';


class InitialWidget extends StatefulWidget {
  final GlobalKey<ExpandableBottomSheetState> expandableKey;
  const InitialWidget({super.key, required this.expandableKey});

  @override
  State<InitialWidget> createState() => _InitialWidgetState();
}

class _InitialWidgetState extends State<InitialWidget> {
  bool _isExpanded = false;
  JustTheController tooltipController = JustTheController();

  @override
  void initState() {
    var rideController = Get.find<RideController>();
    if(Get.find<PaymentController>().paymentType == 'wallet' &&
        (rideController.discountAmount.toDouble() > 0 ? rideController.discountFare : rideController.estimatedFare) >
            Get.find<ProfileController>().profileModel!.data!.wallet!.walletBalance!
    ){
      Get.find<PaymentController>().setPaymentType(0);
    }
  //  zoneExtraFareReason = _getExtraFairReason(Get.find<ConfigController>().config?.zoneExtraFare, Get.find<LocationController>().zoneID);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (rideController){
      return GetBuilder<LocationController>(builder: (locationController){
        return Column(mainAxisSize: MainAxisSize.min, children:  [
          RideCategoryWidget(onTap:(value) async {
            if(rideController.isCouponApplicable){
              await Future.delayed(const Duration(milliseconds: 500));
              widget.expandableKey.currentState?.expand(duration: 1000);
            }else{
              widget.expandableKey.currentState?.contract(duration: 500);
              widget.expandableKey.currentState?.expand(duration: 1000);
            }

          }),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).hintColor.withValues(alpha:0.06),
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            ),
            child: Column(children: [
              InkWell(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('pickup_time_and_note'.tr, style: textBold.copyWith(fontSize: Dimensions.fontSizeDefault)),

                    Icon(_isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 20),
                  ]),
                ),
              ),

              if(_isExpanded) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: Column(children: [
                    rideController.rideType == RideType.scheduleRide ?
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Row(spacing: Dimensions.paddingSizeExtraSmall, children: [
                        Image.asset(
                          Images.scheduleCalenderIcon,
                          height: 14,width: 14,
                        ),
                        Text(
                          DateFormat('E, d MMM').format(RideControllerHelper.dateFormatToShow(rideController.scheduleTripDate)),
                          style: textBold.copyWith(fontSize: Dimensions.fontSizeSmall),
                        ),
                      ]),

                      Row(spacing: Dimensions.paddingSizeExtraSmall, children: [
                        Image.asset(
                          Images.clockIcon,
                          height: 14,width: 14,
                        ),
                        Text(
                          DateFormat('hh:mm a').format(RideControllerHelper.timeFormatToShow(rideController.scheduleTripTime)),
                          style: textBold.copyWith(fontSize: Dimensions.fontSizeSmall),
                        ),
                      ])
                    ]) :
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('pickup_time'.tr, style: textRegular.copyWith(color: Theme.of(context).hintColor)),

                      InkWell(
                        onTap: (){
                          if(Get.find<ConfigController>().config?.scheduleTripStatus ?? false){
                            Get.bottomSheet(const ScheduleDateTimePickerWidget(),enableDrag: false, isScrollControlled: true);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radiusOverLarge),
                            border: Border.all(color: Theme.of(context).primaryColor.withValues(alpha: 0.1)),
                          ),
                          child: Row(spacing: Dimensions.paddingSizeExtraSmall, children: [
                            Image.asset(
                              Images.clockIcon,
                              height: 14,width: 14,
                            ),
                            Text(
                              'pickup_now'.tr,
                              style: textBold.copyWith(fontSize: Dimensions.fontSizeSmall),
                            ),
                            const Icon(Icons.keyboard_arrow_down, size: 18),
                          ]),
                        ),
                      ),
                    ]),

                    if(rideController.pickupNoteText.isNotEmpty)...[
                      Divider(height: Dimensions.paddingSizeLarge, color: Theme.of(context).hintColor.withValues(alpha: 0.3)),

                      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('${'pickup_note'.tr}: ', style: textRegular.copyWith(color: Theme.of(context).colorScheme.inverseSurface)),
                        Flexible(child: Text(
                          rideController.pickupNoteText,
                          style: textRegular,
                        )),
                      ]),
                    ],
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                  ]),
                ),
              ],
            ]),
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).hintColor.withValues(alpha:0.06),
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            ),
            padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Column(children: [
              RouteWidget(
                totalDistance: rideController.fareList.isEmpty ? '0' :
                rideController.fareList[rideController.rideCategoryIndex].estimatedDistance ?? '0',
                fromAddress: locationController.fromAddress?.address??'',
                extraOneAddress: rideController.isInitialWidgetRoutesExpand ? '' : locationController.extraRouteAddress?.address ?? '',
                extraTwoAddress: rideController.isInitialWidgetRoutesExpand ? '' : locationController.extraRouteTwoAddress?.address ?? '',
                toAddress: locationController.toAddress?.address??'',
                entrance: rideController.isInitialWidgetRoutesExpand ? '' : locationController.entranceController.text,
                isShowDistance: rideController.isInitialWidgetRoutesExpand ? false : true,
              ),

              InkWell(
                onTap: (){
                  rideController.toggleInitialWidgetExpansion();
                },
                child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Text('view_details'.tr, style: textRegular.copyWith(color: Theme.of(context).primaryColor)),
                  const SizedBox(width: 1),

                  Icon(rideController.isInitialWidgetRoutesExpand ? Icons.keyboard_arrow_down_outlined : Icons.keyboard_arrow_up_outlined, size: 22, color: Theme.of(context).primaryColor)
                ]),
              )
            ]),
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          if(rideController.fareList[rideController.rideCategoryIndex].extraFareReason != '') ...[
            Text('${'fares_are_a_bit_higher'.tr}${rideController.fareList[rideController.rideCategoryIndex].extraFareReason}', style: textRegular.copyWith(color: Theme.of(context).colorScheme.inverseSurface,fontSize: 11), textAlign: TextAlign.center),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          ],

          const SizedBox(height: Dimensions.paddingSizeSmall),

          TripFareSummery(
            tripFare: rideController.estimatedFare, fromParcel: false,
            discountFare: rideController.discountFare, discountAmount: rideController.discountAmount,
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),

          if(rideController.isCouponApplicable)...[
            Align(alignment: Alignment.centerRight,
              child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeSmall,
                    vertical: Dimensions.paddingSizeExtraSmall,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withValues(alpha:0.15),
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                  ),
                  child: Text('coupon_applied'.tr,style: textBold.copyWith(color: Theme.of(context).primaryColor))
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),
          ],

          if(Get.find<ConfigController>().config?.isFemaleRideServiceActive ?? false)...[
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                Text('female_driver_only_for_this_trip'.tr, style: textMedium),
                const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                JustTheTooltip(
                  backgroundColor:Get.isDarkMode ?
                  Theme.of(context).primaryColor :
                  Theme.of(context).textTheme.bodyMedium!.color,
                  controller: tooltipController,
                  preferredDirection: AxisDirection.up,
                  tailLength: Dimensions.paddingSizeSmall,
                  tailBaseWidth: Dimensions.paddingSizeLarge,
                  content: Container(
                    width: Get.width * 0.8,
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    child: Text(
                      'female_rider_tooltip'.tr,
                      style: textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeDefault),
                    ),
                  ),
                  child: InkWell(
                    onTap: (){
                      tooltipController.showTooltip();
                    },
                    child: Icon(Icons.info, size: 16, color: Theme.of(context).colorScheme.inverseSurface),
                  ),
                )
              ]),

              SizedBox(height: 14,
                child: Checkbox(
                  value: rideController.isFemaleDriverSelected,
                  onChanged: (value)=> rideController.toggleFemaleDriverSelection(value!),
                  activeColor: Theme.of(context).primaryColor,
                  checkColor: Theme.of(context).cardColor,
                  side: BorderSide(color: Theme.of(context).hintColor),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                ),
              )
            ]),
            const SizedBox(height: Dimensions.paddingSizeDefault),
          ],

          rideController.isLoading || rideController.isSubmit ?
          Center(child: SpinKitCircle(color: Theme.of(context).primaryColor, size: 40.0)) :
          (Get.find<ConfigController>().config!.bidOnFare! && rideController.rideType != RideType.scheduleRide) ?
          FareInputWidget(
            expandableKey: widget.expandableKey,
            fromRide: true,
            fare: rideController.discountAmount.toDouble() > 0 ?
            rideController.discountFare.toString() :
            rideController.estimatedFare.toString(),
          ) :
          ButtonWidget(buttonText: "find_rider".tr, onPressed: () {
            if(rideController.rideType == RideType.regularRide) {
              _sendFindRiderRequest(rideController);
            }else{
              rideController.submitRideRequest(rideController.noteController.text, false).then((value){
                if(value.statusCode == 200){
                  Get.find<MapController>().initializeData();
                  showCustomSnackBar(
                      '${'your_trip'.tr} #${rideController.tripDetails?.refId} ${'has_been_successfully_scheduled'.tr}',
                      subMessage: 'you_will_be_notified_when_a_driver_start_for_your'.tr
                  );
                  Get.offAll(() =>  TripDetailsScreen(tripId: rideController.tripDetails?.id ?? ''));
                }
              });
            }
          }),
        ]);
      });
    });
  }

  void _sendFindRiderRequest(RideController rideController){
    rideController.submitRideRequest(rideController.noteController.text, false).then((value) {
      if (value.statusCode == 200) {
        Get.find<AuthController>().saveFindingRideCreatedTime();
        rideController.updateRideCurrentState(RideState.findingRider);
        Get.find<MapController>().initializeData();
        Get.find<MapController>().setOwnCurrentLocation(
            LatLng(
                Get.find<LocationController>().fromAddress?.latitude ?? 0,
                Get.find<LocationController>().fromAddress?.longitude ?? 0
            )
        );
        Get.find<MapController>().notifyMapController();
      }
    });
  }
}

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:the_movie_booking_app/network/responses/checkout_request.dart';
import 'package:the_movie_booking_app/network/responses/get_cinema_day_timeslots_response.dart';
import 'package:the_movie_booking_app/network/responses/get_payment_method_list_response.dart';
import 'package:the_movie_booking_app/network/responses/get_snack_list_response.dart';

import 'api_constants.dart';

part 'the_cinema_api.g.dart';
@RestApi(baseUrl: CINEMA_BASE_URL_DIO)
abstract class TheCinemaApi{
  factory TheCinemaApi(Dio dio)=_TheCinemaApi;

  @GET(ENDPOINT_GET_CINEMA_DAY_TIMEsLOTS)
  Future<GetCinemaDayTimeSlotsResponse> getCinemaDayTimeSlots(
    @Header(PARAM_AUTHORIZATION) String authorization,
      @Query("movie_id") String movieId,
      @Query("date") String date,
      );

  @GET(ENDPOINT_GET_SNACKS)
  Future<GetSnackListResponse> getSnackList(
      @Header(PARAM_AUTHORIZATION) String authorization,
      );

  @GET(ENDPONT_GET_PAYMENT_METHOD)
  Future<GetPaymentMethodListResponse> getPaymentMethodList(
      @Header(PARAM_AUTHORIZATION) String authorization,
      );

  @POST(ENDPOINT_POST_CHECKOUT)
  Future<void> postCheckout(
      @Body() CheckOutRequest checkOutRequest,
      );
}
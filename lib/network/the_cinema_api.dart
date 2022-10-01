import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:the_movie_booking_app/data/vos/check_out_vo.dart';
import 'package:the_movie_booking_app/network/requests/checkout_request.dart';
import 'package:the_movie_booking_app/network/responses/city_response.dart';
import 'package:the_movie_booking_app/network/responses/get_banners_response.dart';
import 'package:the_movie_booking_app/network/responses/get_checkout_response.dart';
import 'package:the_movie_booking_app/network/responses/get_cinema_and_show_time_by_date_response.dart';
import 'package:the_movie_booking_app/network/responses/get_cinema_response.dart';
import 'package:the_movie_booking_app/network/responses/get_city_response.dart';
import 'package:the_movie_booking_app/network/responses/get_config_response.dart';
import 'package:the_movie_booking_app/network/responses/get_otp_response.dart';
import 'package:the_movie_booking_app/network/responses/get_payment_types_response.dart';
import 'package:the_movie_booking_app/network/responses/get_seating_plan_by_show_time_response.dart';
import 'package:the_movie_booking_app/network/responses/get_snack_category_response.dart';
import 'package:the_movie_booking_app/network/responses/get_snacks_response.dart';
import 'package:the_movie_booking_app/network/responses/user_response.dart';
import '../data/vos/user_vo.dart';
import 'api_constants.dart';

part 'the_cinema_api.g.dart';
@RestApi(baseUrl: CINEMA_BASE_URL_DIO)
abstract class TheCinemaApi{
  factory TheCinemaApi(Dio dio)=_TheCinemaApi;

  @POST(ENDPOINT_GET_OTP)
  Future<CityResponse> getOTP(
      @Field(PARAM_POHONE_KEY) String phone,
      );

  @POST(ENDPOINT_SIGN_IN_WITH_PHONE)
  Future<UserResponse> signInWithPhone(
      @Field(PARAM_POHONE_KEY) String phone,
      @Field(PARAM_OTP_KEY) String otp
      );///response

  @POST(ENDPONIT_SIGN_IN_WITH_GOOGLE)
  Future<UserResponse> signInWithGoogle(
      @Field(PARAM_ACCESS_TOKEN) String accessToken,
      @Field(PARAM_NAME) String name,
      );

  @GET(ENDPOINT_GET_CITY)
  Future<GetCityResponse> getCities();

  @POST(ENDPOINT_SET_CITY)
  Future<CityResponse> setCity(
      @Header(PARAM_AUTHORIZATION) String authorization,
      @Field(PARAM_CITY_ID) String cityId,
      );

  @GET(ENDPOINT_GET_BANNERS)
  Future<GetBannersResponse> getBanners();

  @GET(ENDPOINT_GET_CINEMA_DAY_TIMESLOTS)
  Future<GetCinemaAndShowTimeByDateResponse> getCinemaAndShowTimeByDate(
    @Header(PARAM_AUTHORIZATION) String authorization,
      @Query("date") String date,
      );

  @GET(ENDPOINT_GET_SNACK_CATEGORY)
  Future<GetSnackCategoryResponse> getSnackCategory(
      @Header(PARAM_AUTHORIZATION) String authorization,
      );

  @GET(ENDPOINT_GET_SNACKS)
  Future<GetSnacksResponse> getSnacks(
      @Header(PARAM_AUTHORIZATION) String authorization,
      @Query("category_id") String categoryId
      );

  @GET(ENDPONT_GET_PAYMENT_TYPES)
  Future<GetPaymentTypesResponse> getPaymentTypes(
      @Header(PARAM_AUTHORIZATION) String authorization,
      );

  @POST(ENDPOINT_POST_CHECKOUT)
  Future<GetCheckOutResponse> postCheckout(
      @Header(PARAM_AUTHORIZATION) String authorization,
      @Body() CheckOutRequest checkOutRequest,
      );

  @GET(ENDPOINT_GET_CONFIG)
  Future<GetConfigResponse> getConfig();

  @GET(ENDPOINT_GET_CINEMA)
  Future<GetCinemaResponse> getCinemas();

  @GET(ENDPOINT_GET_SEATING_PLAN_BY_SHOW_TIME)
  Future<GetSeatingPlanByShowTimeResponse> getSeatingPlanByShowTime(
      @Header(PARAM_AUTHORIZATION) String authorization,
      @Query("cinema_day_timeslot_id") String cinemaDayTimeslotId,
      @Query("booking_date") String bookingDate
      );
}
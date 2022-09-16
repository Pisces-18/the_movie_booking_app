import 'colors.dart';
//Login Data
final List<String> countryCodeList = ["+95", "+65", "+66", "+81", "+61"];

//Location Page Data
List<String> cityList = [
  "Yangon",
  "Mandalay",
  "Naypyidaw",
  "Bago",
  "Mawlamyine"
];

//Get OTP Page Data
List<int> codeList = [6, 3, 1, 5, 9, 4];

//Home Page Data
final List<Map<String, dynamic>> nowShowingData = [
  {
    "title": "Venom II",
    "rating": "9.0",
    "countryType": "U/A",
    "movieType": "2D, 3D, 3D IMAX",
    "image": "assets/images/venom2.png",
    "videoImage": "assets/images/venom2VideoImage.jpg"
  },
  {
    "title": "Black Widow",
    "rating": "7.1",
    "countryType": "U/A",
    "movieType": "2D, 3D, 3D IMAX, DBOX 3D",
    "image": "assets/images/black_widow.png",
    "videoImage": "assets/images/black_widow_video.jfif"
  },
  {
    "title": "Love",
    "rating": "6.0",
    "countryType": "U/A",
    "movieType": "2D, 3D,",
    "image": "assets/images/love.png",
    "videoImage": "assets/images/venom2VideoImage.jpg"
  },
  {
    "title": "Lonely",
    "rating": "7.0",
    "countryType": "U/A",
    "movieType": "2D, 3D, 3D IMAX",
    "image": "assets/images/lonely.png",
    "videoImage": "assets/images/venom2VideoImage.jpg"
  }
];

final List<Map<String, dynamic>> comingSoonData = [
  {
    "title": "Minions The rise of Gru",
    "rating": "9.8",
    "countryType": "U",
    "movieType": "2D",
    "image": "assets/images/minions.png",
    "videoImage": "assets/images/minionsVideoImage.avif"
  },
  {
    "title": "Forest Gump",
    "rating": "9.0",
    "countryType": "U/A",
    "movieType": "2D",
    "image": "assets/images/forest.png",
    "videoImage": "assets/images/forrestGumpVideoImage.webp"
  },
  {
    "title": "Love",
    "rating": "6.0",
    "countryType": "U/A",
    "movieType": "2D, 3D,",
    "image": "assets/images/world.png",
    "videoImage": "assets/images/minionsVideoImage.avif"
  },
  {
    "title": "Lonely",
    "rating": "7.0",
    "countryType": "U/A",
    "movieType": "2D, 3D, 3D IMAX",
    "image": "assets/images/baby.png",
    "videoImage": "assets/images/minionsVideoImage.avif"
  }
];

//About Movie Page Data
final List<Map<String, dynamic>> castData = [
  {"name": "Katty as Monica", "image": "assets/images/katty.png"},
  {"name": "Devin as Booker", "image": "assets/images/devin.png"},
  {"name": "Jordan as poole", "image": "assets/images/jordan.png"},
  {"name": "Broony as Lebron", "image": "assets/images/broony.png"},
  {"name": "David as Becke", "image": "assets/images/david.png"},
  {"name": "Alex as Caruso", "image": "assets/images/alex.jpg"},
  {"name": "Jayson as Tatun", "image": "assets/images/jayson.jpg"},
];


//Search Movie Page Data

List<String> genresDropDownItem = ['Genres', 'Four', 'Five', 'Six'];

List<String> formatDropDownItem = ['Format', 'Two', 'Three', 'Four'];

List<String> monthDropDownItem = [
  'Month',
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

//Ticket Page Data

final List<Map<String,dynamic>> ticketData = [
  {
    "movieName": "Black Widow (3D) (U/A)",
    "image": "assets/images/black_widow.png",
    "cinemaName": "JCGV : Junction City",
    "screenNumber": "(SCREEN 2)",
    "date": "Sat, 18 Jun, 2022",
    "time": "3:30PM",
    "location": "Q5H3+JPP, Corner of, Bogyoke Lann, Yangon",
    "noOfTicket": "2",
    "ticketNumber": "Gold-G8,G7",
    "ticketPrice": "20000Ks",
    "totalPriceForFood": "2000Ks",
    "foodName": "Potatoe Chips (Qt. 1)",
    "foodPrice": "1000Ks",
    "convenienceFee": "500Ks",
    "total": "22500Ks",
    "refundAmount": "15000KS",
  },
  {
    "movieName": "Edward scissorhands(2D) (U/A)",
    "image": "assets/images/edward.png",
    "cinemaName": "JCGV : Junction City",
    "screenNumber": "(SCREEN 2)",
    "date": "Sat, 20 Jun, 2022",
    "time": "3:30PM",
    "location": "Q5H3+JPP, Corner of, Bogyoke Lann, Yangon",
    "noOfTicket": "2",
    "ticketNumber": "Gold-G8,G7",
    "ticketPrice": "20000Ks",
    "totalPriceForFood": "2000Ks",
    "foodName": "Potatoe Chips (Qt. 1)",
    "foodPrice": "1000Ks",
    "convenienceFee": "500Ks",
    "total": "22500Ks",
    "refundAmount": "15000KS",
  },
  {
    "movieName": "Black Widow (3D) (U/A)",
    "image": "assets/images/black_widow.png",
    "cinemaName": "JCGV : Junction City",
    "screenNumber": "(SCREEN 2)",
    "date": "Sat, 18 Jun, 2022",
    "time": "3:30PM",
    "location": "Q5H3+JPP, Corner of, Bogyoke Lann, Yangon",
    "noOfTicket": "2",
    "ticketNumber": "Gold-G8,G7",
    "ticketPrice": "20000Ks",
    "totalPriceForFood": "2000Ks",
    "foodName": "Potatoe Chips (Qt. 1)",
    "foodPrice": "1000Ks",
    "convenienceFee": "500Ks",
    "total": "22500Ks",
    "refundAmount": "15000KS",
  },
];

//Cancel Booking Page Data

final List<Map<String, dynamic>> foodList = [
  {
    "foodName": "Potatoe Chips ",
    "quantity": 2,
    "price": 1000,
  },
  {
    "foodName": "Cocala Large ",
    "quantity": 2,
    "price": 1000,
  },
];

//Choose Time And Cinema Page Data

final List<Map<String, dynamic>> dateData = [//dart Class
  {
    "dayText": "Today",
    "month": "Sep",
    "dayNumber": "11",
    "year": 2022,
  },
  {
    "dayText": "Tomorrow",
    "month": "Sep",
    "dayNumber": "12",
    "year": 2022,
  },
  {
    "dayText": "Mon",
    "month": "Sep",
    "dayNumber": "13",
    "year": 2022,
  },
  {
    "dayText": "TUE",
    "month": "Sep",
    "dayNumber": "14",
    "year": 2022,
  },
  {
    "dayText": "WED",
    "month": "Sep",
    "dayNumber": "15",
    "year": 2022,
  },
  {
    "dayText": "THU",
    "month": "Sep",
    "dayNumber": "16",
    "year": 2022,
  },
  {
    "dayText": "FRI",
    "month": "Sep",
    "dayNumber": "17",
    "year": 2022,
  },
  {
    "dayText": "SAT",
    "month": "Sep",
    "dayNumber": "18",
    "year": 2022,
  },
  {
    "dayText": "SUN",
    "month": "Sep",
    "dayNumber": "19",
    "year": 2022,
  },
  {
    "dayText": "MON",
    "month": "Sep",
    "dayNumber": "20",
    "year": 2022,
  },
  {
    "dayText": "TUE",
    "month": "Sep",
    "dayNumber": "21",
    "year": 2022,
  },
  {
    "dayText": "WED",
    "month": "Sep",
    "dayNumber": "22",
    "year": 2022,
  },
  {
    "dayText": "THU",
    "month": "Sep",
    "dayNumber": "23",
    "year": 2022,
  },
  {
    "dayText": "FRI",
    "month": "Sep",
    "dayNumber": "24",
    "year": 2022,
  },

];

// final List<String> cinemaList = [
//   "JCGV : Junction City",
//   "JCGV : City Mall",
//   "Mingalar Cinema Gold Class",
//   "JCGV : City Mall",
//   "JCGV : Junction City",
// ];

final List<Map<String,dynamic>> timeAndAvailableSeatData=[
  {
    "time":"9:30 AM",
    "movieType":"3D",
    "screenNo":"Screen 1",
    "availableSeat":21,
    "ticketBookingCondition":"",
  },
  {
    "time":"12:30 PM",
    "movieType":"3D IMAX",
    "screenNo":"Screen 1",
    "availableSeat":null,
    "ticketBookingCondition":"Available",
  },
  {
    "time":"12:30 PM",
    "movieType":"3D",
    "screenNo":"Screen 2",
    "availableSeat":2,
    "ticketBookingCondition":"Almost Full",
  },
  {
    "time":"3:30 PM",
    "movieType":"3D",
    "screenNo":"Screen 2",
    "availableSeat":null,
    "ticketBookingCondition":"Available",
  },
  {
    "time":"6:30 AM",
    "movieType":"3D DBOX",
    "screenNo":"Screen 2",
    "availableSeat":21,
    "ticketBookingCondition":"Filling Fast",
  },
];

//Search Cinema Page Data

List<String> facilityDropDownItem = [
  "Facilities",
  "Parking",
  "Online Food",
  "Wheel Chair",
  "Ticket Cancelation"
];

// Cinema Info Page Data

final List<Map<String,dynamic>> facilityList=[
  {
    "text":"Parking",
    "icon":"assets/images/parking_icon.png",
  },
  {
    "text":"Online Food",
    "icon":"assets/images/foodAndBeverage.png",
  },
  {
    "text":"Wheel Chair",
    "icon":"assets/images/wheel_chair_icon.png",
  },
  {
    "text":"Ticket Cancelation",
    "icon":"assets/images/ticketCancelationIcon.png",
  },
];

final List<String> safetyList = [
  "Thermanal Scannig",
  "Contactless Security Check",
  "Santization Before Every Show",
  "Disposable 3D glass",
  "Contactless Food Service",
  "Package Food ",
  "Deep Cleaning of rest room",
];

//Cinema See Details Dialog Box Data

final List<Map<String, dynamic>> priceList = [
  {"type": "Normal", "price": "4500KS"},
  {"type": "Executive", "price": "6500KS"},
  {"type": "Premium", "price": "8000KS"},
  {"type": "Gold", "price": "10000KS"},
  {"type": "Couple", "price": "20000KS"},
  {"type": "VIP Superior", "price": "25000KS"},
];

//Food And Beverage All Page Data

final List<String> foodTitleList = [
  "All",
  "Combo",
  "Snack",
  "Pop Corn",
  "Beverage"
];

final List<Map<String, dynamic>> foodAllList = [
  {
    "image": "assets/images/potato.png",
    "foodName": "Potato Chips",
    "price": "1000KS",
  },
  {
    "image": "assets/images/cocaCola.png",
    "foodName": "CocaCola Large",
    "price": "1000KS",
  },
  {
    "image": "assets/images/pepsi.png",
    "foodName": "Large Pepsi",
    "price": "1100KS",
  },
  {
    "image": "assets/images/burger2.png",
    "foodName": "Burger Combo2",
    "price": "5000KS",
  },
  {
    "image": "assets/images/burger1.png",
    "foodName": "Burger Combo1",
    "price": "10000KS",
  },
  {
    "image": "assets/images/pizza.png",
    "foodName": "Pizza",
    "price": "10000KS",
  },
  {
    "image": "assets/images/burger_kfc.png",
    "foodName": "Burger/KFC combo1",
    "price": "8000KS",
  },
  {
    "image": "assets/images/kfc.png",
    "foodName": "KFC combo1",
    "price": "8000KS",
  },
  {
    "image": "assets/images/medium_hamburger.png",
    "foodName": "Medium Hamburger",
    "price": "6000KS",
  },
  {
    "image": "assets/images/burger_combo1.png",
    "foodName": "Pizza Combo1",
    "price": "5000KS",
  },
  {
    "image": "assets/images/kfc.png",
    "foodName": "KFC Bucket",
    "price": "5000KS",
  },
  {
    "image": "assets/images/popcorn-small.png",
    "foodName": "Pop Corn Small",
    "price": "1000KS",
  },
  {
    "image": "assets/images/popcorn-medium.png",
    "foodName": "Pop Corn Medium",
    "price": "2000KS",
  },
];
// final List<Map<String, dynamic>> selectedFoodList = [
//   {"name": "Large Cola", "qty": 1, "price": 1000},
//   {"name": "Potatoes Chips", "qty": 1, "price": 1000}
// ];

//Payment Page Data


final List<Map<String, dynamic>> paymentList = [
  {
    "logo": "assets/images/upi.png",
    "type": "UPI",
  },
  {
    "logo": "assets/images/giftVoucher.png",
    "type": "Gift Voucher",
  },
  {
    "logo": "assets/images/quickPay.png",
    "type": "Quick Pay",
  },
  {
    "logo": "assets/images/creditCardIcon.png",
    "type": "Credit Card / Debit Card",
  },
  {
    "logo": "assets/images/redeemPoint.png",
    "type": "Redeem Point",
  },
  {
    "logo": "assets/images/mobileWallet.png",
    "type": "Mobile Wallet",
  },
  {
    "logo": "assets/images/netBanking.png",
    "type": "Net Banking",
  },
];

//Ticket Confirmation Page Data

final List<Map<String, dynamic>> BookedticketData = [
  {
    "movieName": "Black Widow (3D) (U/A)",
    "image": "assets/images/black_widow.png",
    "cinemaName": "JCGV : Junction City",
    "screenNumber": "(SCREEN 2)",
    "date": "Sat, 18 Jun, 2022",
    "time": "3:30PM",
    "location": "Q5H3+JPP, Corner of, Bogyoke Lann, Yangon",
    "noOfTicket": "2",
    "ticketNumber": "Gold-G8,G7",
    "ticketPrice": "20000Ks",
    "totalPriceForFood": "2000Ks",
    "foodName": "Potatoe Chips (Qt. 1)",
    "foodPrice": "1000Ks",
    "convenienceFee": "500Ks",
    "total": "22500Ks",
    "refundAmount": "15000KS",
  },
];
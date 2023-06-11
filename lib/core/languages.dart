import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:naqaa/pages/languages/cubit.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          "language": "Language",
          "skip": "Skip",
          "login": "Login",
          "proceed_number": "Enter your number to proceed",
          "mobile_number": "Enter your mobile number",
          "agree": "I agree with",
          "terms": " Terms & Conditions",
          "and": " and ",
          "policy": "Policy",
          "log_in": "Log In",
          "phone_validator": "Please enter your phone !",
          "terms_accept": "You must agree to Terms & Conditions and Policy",
          "check_online": "Please check your internet..",
          "home": "Home",
          "search": "Search",
          "orders": "My Orders",
          "cart": "Cart",
          "profile": "Profile",
          "select_item": "Select the item",
          "add": "Add",
          "add_successfully": "Add to Cart Successfully",
          "enter_quantity": "Enter the Quantity",
          "order_history": "Order History",
          "no_orders": "No Orders Placed Yet!",
          "delivery_address": "Delivery Address",
          "complete_order": "Complete Order",
          "order_detail": "Order Detail",
          "empty_cart": "Your Cart is Empty!",
          "add_more": "Add More",
          "cart_minimum":
              "Minimum Order Value is QR 129 and if Products is Out of Stock then New Stock will be available Soon!! Try Again Later",
          "total": "Total",
          "delete": "Delete",
          "delete_all_sub": "Are u sure to delete your cart?",
          "delete_item_sub": "Are u sure to remove this item?",
          "edit_profile": "Edit Profile",
          "name": "Name",
          "mobile_num": "Mobile Number",
          "logout": "Log Out",
          "logout_sub": "Are you sure want to logout?",
          "delete_acc": "Delete Account",
          "support": "Support",
          "no": "No",
          "yes": "Yes",
          "otp_verify": "OTP Verification",
          "sending_code":
              "Enter the digit OTP code that we sent on your number",
          "otp_validator": "Please enter correct otp",
          "verify": "Verify",
          "delivery_location": "select Delivery Location",
          "delivery_mosque": "Delivery to Mosques",
          "delivery_mosque_sub":
              "We will send you 2 photos in 'My orders' after delivery",
          "delivery_home": "Delivery Home",
          "next": "Next",
          "don't_receive": "Didn't received the OTP?",
          "send_again": "Resend OTP",
          "no_notifications": "No Notification Found!",
          "notifications": "Notifications",
          "delete_account": "Delete Account",
          "delete_account_sub": "Are you sure want to delete account?",
          "edit": "Edit",
          "order_val": "Order Value",
          "delivery_char": "Delivery Charge",
          "order_added": "Order Added",
          "order_id": "Order ID: ",
          "order_items": "Total Items: ",
          "date_time": "Date & Time ",
          "receiver_details": "Receiver Details",
          "pending": "pending",
          "done": "done",
          "canceled": "canceled",
          "address_details": "Add Address Details",
          "details1": "Building Number",
          "details1_validate": "Please enter building no",
          "details2": "Unit Number(Optional)",
          "details3": "Street Number(Optional)",
          "details4": "Zone(Optional)",
        },
        'ar': {
          "language": "اللغة",
          "skip": "تخطي",
          "login": "تسجيل الدخول",
          "proceed_number": "ادخل رقم هاتفك للإستمرار",
          "mobile_number": "ادخل رقم هاتفك",
          "agree": "اوافق علي",
          "terms": " الشروط والأحكام",
          "and": " و ",
          "policy": "السياسية",
          "log_in": "تسجيل الدخول",
          "phone_validator": "من فضلك ادخل رقم الهاتف !",
          "terms_accept": "يجب عليك الموافقة علي الشروط والأحكام السياسية",
          "check_online": "يرجي التحقق من الانترنت..",
          "home": "الرئيسة",
          "search": "بحث",
          "orders": "طلباتي",
          "cart": "السلة",
          "profile": "حسابي",
          "select_item": "اختر منتج",
          "add": "إضافة",
          "add_successfully": "تمت الاضافة بنجاح",
          "enter_quantity": "أدخل الكمية",
          "order_history": "أحداث الطلبات",
          "no_orders": "لا توجد طلبات بعد",
          "delivery_address": "عنوان الطلب",
          "complete_order": "إتمام الطلب",
          "order_detail": "تفاصيل الطلب",
          "empty_cart": "سلتك فارغة!",
          "add_more": "إضافة المزيد",
          "cart_minimum":
              "الحد الأدنى لقيمة الطلب هو 129 ريال قطري وإذا كانت المنتجات غير متوفرة فسيتم توفير مخزون جديد قريبًا !! حاول مرة أخرى في وقت لاحق",
          "total": "الإجمالي",
          "delete": "مسح",
          "delete_all_sub": "هل أنت متأكد من إزالة ما في السلة؟",
          "delete_item_sub": "هل أنت متأكد من إزالة هذا العنصر؟",
          "edit_profile": "تعديل بيانات الحساب",
          "name": "الإسم",
          "mobile_num": "رقم الجوال",
          "logout": "تسجيل الخروج",
          "logout_sub": "هل أنت متأكد من تسجيل الخروج؟",
          "delete_acc": "امسح حسابي",
          "support": "المساعدة",
          "no": "كلا",
          "yes": "نعم",
          "otp_verify": "التحقق بكلمة السر لمرة واحدة",
          "sending_code":
              "أدخل كلمة السر لمرة واحدة المبعوثة برسالة الي رقم هاتفك",
          "otp_validator": "من فضلك تحقق من الرمز",
          "verify": "تحقق",
          "delivery_location": "حدد موقع التوصيل",
          "delivery_mosque": "التوصيل للمساجد",
          "delivery_mosque_sub": "سوف نرسل لك صورتين في 'طلباتي' بعد التسليم",
          "delivery_home": "التوصيل للمنازل",
          "next": "التالي",
          "don't_receive": "لم تستلم كلمة السر لمرة واحدة؟",
          "send_again": "إعادة الإرسال",
          "no_notifications": "لاتوجد اشعارات!",
          "notifications": "الإشعارات",
          "delete_account": "مسح الحساب",
          "delete_account_sub": "هل أنت متأكد من مسح الحساب؟",
          "edit": "تعديل",
          "order_val": "قيمة الطلب",
          "delivery_char": "رسوم التوصيل",
          "order_added": "نجحت العملية",
          "order_id": "رقم الطلب:",
          "order_items": "اجمالي العناصر: ",
          "date_time": "التاريخ و الوقت ",
          "receiver_details": "تفاصيل المستلم",
          "pending": "تم وضعها",
          "done": "تم التوصيل",
          "canceled": "تم الإلغاء",
          "address_details": "ادخل تفاصيل العنوان",
          "details1": "رقم المبني / البيت",
          "details1_validate": "الرجار ادخال رقم المبني",
          "details2": "رقم الوحدة (اختياري)",
          "details3": "رقم الشارع (اختياري)",
          "details4": "رقم المنطقة (اختياري)",
        },
      };

  static void changeLanguage(BuildContext context, String languageCode) {
    LanguageAppCubit languageCubit = context.read<LanguageAppCubit>();
    languageCubit.changeLanguage(languageCode);
  }
}

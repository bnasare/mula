import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('nl'),
    Locale('pt'),
    Locale('ru'),
    Locale('zh'),
  ];

  /// No description provided for @welcomeTo.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcomeTo;

  /// No description provided for @mula.
  ///
  /// In en, this message translates to:
  /// **'MULA'**
  String get mula;

  /// No description provided for @oneAppAllInvestments.
  ///
  /// In en, this message translates to:
  /// **'One app. All your investments'**
  String get oneAppAllInvestments;

  /// No description provided for @onboardingDescription.
  ///
  /// In en, this message translates to:
  /// **'Link your accounts, track your portfolio, trade securities, and learn as you go — all in one secure app.'**
  String get onboardingDescription;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @accessYourMulaAccount.
  ///
  /// In en, this message translates to:
  /// **'Access Your MULA Account'**
  String get accessYourMulaAccount;

  /// No description provided for @signInToYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your account to continue'**
  String get signInToYourAccount;

  /// No description provided for @emailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Email or Phone'**
  String get emailOrPhone;

  /// No description provided for @enterEmailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter your email or phone number'**
  String get enterEmailOrPhone;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @resetYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Your Password'**
  String get resetYourPassword;

  /// No description provided for @resetPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your email or phone number to receive a verification code'**
  String get resetPasswordDescription;

  /// No description provided for @sendVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Send Verification Code'**
  String get sendVerificationCode;

  /// No description provided for @createNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Create New Password'**
  String get createNewPassword;

  /// No description provided for @createNewPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Your new password must be different from previously used passwords'**
  String get createNewPasswordDescription;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get enterNewPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @passwordResetSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Password Reset Successful'**
  String get passwordResetSuccessful;

  /// No description provided for @passwordResetSuccessDescription.
  ///
  /// In en, this message translates to:
  /// **'Your password has been successfully reset. You can now sign in with your new password'**
  String get passwordResetSuccessDescription;

  /// No description provided for @letsGetYouStarted.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Get You Started'**
  String get letsGetYouStarted;

  /// No description provided for @createFreeAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'Create your free MULA account in under a minute.'**
  String get createFreeAccountDescription;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @enterYourFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Full Name'**
  String get enterYourFullName;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @enterYourEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email Address'**
  String get enterYourEmailAddress;

  /// No description provided for @enterYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterYourPhoneNumber;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Password'**
  String get enterYourPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// No description provided for @apple.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get apple;

  /// No description provided for @byContinuingYouAgree.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to MULA\'s'**
  String get byContinuingYouAgree;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @otpVerification.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otpVerification;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code we just sent to your email address'**
  String get enterVerificationCode;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @emailAddress2.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress2;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @didntReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get didntReceiveCode;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @enableFaceId.
  ///
  /// In en, this message translates to:
  /// **'Enable Face ID'**
  String get enableFaceId;

  /// No description provided for @enable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get enable;

  /// No description provided for @faceIdSuccessfullyAdded.
  ///
  /// In en, this message translates to:
  /// **'Face ID successfully added'**
  String get faceIdSuccessfullyAdded;

  /// No description provided for @faceIdSuccessDescription.
  ///
  /// In en, this message translates to:
  /// **'Great! Face ID is active. Add a PIN to give your account an extra layer of security'**
  String get faceIdSuccessDescription;

  /// No description provided for @createPin.
  ///
  /// In en, this message translates to:
  /// **'Create PIN'**
  String get createPin;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @addAPin.
  ///
  /// In en, this message translates to:
  /// **'Add a PIN'**
  String get addAPin;

  /// No description provided for @addPinDescription.
  ///
  /// In en, this message translates to:
  /// **'Add a 4-digit PIN for extra security'**
  String get addPinDescription;

  /// No description provided for @pinCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'PIN created successfully'**
  String get pinCreatedSuccessfully;

  /// No description provided for @pinCreatedDescription.
  ///
  /// In en, this message translates to:
  /// **'Let\'s complete your account registration'**
  String get pinCreatedDescription;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @enterYourPin.
  ///
  /// In en, this message translates to:
  /// **'Enter your pin to continue'**
  String get enterYourPin;

  /// No description provided for @tellUsAboutYou.
  ///
  /// In en, this message translates to:
  /// **'Tell Us About You'**
  String get tellUsAboutYou;

  /// No description provided for @tellUsAboutYouDescription.
  ///
  /// In en, this message translates to:
  /// **'This helps us personalize your MULA experience'**
  String get tellUsAboutYouDescription;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @residentialAddress.
  ///
  /// In en, this message translates to:
  /// **'Residential Address'**
  String get residentialAddress;

  /// No description provided for @enterResidentialAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter your residential address'**
  String get enterResidentialAddress;

  /// No description provided for @gpsAddress.
  ///
  /// In en, this message translates to:
  /// **'GPS address'**
  String get gpsAddress;

  /// No description provided for @enterGpsAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter Your GPS address'**
  String get enterGpsAddress;

  /// No description provided for @occupation.
  ///
  /// In en, this message translates to:
  /// **'Occupation'**
  String get occupation;

  /// No description provided for @whatIsYourOccupation.
  ///
  /// In en, this message translates to:
  /// **'What is your occupation?'**
  String get whatIsYourOccupation;

  /// No description provided for @personalDetails.
  ///
  /// In en, this message translates to:
  /// **'Personal Details'**
  String get personalDetails;

  /// No description provided for @personalDetailsDescription.
  ///
  /// In en, this message translates to:
  /// **'We need a few details to set up your account'**
  String get personalDetailsDescription;

  /// No description provided for @nationality.
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get nationality;

  /// No description provided for @selectNationality.
  ///
  /// In en, this message translates to:
  /// **'Select your nationality'**
  String get selectNationality;

  /// No description provided for @emergencyNumber.
  ///
  /// In en, this message translates to:
  /// **'Emergency Number'**
  String get emergencyNumber;

  /// No description provided for @enterEmergencyNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter emergency contact number'**
  String get enterEmergencyNumber;

  /// No description provided for @identificationDetails.
  ///
  /// In en, this message translates to:
  /// **'Identification Details'**
  String get identificationDetails;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @bankDetails.
  ///
  /// In en, this message translates to:
  /// **'Bank Details'**
  String get bankDetails;

  /// No description provided for @selectBank.
  ///
  /// In en, this message translates to:
  /// **'Select Bank'**
  String get selectBank;

  /// No description provided for @selectYourBank.
  ///
  /// In en, this message translates to:
  /// **'Select your bank'**
  String get selectYourBank;

  /// No description provided for @bankAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'Bank account number'**
  String get bankAccountNumber;

  /// No description provided for @enterYourAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your account number'**
  String get enterYourAccountNumber;

  /// No description provided for @chooseAccountType.
  ///
  /// In en, this message translates to:
  /// **'Choose Account Type'**
  String get chooseAccountType;

  /// No description provided for @chooseAccountTypeDescription.
  ///
  /// In en, this message translates to:
  /// **'Choosing the right account type helps us connect you to the right providers.'**
  String get chooseAccountTypeDescription;

  /// No description provided for @brokers.
  ///
  /// In en, this message translates to:
  /// **'Brokers'**
  String get brokers;

  /// No description provided for @brokersDescription.
  ///
  /// In en, this message translates to:
  /// **'Select your broker to start your investment journey.'**
  String get brokersDescription;

  /// No description provided for @noBrokersFound.
  ///
  /// In en, this message translates to:
  /// **'No brokers found'**
  String get noBrokersFound;

  /// No description provided for @accountDetailsSuccessfullySubmitted.
  ///
  /// In en, this message translates to:
  /// **'Account details successfully submitted'**
  String get accountDetailsSuccessfullySubmitted;

  /// No description provided for @accountDetailsSuccessDescription.
  ///
  /// In en, this message translates to:
  /// **'Your account has been created. Check your email to validate your account. Check your email for updates on the status of verification.'**
  String get accountDetailsSuccessDescription;

  /// No description provided for @idVerification.
  ///
  /// In en, this message translates to:
  /// **'ID Verification'**
  String get idVerification;

  /// No description provided for @selectIdType.
  ///
  /// In en, this message translates to:
  /// **'Select an ID type to verify your identity'**
  String get selectIdType;

  /// No description provided for @ghanaCard.
  ///
  /// In en, this message translates to:
  /// **'Ghana Card'**
  String get ghanaCard;

  /// No description provided for @driversLicense.
  ///
  /// In en, this message translates to:
  /// **'Driver\'s License'**
  String get driversLicense;

  /// No description provided for @passport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get passport;

  /// No description provided for @uploadDocumentsDescription.
  ///
  /// In en, this message translates to:
  /// **'Upload your documents securely to verify your identity and finish setting up your account'**
  String get uploadDocumentsDescription;

  /// No description provided for @pictureOfFront.
  ///
  /// In en, this message translates to:
  /// **'Picture of the front'**
  String get pictureOfFront;

  /// No description provided for @pictureOfBack.
  ///
  /// In en, this message translates to:
  /// **'Picture of the back'**
  String get pictureOfBack;

  /// No description provided for @tapToUpload.
  ///
  /// In en, this message translates to:
  /// **'Tap to upload'**
  String get tapToUpload;

  /// No description provided for @imageUploaded.
  ///
  /// In en, this message translates to:
  /// **'Image uploaded'**
  String get imageUploaded;

  /// No description provided for @maxSize.
  ///
  /// In en, this message translates to:
  /// **'Max size: 2MB'**
  String get maxSize;

  /// No description provided for @number.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get number;

  /// No description provided for @issueDate.
  ///
  /// In en, this message translates to:
  /// **'Issue Date'**
  String get issueDate;

  /// No description provided for @expiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry date'**
  String get expiryDate;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @investmentExperience.
  ///
  /// In en, this message translates to:
  /// **'Your Investment Experience'**
  String get investmentExperience;

  /// No description provided for @investmentExperienceDescription.
  ///
  /// In en, this message translates to:
  /// **'This helps us recommend the best tools, resources and layout for you'**
  String get investmentExperienceDescription;

  /// No description provided for @beginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get beginner;

  /// No description provided for @beginnerDescription.
  ///
  /// In en, this message translates to:
  /// **'I\'m just starting out. I want to learn the basics.'**
  String get beginnerDescription;

  /// No description provided for @intermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get intermediate;

  /// No description provided for @intermediateDescription.
  ///
  /// In en, this message translates to:
  /// **'I\'ve done some investing and understand how things work.'**
  String get intermediateDescription;

  /// No description provided for @advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// No description provided for @advancedDescription.
  ///
  /// In en, this message translates to:
  /// **'I\'m experienced and want full access to advanced tools.'**
  String get advancedDescription;

  /// No description provided for @goodHandsTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re in good hands'**
  String get goodHandsTitle;

  /// No description provided for @goodHandsDescription.
  ///
  /// In en, this message translates to:
  /// **'Investing might sound intimidating, but with MULA, you don\'t need to be an expert to start.\n\nWe\'ll walk you through every step, from linking your accounts to understanding your portfolio, so you can invest with confidence.'**
  String get goodHandsDescription;

  /// No description provided for @hereIsWhatYouCanExpect.
  ///
  /// In en, this message translates to:
  /// **'Here\'s what you can expect:'**
  String get hereIsWhatYouCanExpect;

  /// No description provided for @toolsToGrowKnowledge.
  ///
  /// In en, this message translates to:
  /// **'Tools to grow your knowledge'**
  String get toolsToGrowKnowledge;

  /// No description provided for @supportWheneverNeeded.
  ///
  /// In en, this message translates to:
  /// **'Support whenever you need it'**
  String get supportWheneverNeeded;

  /// No description provided for @guidanceToExplore.
  ///
  /// In en, this message translates to:
  /// **'Guidance to explore investment opportunities'**
  String get guidanceToExplore;

  /// No description provided for @simpleExplanations.
  ///
  /// In en, this message translates to:
  /// **'Simple explanations at every step'**
  String get simpleExplanations;

  /// No description provided for @linkInvestmentAccounts.
  ///
  /// In en, this message translates to:
  /// **'Link Your Investment Accounts'**
  String get linkInvestmentAccounts;

  /// No description provided for @linkAccountsDescription.
  ///
  /// In en, this message translates to:
  /// **'This helps us show everything you own, in one place'**
  String get linkAccountsDescription;

  /// No description provided for @linkMoreAccountsDescription.
  ///
  /// In en, this message translates to:
  /// **'Link more accounts to get the full picture of your portfolio'**
  String get linkMoreAccountsDescription;

  /// No description provided for @csdAccount.
  ///
  /// In en, this message translates to:
  /// **'I have a CSD account'**
  String get csdAccount;

  /// No description provided for @csdAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'For securities like stocks, bonds and T-bills'**
  String get csdAccountDescription;

  /// No description provided for @cisAccount.
  ///
  /// In en, this message translates to:
  /// **'I have a CIS account'**
  String get cisAccount;

  /// No description provided for @cisAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'From Fund Managers like Databank, EDC, etc.'**
  String get cisAccountDescription;

  /// No description provided for @csdAccountSimple.
  ///
  /// In en, this message translates to:
  /// **'CSD Account'**
  String get csdAccountSimple;

  /// No description provided for @csdAccountDescriptionSimple.
  ///
  /// In en, this message translates to:
  /// **'Securities like stocks, bonds and T-bills'**
  String get csdAccountDescriptionSimple;

  /// No description provided for @cisAccountSimple.
  ///
  /// In en, this message translates to:
  /// **'CIS Account'**
  String get cisAccountSimple;

  /// No description provided for @cisAccountDescriptionSimple.
  ///
  /// In en, this message translates to:
  /// **'Fund Managers like Databank, EDC, etc.'**
  String get cisAccountDescriptionSimple;

  /// No description provided for @dontHaveAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'You can create an account and start investing today'**
  String get dontHaveAccountDescription;

  /// No description provided for @selectFundManager.
  ///
  /// In en, this message translates to:
  /// **'Select Fund Manager'**
  String get selectFundManager;

  /// No description provided for @selectFundManagerDescription.
  ///
  /// In en, this message translates to:
  /// **'Select your fund manager to start your investment journey.'**
  String get selectFundManagerDescription;

  /// No description provided for @searchByAssetNameOrType.
  ///
  /// In en, this message translates to:
  /// **'Search by asset name or type'**
  String get searchByAssetNameOrType;

  /// No description provided for @addAnother.
  ///
  /// In en, this message translates to:
  /// **'Add Another'**
  String get addAnother;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @fundManager.
  ///
  /// In en, this message translates to:
  /// **'Fund Manager'**
  String get fundManager;

  /// No description provided for @fundsManaged.
  ///
  /// In en, this message translates to:
  /// **'Funds managed by'**
  String get fundsManaged;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @fundManagerLinkedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Fund manager linked successfully'**
  String get fundManagerLinkedSuccessfully;

  /// No description provided for @fundManagerLinkedSuccessDescription.
  ///
  /// In en, this message translates to:
  /// **'Your fund manager has been linked to your account. You can now view and manage your investments.'**
  String get fundManagerLinkedSuccessDescription;

  /// No description provided for @enterCsdAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'What\'s your CSD account number?'**
  String get enterCsdAccountNumber;

  /// No description provided for @csdAccountNumberDescription.
  ///
  /// In en, this message translates to:
  /// **'You can find this number on your T-bill certificate. If you don\'t have it, contact your broker for help'**
  String get csdAccountNumberDescription;

  /// No description provided for @accountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get accountNumber;

  /// No description provided for @csdAccountNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Eg: 123-456-789'**
  String get csdAccountNumberHint;

  /// No description provided for @searchLinkedBrokers.
  ///
  /// In en, this message translates to:
  /// **'Search Linked Brokers'**
  String get searchLinkedBrokers;

  /// No description provided for @createOne.
  ///
  /// In en, this message translates to:
  /// **'Create one'**
  String get createOne;

  /// No description provided for @weFoundYourBrokers.
  ///
  /// In en, this message translates to:
  /// **'We found your brokers'**
  String get weFoundYourBrokers;

  /// No description provided for @signInToBrokersDescription.
  ///
  /// In en, this message translates to:
  /// **'Sign into your broker accounts so we can securely fetch your investments'**
  String get signInToBrokersDescription;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @deposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get deposit;

  /// No description provided for @chooseAccountToTopUp.
  ///
  /// In en, this message translates to:
  /// **'Choose an account to top up from'**
  String get chooseAccountToTopUp;

  /// No description provided for @mobileMoneyDeposit.
  ///
  /// In en, this message translates to:
  /// **'Mobile Money'**
  String get mobileMoneyDeposit;

  /// No description provided for @bankAccount.
  ///
  /// In en, this message translates to:
  /// **'Bank Account'**
  String get bankAccount;

  /// No description provided for @selectAccount.
  ///
  /// In en, this message translates to:
  /// **'Select Account'**
  String get selectAccount;

  /// No description provided for @addAnotherAccount.
  ///
  /// In en, this message translates to:
  /// **'Add another account'**
  String get addAnotherAccount;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your Phone Number'**
  String get enterPhoneNumber;

  /// No description provided for @network.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get network;

  /// No description provided for @selectNetwork.
  ///
  /// In en, this message translates to:
  /// **'Select Network'**
  String get selectNetwork;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter Amount'**
  String get enterAmount;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @reviewAndConfirm.
  ///
  /// In en, this message translates to:
  /// **'Review and confirm your details'**
  String get reviewAndConfirm;

  /// No description provided for @confirmDeposit.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmDeposit;

  /// No description provided for @mobileMoneyPrompt.
  ///
  /// In en, this message translates to:
  /// **'You will receive a mobile money prompt. Enter your pin to confirm this transaction'**
  String get mobileMoneyPrompt;

  /// No description provided for @okay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get okay;

  /// No description provided for @depositSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Deposit Successful'**
  String get depositSuccessful;

  /// No description provided for @fundsSuccessfullyDeposited.
  ///
  /// In en, this message translates to:
  /// **'Funds successfully deposited into your account'**
  String get fundsSuccessfullyDeposited;

  /// No description provided for @selectBankAccount.
  ///
  /// In en, this message translates to:
  /// **'Select Bank Account'**
  String get selectBankAccount;

  /// No description provided for @bank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get bank;

  /// No description provided for @accountName.
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get accountName;

  /// No description provided for @enterAccountName.
  ///
  /// In en, this message translates to:
  /// **'Enter account name'**
  String get enterAccountName;

  /// No description provided for @enterBankAccountInfo.
  ///
  /// In en, this message translates to:
  /// **'Enter Account Information'**
  String get enterBankAccountInfo;

  /// No description provided for @confirmBankDeposit.
  ///
  /// In en, this message translates to:
  /// **'Confirm Deposit'**
  String get confirmBankDeposit;

  /// No description provided for @forYourSecurityEnterPin.
  ///
  /// In en, this message translates to:
  /// **'For your security, please enter your 4-digit PIN to continue'**
  String get forYourSecurityEnterPin;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @chooseWithdrawalDestination.
  ///
  /// In en, this message translates to:
  /// **'Choose a destination account'**
  String get chooseWithdrawalDestination;

  /// No description provided for @withdrawTo.
  ///
  /// In en, this message translates to:
  /// **'Withdraw To'**
  String get withdrawTo;

  /// No description provided for @selectWithdrawAccount.
  ///
  /// In en, this message translates to:
  /// **'Select Account'**
  String get selectWithdrawAccount;

  /// No description provided for @enterWithdrawAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter Amount'**
  String get enterWithdrawAmount;

  /// No description provided for @confirmWithdrawal.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmWithdrawal;

  /// No description provided for @withdrawalSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Successful'**
  String get withdrawalSuccessful;

  /// No description provided for @moneySuccessfullyWithdrawn.
  ///
  /// In en, this message translates to:
  /// **'Money has successfully been withdrawn'**
  String get moneySuccessfullyWithdrawn;

  /// No description provided for @enterPinToConfirm.
  ///
  /// In en, this message translates to:
  /// **'Enter your pin to confirm'**
  String get enterPinToConfirm;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No Notifications'**
  String get noNotifications;

  /// No description provided for @noNotificationsDescription.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up!'**
  String get noNotificationsDescription;

  /// No description provided for @markAllAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get markAllAsRead;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @exploreInvestments.
  ///
  /// In en, this message translates to:
  /// **'Explore Investments'**
  String get exploreInvestments;

  /// No description provided for @featured.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get featured;

  /// No description provided for @equity.
  ///
  /// In en, this message translates to:
  /// **'Equity'**
  String get equity;

  /// No description provided for @mutualFund.
  ///
  /// In en, this message translates to:
  /// **'Mutual Fund'**
  String get mutualFund;

  /// No description provided for @portfolio.
  ///
  /// In en, this message translates to:
  /// **'Portfolio'**
  String get portfolio;

  /// No description provided for @learn.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get learn;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @totalPortfolioValue.
  ///
  /// In en, this message translates to:
  /// **'Total Portfolio Value'**
  String get totalPortfolioValue;

  /// No description provided for @learningCorner.
  ///
  /// In en, this message translates to:
  /// **'Learning Corner'**
  String get learningCorner;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn more'**
  String get learnMore;

  /// No description provided for @learnHowBondsWork.
  ///
  /// In en, this message translates to:
  /// **'Learn how bonds work'**
  String get learnHowBondsWork;

  /// No description provided for @assetOverview.
  ///
  /// In en, this message translates to:
  /// **'Asset Overview'**
  String get assetOverview;

  /// No description provided for @classLabel.
  ///
  /// In en, this message translates to:
  /// **'Class'**
  String get classLabel;

  /// No description provided for @broker.
  ///
  /// In en, this message translates to:
  /// **'Broker'**
  String get broker;

  /// No description provided for @performance.
  ///
  /// In en, this message translates to:
  /// **'Performance'**
  String get performance;

  /// No description provided for @recentActivities.
  ///
  /// In en, this message translates to:
  /// **'Recent Activities'**
  String get recentActivities;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @trade.
  ///
  /// In en, this message translates to:
  /// **'Trade'**
  String get trade;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoon;

  /// No description provided for @viewPortfolio.
  ///
  /// In en, this message translates to:
  /// **'View Portfolio'**
  String get viewPortfolio;

  /// No description provided for @linkAccount.
  ///
  /// In en, this message translates to:
  /// **'Link Account'**
  String get linkAccount;

  /// No description provided for @cashWallet.
  ///
  /// In en, this message translates to:
  /// **'Cash Wallet'**
  String get cashWallet;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @reportAnIssue.
  ///
  /// In en, this message translates to:
  /// **'Report an issue'**
  String get reportAnIssue;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @emergencyFunds.
  ///
  /// In en, this message translates to:
  /// **'Emergency Funds'**
  String get emergencyFunds;

  /// No description provided for @youHaveNoTransactions.
  ///
  /// In en, this message translates to:
  /// **'You have no transactions'**
  String get youHaveNoTransactions;

  /// No description provided for @transactionReceipt.
  ///
  /// In en, this message translates to:
  /// **'Transaction Receipt'**
  String get transactionReceipt;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @assetClass.
  ///
  /// In en, this message translates to:
  /// **'Asset Class'**
  String get assetClass;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @purchasePrice.
  ///
  /// In en, this message translates to:
  /// **'Purchase Price'**
  String get purchasePrice;

  /// No description provided for @totalCost.
  ///
  /// In en, this message translates to:
  /// **'Total Cost'**
  String get totalCost;

  /// No description provided for @charges.
  ///
  /// In en, this message translates to:
  /// **'Charges'**
  String get charges;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @executedBy.
  ///
  /// In en, this message translates to:
  /// **'Executed by'**
  String get executedBy;

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get id;

  /// No description provided for @addNotes.
  ///
  /// In en, this message translates to:
  /// **'Add notes'**
  String get addNotes;

  /// No description provided for @print.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get print;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// No description provided for @sell.
  ///
  /// In en, this message translates to:
  /// **'Sell'**
  String get sell;

  /// No description provided for @dateRange.
  ///
  /// In en, this message translates to:
  /// **'Date Range'**
  String get dateRange;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by:'**
  String get sortBy;

  /// No description provided for @sortByStatus.
  ///
  /// In en, this message translates to:
  /// **'Sort by Status'**
  String get sortByStatus;

  /// No description provided for @keywordSearch.
  ///
  /// In en, this message translates to:
  /// **'Keyword Search'**
  String get keywordSearch;

  /// No description provided for @enterAKeyword.
  ///
  /// In en, this message translates to:
  /// **'Enter a keyword'**
  String get enterAKeyword;

  /// No description provided for @last30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days'**
  String get last30Days;

  /// No description provided for @last60Days.
  ///
  /// In en, this message translates to:
  /// **'Last 60 days'**
  String get last60Days;

  /// No description provided for @thisYear.
  ///
  /// In en, this message translates to:
  /// **'This Year'**
  String get thisYear;

  /// No description provided for @customDate.
  ///
  /// In en, this message translates to:
  /// **'Custom Date'**
  String get customDate;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// No description provided for @chooseFileFormat.
  ///
  /// In en, this message translates to:
  /// **'Choose file format'**
  String get chooseFileFormat;

  /// No description provided for @pdfFormat.
  ///
  /// In en, this message translates to:
  /// **'PDF Format'**
  String get pdfFormat;

  /// No description provided for @csv.
  ///
  /// In en, this message translates to:
  /// **'CSV'**
  String get csv;

  /// No description provided for @tellUsWhatsGoingOn.
  ///
  /// In en, this message translates to:
  /// **'Tell us what\'s going on and we\'ll get back to you shortly'**
  String get tellUsWhatsGoingOn;

  /// No description provided for @describeYourIssue.
  ///
  /// In en, this message translates to:
  /// **'Describe your issue...'**
  String get describeYourIssue;

  /// No description provided for @issueReportedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Issue reported successfully'**
  String get issueReportedSuccessfully;

  /// No description provided for @exportingAs.
  ///
  /// In en, this message translates to:
  /// **'Exporting as'**
  String get exportingAs;

  /// No description provided for @printComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Print coming soon'**
  String get printComingSoon;

  /// No description provided for @shareComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Share coming soon'**
  String get shareComingSoon;

  /// No description provided for @withdrawComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Withdraw coming soon'**
  String get withdrawComingSoon;

  /// No description provided for @depositComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Deposit coming soon'**
  String get depositComingSoon;

  /// No description provided for @noTransactionsYet.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get noTransactionsYet;

  /// No description provided for @hiImMulaBot.
  ///
  /// In en, this message translates to:
  /// **'Hi, I\'m Mula Bot'**
  String get hiImMulaBot;

  /// No description provided for @yourPersonalGuide.
  ///
  /// In en, this message translates to:
  /// **'Your personal guide to smart investing'**
  String get yourPersonalGuide;

  /// No description provided for @startChat.
  ///
  /// In en, this message translates to:
  /// **'Start Chat'**
  String get startChat;

  /// No description provided for @mulaBotIsTyping.
  ///
  /// In en, this message translates to:
  /// **'Mula Bot is typing...'**
  String get mulaBotIsTyping;

  /// No description provided for @typeYourMessageHere.
  ///
  /// In en, this message translates to:
  /// **'Type your message here'**
  String get typeYourMessageHere;

  /// No description provided for @hiWhatsOnYourMind.
  ///
  /// In en, this message translates to:
  /// **'Hi {name}👋 What\'s on your mind?'**
  String hiWhatsOnYourMind(String name);

  /// No description provided for @whichInvestmentsLowRisk.
  ///
  /// In en, this message translates to:
  /// **'Which investments are low risk?'**
  String get whichInvestmentsLowRisk;

  /// No description provided for @suggestBeginnerPlan.
  ///
  /// In en, this message translates to:
  /// **'Suggest a beginner investment plan'**
  String get suggestBeginnerPlan;

  /// No description provided for @howDoIStartInvesting.
  ///
  /// In en, this message translates to:
  /// **'How do I start investing?'**
  String get howDoIStartInvesting;

  /// No description provided for @explainTreasuryBills.
  ///
  /// In en, this message translates to:
  /// **'Explain Treasury Bills'**
  String get explainTreasuryBills;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @uploadFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Upload from Gallery'**
  String get uploadFromGallery;

  /// No description provided for @changeProfileImage.
  ///
  /// In en, this message translates to:
  /// **'Change Profile Image'**
  String get changeProfileImage;

  /// No description provided for @changeCoverImage.
  ///
  /// In en, this message translates to:
  /// **'Change Cover Image'**
  String get changeCoverImage;

  /// No description provided for @removeImage.
  ///
  /// In en, this message translates to:
  /// **'Remove Image'**
  String get removeImage;

  /// No description provided for @failedToCropImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to crop image'**
  String get failedToCropImage;

  /// No description provided for @errorCapturingImage.
  ///
  /// In en, this message translates to:
  /// **'Error capturing image'**
  String get errorCapturingImage;

  /// No description provided for @errorSelectingImage.
  ///
  /// In en, this message translates to:
  /// **'Error selecting image'**
  String get errorSelectingImage;

  /// No description provided for @withdrawal.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal'**
  String get withdrawal;

  /// No description provided for @linkedAccounts.
  ///
  /// In en, this message translates to:
  /// **'Linked Accounts'**
  String get linkedAccounts;

  /// No description provided for @cisAccounts.
  ///
  /// In en, this message translates to:
  /// **'CIS Accounts'**
  String get cisAccounts;

  /// No description provided for @csdAccounts.
  ///
  /// In en, this message translates to:
  /// **'CSD Accounts'**
  String get csdAccounts;

  /// No description provided for @mobileMoneyAccounts.
  ///
  /// In en, this message translates to:
  /// **'Mobile Money Accounts'**
  String get mobileMoneyAccounts;

  /// No description provided for @bankAccounts.
  ///
  /// In en, this message translates to:
  /// **'Bank Accounts'**
  String get bankAccounts;

  /// No description provided for @addAccount.
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get addAccount;

  /// No description provided for @accountManagement.
  ///
  /// In en, this message translates to:
  /// **'Account Management'**
  String get accountManagement;

  /// No description provided for @unlinkAccount.
  ///
  /// In en, this message translates to:
  /// **'Unlink Account'**
  String get unlinkAccount;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @areYouSureYouWantToUnlink.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to unlink this account?'**
  String get areYouSureYouWantToUnlink;

  /// No description provided for @accountUnlinkedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Account unlinked successfully'**
  String get accountUnlinkedSuccessfully;

  /// No description provided for @manageAccount.
  ///
  /// In en, this message translates to:
  /// **'Manage Account'**
  String get manageAccount;

  /// No description provided for @enterAccountInformation.
  ///
  /// In en, this message translates to:
  /// **'Enter Account Information'**
  String get enterAccountInformation;

  /// No description provided for @enterAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Account Number'**
  String get enterAccountNumber;

  /// No description provided for @accountLinkedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Account Linked Successfully'**
  String get accountLinkedSuccessfully;

  /// No description provided for @accountLinkedSuccessDescription.
  ///
  /// In en, this message translates to:
  /// **'Your account has been successfully linked to MULA'**
  String get accountLinkedSuccessDescription;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @learningTracks.
  ///
  /// In en, this message translates to:
  /// **'Learning Tracks'**
  String get learningTracks;

  /// No description provided for @featuredTracks.
  ///
  /// In en, this message translates to:
  /// **'Featured Tracks'**
  String get featuredTracks;

  /// No description provided for @popularLessons.
  ///
  /// In en, this message translates to:
  /// **'Popular Lessons'**
  String get popularLessons;

  /// No description provided for @newToInvesting.
  ///
  /// In en, this message translates to:
  /// **'New to Investing? Start Here'**
  String get newToInvesting;

  /// No description provided for @newToInvestingDescription.
  ///
  /// In en, this message translates to:
  /// **'If you are new to investing and want to explore the ecosystem, start with this article'**
  String get newToInvestingDescription;

  /// No description provided for @allTracks.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allTracks;

  /// No description provided for @ghanaStocks.
  ///
  /// In en, this message translates to:
  /// **'Ghana Stocks'**
  String get ghanaStocks;

  /// No description provided for @tBillsBonds.
  ///
  /// In en, this message translates to:
  /// **'T-Bills/Bonds'**
  String get tBillsBonds;

  /// No description provided for @mutualFunds.
  ///
  /// In en, this message translates to:
  /// **'Mutual Funds'**
  String get mutualFunds;

  /// No description provided for @article.
  ///
  /// In en, this message translates to:
  /// **'Article'**
  String get article;

  /// No description provided for @mins.
  ///
  /// In en, this message translates to:
  /// **'{count} mins'**
  String mins(int count);

  /// No description provided for @whatIsAMutualFund.
  ///
  /// In en, this message translates to:
  /// **'What is a Mutual Fund?'**
  String get whatIsAMutualFund;

  /// No description provided for @poolingMoneySpreading.
  ///
  /// In en, this message translates to:
  /// **'Pooling money, spreading risk, growing wealth'**
  String get poolingMoneySpreading;

  /// No description provided for @markAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark as read'**
  String get markAsRead;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @investIn.
  ///
  /// In en, this message translates to:
  /// **'Invest in {asset}'**
  String investIn(String asset);

  /// No description provided for @takeAQuiz.
  ///
  /// In en, this message translates to:
  /// **'Take a quiz'**
  String get takeAQuiz;

  /// No description provided for @shareWithFriends.
  ///
  /// In en, this message translates to:
  /// **'Share with your friends or leave a comment'**
  String get shareWithFriends;

  /// No description provided for @leaveComment.
  ///
  /// In en, this message translates to:
  /// **'Leave a comment'**
  String get leaveComment;

  /// No description provided for @reply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get reply;

  /// No description provided for @viewComments.
  ///
  /// In en, this message translates to:
  /// **'View comments ({count})'**
  String viewComments(String count);

  /// No description provided for @minsRead.
  ///
  /// In en, this message translates to:
  /// **'{count} mins read'**
  String minsRead(int count);

  /// No description provided for @views.
  ///
  /// In en, this message translates to:
  /// **'{count}k'**
  String views(String count);

  /// No description provided for @showMoreReplies.
  ///
  /// In en, this message translates to:
  /// **'Show {count} more replies'**
  String showMoreReplies(int count);

  /// No description provided for @question.
  ///
  /// In en, this message translates to:
  /// **'Question {number}'**
  String question(int number);

  /// No description provided for @wellDone.
  ///
  /// In en, this message translates to:
  /// **'Well Done {name}!'**
  String wellDone(String name);

  /// No description provided for @youAnsweredCorrectly.
  ///
  /// In en, this message translates to:
  /// **'You answered {correct} of {total} correctly. Keep practicing to reach 100% mastery'**
  String youAnsweredCorrectly(int correct, int total);

  /// No description provided for @quizScoreMessage.
  ///
  /// In en, this message translates to:
  /// **'You answered {correct} of {total} correctly'**
  String quizScoreMessage(int correct, int total);

  /// No description provided for @keepPracticing.
  ///
  /// In en, this message translates to:
  /// **'Keep practicing to reach 100% mastery'**
  String get keepPracticing;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @goToHome.
  ///
  /// In en, this message translates to:
  /// **'Go to Home'**
  String get goToHome;

  /// No description provided for @exploreOtherResources.
  ///
  /// In en, this message translates to:
  /// **'Explore other resources'**
  String get exploreOtherResources;

  /// No description provided for @pts.
  ///
  /// In en, this message translates to:
  /// **'+{points}pts'**
  String pts(int points);

  /// No description provided for @searchByAsset.
  ///
  /// In en, this message translates to:
  /// **'Search by asset, fund manager, category'**
  String get searchByAsset;

  /// No description provided for @relevance.
  ///
  /// In en, this message translates to:
  /// **'Relevance'**
  String get relevance;

  /// No description provided for @popular.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get popular;

  /// No description provided for @stocks.
  ///
  /// In en, this message translates to:
  /// **'Stocks'**
  String get stocks;

  /// No description provided for @highYieldFunds.
  ///
  /// In en, this message translates to:
  /// **'High-Yield Funds'**
  String get highYieldFunds;

  /// No description provided for @tBills.
  ///
  /// In en, this message translates to:
  /// **'T-Bills'**
  String get tBills;

  /// No description provided for @stock.
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get stock;

  /// No description provided for @selectLevel.
  ///
  /// In en, this message translates to:
  /// **'Select level'**
  String get selectLevel;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategory;

  /// No description provided for @assetBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Asset Breakdown'**
  String get assetBreakdown;

  /// No description provided for @assetHoldings.
  ///
  /// In en, this message translates to:
  /// **'Asset Holdings'**
  String get assetHoldings;

  /// No description provided for @portfolioSummary.
  ///
  /// In en, this message translates to:
  /// **'Portfolio Summary'**
  String get portfolioSummary;

  /// No description provided for @totalInvestmentValue.
  ///
  /// In en, this message translates to:
  /// **'Total Investment Value'**
  String get totalInvestmentValue;

  /// No description provided for @totalDeposit.
  ///
  /// In en, this message translates to:
  /// **'Total Deposit'**
  String get totalDeposit;

  /// No description provided for @totalWithdrawal.
  ///
  /// In en, this message translates to:
  /// **'Total Withdrawal'**
  String get totalWithdrawal;

  /// No description provided for @realizedIncome.
  ///
  /// In en, this message translates to:
  /// **'Realized Income'**
  String get realizedIncome;

  /// No description provided for @unrealizedIncome.
  ///
  /// In en, this message translates to:
  /// **'Unrealized Income'**
  String get unrealizedIncome;

  /// No description provided for @cumulativeReturn.
  ///
  /// In en, this message translates to:
  /// **'Cumulative Return'**
  String get cumulativeReturn;

  /// No description provided for @seePortfolioSummary.
  ///
  /// In en, this message translates to:
  /// **'See portfolio summary'**
  String get seePortfolioSummary;

  /// No description provided for @noPortfolioData.
  ///
  /// In en, this message translates to:
  /// **'No portfolio data available'**
  String get noPortfolioData;

  /// No description provided for @seeAdvancedChart.
  ///
  /// In en, this message translates to:
  /// **'See Advanced Chart'**
  String get seeAdvancedChart;

  /// No description provided for @myInvestments.
  ///
  /// In en, this message translates to:
  /// **'My Investments'**
  String get myInvestments;

  /// No description provided for @currentValue.
  ///
  /// In en, this message translates to:
  /// **'Current Value'**
  String get currentValue;

  /// No description provided for @returnLabel.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get returnLabel;

  /// No description provided for @shares.
  ///
  /// In en, this message translates to:
  /// **'Shares'**
  String get shares;

  /// No description provided for @costPrice.
  ///
  /// In en, this message translates to:
  /// **'Cost Price'**
  String get costPrice;

  /// No description provided for @capitalGains.
  ///
  /// In en, this message translates to:
  /// **'Capital Gains/(Losses)'**
  String get capitalGains;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @treasuryBill.
  ///
  /// In en, this message translates to:
  /// **'Treasury Bill'**
  String get treasuryBill;

  /// No description provided for @purchaseInterestRate.
  ///
  /// In en, this message translates to:
  /// **'Purchase Interest Rate'**
  String get purchaseInterestRate;

  /// No description provided for @accruedInterest.
  ///
  /// In en, this message translates to:
  /// **'Accrued Interest'**
  String get accruedInterest;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @holdings.
  ///
  /// In en, this message translates to:
  /// **'Holdings'**
  String get holdings;

  /// No description provided for @allocation.
  ///
  /// In en, this message translates to:
  /// **'Allocation'**
  String get allocation;

  /// No description provided for @metrics.
  ///
  /// In en, this message translates to:
  /// **'Metrics'**
  String get metrics;

  /// No description provided for @units.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get units;

  /// No description provided for @industry.
  ///
  /// In en, this message translates to:
  /// **'Industry'**
  String get industry;

  /// No description provided for @rank.
  ///
  /// In en, this message translates to:
  /// **'Rank'**
  String get rank;

  /// No description provided for @ghanaCedi.
  ///
  /// In en, this message translates to:
  /// **'Ghana Cedi'**
  String get ghanaCedi;

  /// No description provided for @backToChart.
  ///
  /// In en, this message translates to:
  /// **'Back to chart'**
  String get backToChart;

  /// No description provided for @limitMarket.
  ///
  /// In en, this message translates to:
  /// **'Limit Market'**
  String get limitMarket;

  /// No description provided for @marketOrder.
  ///
  /// In en, this message translates to:
  /// **'Market Order'**
  String get marketOrder;

  /// No description provided for @cashBalance.
  ///
  /// In en, this message translates to:
  /// **'Cash Balance'**
  String get cashBalance;

  /// No description provided for @enterSharesPurchaseHint.
  ///
  /// In en, this message translates to:
  /// **'Enter number of shares you want to purchase'**
  String get enterSharesPurchaseHint;

  /// No description provided for @enterSharesSellHint.
  ///
  /// In en, this message translates to:
  /// **'Enter number of shares you want to sell'**
  String get enterSharesSellHint;

  /// No description provided for @enterAmountPurchaseHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the amount you want to purchase'**
  String get enterAmountPurchaseHint;

  /// No description provided for @enterAmountSellHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the amount you want to sell'**
  String get enterAmountSellHint;

  /// No description provided for @reviewOrder.
  ///
  /// In en, this message translates to:
  /// **'Review Order'**
  String get reviewOrder;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @interestRate.
  ///
  /// In en, this message translates to:
  /// **'Interest Rate'**
  String get interestRate;

  /// No description provided for @grossConsideration.
  ///
  /// In en, this message translates to:
  /// **'Gross Consideration'**
  String get grossConsideration;

  /// No description provided for @informationTechnology.
  ///
  /// In en, this message translates to:
  /// **'Information Technology'**
  String get informationTechnology;

  /// No description provided for @companyInc.
  ///
  /// In en, this message translates to:
  /// **'Company Inc'**
  String get companyInc;

  /// No description provided for @sector.
  ///
  /// In en, this message translates to:
  /// **'Sector'**
  String get sector;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @treasuryBillAbout.
  ///
  /// In en, this message translates to:
  /// **'Treasury Bills (T-Bills) are short-term government securities issued by the Government of Ghana to raise funds for government operations and manage cash flow. They are considered one of the safest investment options in Ghana.'**
  String get treasuryBillAbout;

  /// No description provided for @mutualFundAbout.
  ///
  /// In en, this message translates to:
  /// **'A mutual fund is an investment vehicle that pools money from multiple investors to invest in a diversified portfolio of stocks, bonds, or other securities. The fund is managed by professional fund managers who make investment decisions on behalf of the investors.'**
  String get mutualFundAbout;

  /// No description provided for @chooseOrderType.
  ///
  /// In en, this message translates to:
  /// **'Choose Order Type'**
  String get chooseOrderType;

  /// No description provided for @chooseHowExecute.
  ///
  /// In en, this message translates to:
  /// **'Choose how you want your order to be executed'**
  String get chooseHowExecute;

  /// No description provided for @marketOrderDesc.
  ///
  /// In en, this message translates to:
  /// **'Execute immediately at the best available price'**
  String get marketOrderDesc;

  /// No description provided for @limitOrderDesc.
  ///
  /// In en, this message translates to:
  /// **'Set your own price. The order only executes if the chosen price is reached'**
  String get limitOrderDesc;

  /// No description provided for @limitOrder.
  ///
  /// In en, this message translates to:
  /// **'Limit Order'**
  String get limitOrder;

  /// No description provided for @confirmDetailsBeforeBuy.
  ///
  /// In en, this message translates to:
  /// **'Confirm the details before you buy'**
  String get confirmDetailsBeforeBuy;

  /// No description provided for @confirmDetailsBeforeSell.
  ///
  /// In en, this message translates to:
  /// **'Confirm the details before you sell'**
  String get confirmDetailsBeforeSell;

  /// No description provided for @confirmDetailsBeforeProceeding.
  ///
  /// In en, this message translates to:
  /// **'Confirm the details before proceeding'**
  String get confirmDetailsBeforeProceeding;

  /// No description provided for @orderType.
  ///
  /// In en, this message translates to:
  /// **'Order Type'**
  String get orderType;

  /// No description provided for @orderPrice.
  ///
  /// In en, this message translates to:
  /// **'Order Price'**
  String get orderPrice;

  /// No description provided for @numberOfShares.
  ///
  /// In en, this message translates to:
  /// **'Number of Shares'**
  String get numberOfShares;

  /// No description provided for @currentPrice.
  ///
  /// In en, this message translates to:
  /// **'Current Price'**
  String get currentPrice;

  /// No description provided for @totalCharges.
  ///
  /// In en, this message translates to:
  /// **'Total Charges'**
  String get totalCharges;

  /// No description provided for @netConsideration.
  ///
  /// In en, this message translates to:
  /// **'Net Consideration'**
  String get netConsideration;

  /// No description provided for @availableCashBalance.
  ///
  /// In en, this message translates to:
  /// **'Available Cash balance'**
  String get availableCashBalance;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @orderSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Order Successful'**
  String get orderSuccessful;

  /// No description provided for @orderSubmittedBroker.
  ///
  /// In en, this message translates to:
  /// **'Your order request has been submitted to the Broker'**
  String get orderSubmittedBroker;

  /// No description provided for @orderSubmittedFundManager.
  ///
  /// In en, this message translates to:
  /// **'Your order request has been submitted to the Fund Manager'**
  String get orderSubmittedFundManager;

  /// No description provided for @trackInPortfolio.
  ///
  /// In en, this message translates to:
  /// **'Track in Portfolio'**
  String get trackInPortfolio;

  /// No description provided for @tradeOtherStocks.
  ///
  /// In en, this message translates to:
  /// **'Trade other stocks'**
  String get tradeOtherStocks;

  /// No description provided for @tradeOtherFunds.
  ///
  /// In en, this message translates to:
  /// **'Trade other funds'**
  String get tradeOtherFunds;

  /// No description provided for @tradeOtherSecurities.
  ///
  /// In en, this message translates to:
  /// **'Trade other securities'**
  String get tradeOtherSecurities;

  /// No description provided for @estimatedMaturityValue.
  ///
  /// In en, this message translates to:
  /// **'Estimated Maturity Value'**
  String get estimatedMaturityValue;

  /// No description provided for @availableCashBalanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Available Cash Balance'**
  String get availableCashBalanceTitle;

  /// No description provided for @noDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noDataAvailable;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @howMuchBuy.
  ///
  /// In en, this message translates to:
  /// **'How much do you want to buy?'**
  String get howMuchBuy;

  /// No description provided for @howMuchSell.
  ///
  /// In en, this message translates to:
  /// **'How much do you want to sell?'**
  String get howMuchSell;

  /// No description provided for @buySuccessful.
  ///
  /// In en, this message translates to:
  /// **'Buy Successful'**
  String get buySuccessful;

  /// No description provided for @sellSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Sell Successful'**
  String get sellSuccessful;

  /// No description provided for @sharesLabel.
  ///
  /// In en, this message translates to:
  /// **'Shares'**
  String get sharesLabel;

  /// No description provided for @assetType.
  ///
  /// In en, this message translates to:
  /// **'Asset Type'**
  String get assetType;

  /// No description provided for @bonds.
  ///
  /// In en, this message translates to:
  /// **'Bonds'**
  String get bonds;

  /// No description provided for @reits.
  ///
  /// In en, this message translates to:
  /// **'REITs'**
  String get reits;

  /// No description provided for @positive.
  ///
  /// In en, this message translates to:
  /// **'Positive'**
  String get positive;

  /// No description provided for @negative.
  ///
  /// In en, this message translates to:
  /// **'Negative'**
  String get negative;

  /// No description provided for @valueHighToLow.
  ///
  /// In en, this message translates to:
  /// **'Value (High to Low)'**
  String get valueHighToLow;

  /// No description provided for @valueLowToHigh.
  ///
  /// In en, this message translates to:
  /// **'Value (Low to High)'**
  String get valueLowToHigh;

  /// No description provided for @changePercentHighToLow.
  ///
  /// In en, this message translates to:
  /// **'Change % (High to Low)'**
  String get changePercentHighToLow;

  /// No description provided for @changePercentLowToHigh.
  ///
  /// In en, this message translates to:
  /// **'Change % (Low to High)'**
  String get changePercentLowToHigh;

  /// No description provided for @searchByAssetName.
  ///
  /// In en, this message translates to:
  /// **'Search by asset name'**
  String get searchByAssetName;

  /// No description provided for @dateOfIncorporation.
  ///
  /// In en, this message translates to:
  /// **'Date of Incorporation'**
  String get dateOfIncorporation;

  /// No description provided for @dateOfIPO.
  ///
  /// In en, this message translates to:
  /// **'Date of IPO'**
  String get dateOfIPO;

  /// No description provided for @telecommunications.
  ///
  /// In en, this message translates to:
  /// **'Telecommunications'**
  String get telecommunications;

  /// No description provided for @previousClose.
  ///
  /// In en, this message translates to:
  /// **'Previous Close(GHS)'**
  String get previousClose;

  /// No description provided for @openGHS.
  ///
  /// In en, this message translates to:
  /// **'Open(GHS)'**
  String get openGHS;

  /// No description provided for @daysRange.
  ///
  /// In en, this message translates to:
  /// **'Day\'s Range(GHS)'**
  String get daysRange;

  /// No description provided for @volumeTraded.
  ///
  /// In en, this message translates to:
  /// **'Volume Traded'**
  String get volumeTraded;

  /// No description provided for @fiftyTwoWeekRange.
  ///
  /// In en, this message translates to:
  /// **'52-Week Range(GHS)'**
  String get fiftyTwoWeekRange;

  /// No description provided for @peRatio.
  ///
  /// In en, this message translates to:
  /// **'P/E Ratio'**
  String get peRatio;

  /// No description provided for @earningsPerShare.
  ///
  /// In en, this message translates to:
  /// **'Earnings Per Share(GHS)'**
  String get earningsPerShare;

  /// No description provided for @dividendYield.
  ///
  /// In en, this message translates to:
  /// **'Dividend Yield'**
  String get dividendYield;

  /// No description provided for @marketCap.
  ///
  /// In en, this message translates to:
  /// **'Market Cap(GHS)'**
  String get marketCap;

  /// No description provided for @sharesOutstanding.
  ///
  /// In en, this message translates to:
  /// **'Shares Outstanding'**
  String get sharesOutstanding;

  /// No description provided for @capitalGainsLosses.
  ///
  /// In en, this message translates to:
  /// **'Capital Gains/(Losses)'**
  String get capitalGainsLosses;

  /// No description provided for @issuer.
  ///
  /// In en, this message translates to:
  /// **'Issuer'**
  String get issuer;

  /// No description provided for @governmentOfGhana.
  ///
  /// In en, this message translates to:
  /// **'Government of Ghana'**
  String get governmentOfGhana;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @ghs.
  ///
  /// In en, this message translates to:
  /// **'GHS'**
  String get ghs;

  /// No description provided for @maturityDate.
  ///
  /// In en, this message translates to:
  /// **'Maturity Date'**
  String get maturityDate;

  /// No description provided for @currentRate.
  ///
  /// In en, this message translates to:
  /// **'Current Rate'**
  String get currentRate;

  /// No description provided for @maturityRate.
  ///
  /// In en, this message translates to:
  /// **'Maturity Rate'**
  String get maturityRate;

  /// No description provided for @couponRate.
  ///
  /// In en, this message translates to:
  /// **'Coupon Rate'**
  String get couponRate;

  /// No description provided for @enterSharesPurchase.
  ///
  /// In en, this message translates to:
  /// **'Enter number of shares you want to purchase'**
  String get enterSharesPurchase;

  /// No description provided for @enterSharesSell.
  ///
  /// In en, this message translates to:
  /// **'Enter number of shares you want to sell'**
  String get enterSharesSell;

  /// No description provided for @enterAmountPurchase.
  ///
  /// In en, this message translates to:
  /// **'Enter the amount you want to purchase'**
  String get enterAmountPurchase;

  /// No description provided for @enterAmountSell.
  ///
  /// In en, this message translates to:
  /// **'Enter the amount you want to sell'**
  String get enterAmountSell;

  /// No description provided for @orderExecutedInstantly.
  ///
  /// In en, this message translates to:
  /// **'Your order will be executed instantly at the best available price'**
  String get orderExecutedInstantly;

  /// No description provided for @orderExecutedAtPrice.
  ///
  /// In en, this message translates to:
  /// **'Your order will be executed if the chosen price is reached'**
  String get orderExecutedAtPrice;

  /// No description provided for @enterOrderPrice.
  ///
  /// In en, this message translates to:
  /// **'Enter order price'**
  String get enterOrderPrice;

  /// No description provided for @percent25.
  ///
  /// In en, this message translates to:
  /// **'25%'**
  String get percent25;

  /// No description provided for @percent50.
  ///
  /// In en, this message translates to:
  /// **'50%'**
  String get percent50;

  /// No description provided for @percent75.
  ///
  /// In en, this message translates to:
  /// **'75%'**
  String get percent75;

  /// No description provided for @percent100.
  ///
  /// In en, this message translates to:
  /// **'100%'**
  String get percent100;

  /// No description provided for @enterUnitsPurchase.
  ///
  /// In en, this message translates to:
  /// **'Enter number of units you want to purchase'**
  String get enterUnitsPurchase;

  /// No description provided for @enterUnitsSell.
  ///
  /// In en, this message translates to:
  /// **'Enter number of units you want to sell'**
  String get enterUnitsSell;

  /// No description provided for @numberOfUnits.
  ///
  /// In en, this message translates to:
  /// **'Number of Units'**
  String get numberOfUnits;

  /// No description provided for @nav.
  ///
  /// In en, this message translates to:
  /// **'NAV'**
  String get nav;

  /// No description provided for @aum.
  ///
  /// In en, this message translates to:
  /// **'AUM'**
  String get aum;

  /// No description provided for @expenseRatio.
  ///
  /// In en, this message translates to:
  /// **'Expense Ratio'**
  String get expenseRatio;

  /// No description provided for @minimumInvestment.
  ///
  /// In en, this message translates to:
  /// **'Minimum Investment'**
  String get minimumInvestment;

  /// No description provided for @inceptionDate.
  ///
  /// In en, this message translates to:
  /// **'Inception Date'**
  String get inceptionDate;

  /// No description provided for @ytdReturn.
  ///
  /// In en, this message translates to:
  /// **'YTD Return'**
  String get ytdReturn;

  /// No description provided for @oneYearReturn.
  ///
  /// In en, this message translates to:
  /// **'1-Year Return'**
  String get oneYearReturn;

  /// No description provided for @threeYearReturn.
  ///
  /// In en, this message translates to:
  /// **'3-Year Return'**
  String get threeYearReturn;

  /// No description provided for @fiveYearReturn.
  ///
  /// In en, this message translates to:
  /// **'5-Year Return'**
  String get fiveYearReturn;

  /// No description provided for @tenYearReturn.
  ///
  /// In en, this message translates to:
  /// **'10-Year Return'**
  String get tenYearReturn;

  /// No description provided for @sinceInception.
  ///
  /// In en, this message translates to:
  /// **'Since Inception'**
  String get sinceInception;

  /// No description provided for @standardDeviation.
  ///
  /// In en, this message translates to:
  /// **'Standard Deviation'**
  String get standardDeviation;

  /// No description provided for @sharpeRatio.
  ///
  /// In en, this message translates to:
  /// **'Sharpe Ratio'**
  String get sharpeRatio;

  /// No description provided for @beta.
  ///
  /// In en, this message translates to:
  /// **'Beta'**
  String get beta;

  /// No description provided for @alpha.
  ///
  /// In en, this message translates to:
  /// **'Alpha'**
  String get alpha;

  /// No description provided for @rSquared.
  ///
  /// In en, this message translates to:
  /// **'R-Squared'**
  String get rSquared;

  /// No description provided for @turnoverRatio.
  ///
  /// In en, this message translates to:
  /// **'Turnover Ratio'**
  String get turnoverRatio;

  /// No description provided for @dateOfIpo.
  ///
  /// In en, this message translates to:
  /// **'Date of IPO'**
  String get dateOfIpo;

  /// No description provided for @fundType.
  ///
  /// In en, this message translates to:
  /// **'Fund Type'**
  String get fundType;

  /// No description provided for @managementFee.
  ///
  /// In en, this message translates to:
  /// **'Management Fee'**
  String get managementFee;

  /// No description provided for @annualizedReturns.
  ///
  /// In en, this message translates to:
  /// **'Annualized Returns'**
  String get annualizedReturns;

  /// No description provided for @averageGain.
  ///
  /// In en, this message translates to:
  /// **'Average Gain'**
  String get averageGain;

  /// No description provided for @averageLoss.
  ///
  /// In en, this message translates to:
  /// **'Average Loss'**
  String get averageLoss;

  /// No description provided for @maximumDrawdown.
  ///
  /// In en, this message translates to:
  /// **'Maximum Drawdown'**
  String get maximumDrawdown;

  /// No description provided for @sortinoRatio.
  ///
  /// In en, this message translates to:
  /// **'Sortino Ratio'**
  String get sortinoRatio;

  /// No description provided for @loads.
  ///
  /// In en, this message translates to:
  /// **'Loads'**
  String get loads;

  /// No description provided for @auctionMarket.
  ///
  /// In en, this message translates to:
  /// **'Auction Market'**
  String get auctionMarket;

  /// No description provided for @secondaryMarket.
  ///
  /// In en, this message translates to:
  /// **'Secondary Market'**
  String get secondaryMarket;

  /// No description provided for @treasuryBills.
  ///
  /// In en, this message translates to:
  /// **'Treasury Bills'**
  String get treasuryBills;

  /// No description provided for @bid.
  ///
  /// In en, this message translates to:
  /// **'Bid'**
  String get bid;

  /// No description provided for @searchLessons.
  ///
  /// In en, this message translates to:
  /// **'Search lessons'**
  String get searchLessons;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @auctionMarketClosed.
  ///
  /// In en, this message translates to:
  /// **'Auction Market Closed'**
  String get auctionMarketClosed;

  /// No description provided for @notifyWhenOpened.
  ///
  /// In en, this message translates to:
  /// **'Would you like to be notified when the market is opened?'**
  String get notifyWhenOpened;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @bidType.
  ///
  /// In en, this message translates to:
  /// **'Bid Type'**
  String get bidType;

  /// No description provided for @competitive.
  ///
  /// In en, this message translates to:
  /// **'Competitive'**
  String get competitive;

  /// No description provided for @nonCompetitive.
  ///
  /// In en, this message translates to:
  /// **'Non Competitive'**
  String get nonCompetitive;

  /// No description provided for @selectType.
  ///
  /// In en, this message translates to:
  /// **'Select Type'**
  String get selectType;

  /// No description provided for @previousRate.
  ///
  /// In en, this message translates to:
  /// **'Previous Rate'**
  String get previousRate;

  /// No description provided for @enterRate.
  ///
  /// In en, this message translates to:
  /// **'Enter Rate'**
  String get enterRate;

  /// No description provided for @enterYourRate.
  ///
  /// In en, this message translates to:
  /// **'Enter your rate'**
  String get enterYourRate;

  /// No description provided for @estimatedProceeds.
  ///
  /// In en, this message translates to:
  /// **'Estimated Proceeds'**
  String get estimatedProceeds;

  /// No description provided for @purchaseAmount.
  ///
  /// In en, this message translates to:
  /// **'Purchase Amount'**
  String get purchaseAmount;

  /// No description provided for @whatAmountBidFor.
  ///
  /// In en, this message translates to:
  /// **'What amount do you want to bid for?'**
  String get whatAmountBidFor;

  /// No description provided for @selectBroker.
  ///
  /// In en, this message translates to:
  /// **'Select Broker'**
  String get selectBroker;

  /// No description provided for @netProceeds.
  ///
  /// In en, this message translates to:
  /// **'Net Proceeds'**
  String get netProceeds;

  /// No description provided for @maturityValue.
  ///
  /// In en, this message translates to:
  /// **'Maturity Value'**
  String get maturityValue;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'it',
    'ja',
    'nl',
    'pt',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'nl':
      return AppLocalizationsNl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

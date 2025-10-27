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
  /// **'Link your accounts, track your portfolio, trade securities,\nand learn as you go — all in one secure app.'**
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
  /// **'Issue date'**
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

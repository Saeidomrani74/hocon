import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../core/constants/constants.dart';
import '../core/constants/database_constants.dart';

@Entity(
  tableName: kDeviceTable,
  /* indices: [
    Index(value: ['devicePhone'], unique: true)
  ], */
)
class Device extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String deviceName;
  final String devicePassword;
  //@ColumnInfo(name: 'devicePhone')
  final String devicePhone;
  final String deviceModel;
  final String deviceState;
  final bool isManager;
  final String alarmTime;
  final int remoteAmount;
  final int simChargeAmount;
  final int antennaAmount;
  final int batteryAmount;
  final bool cityPowerState;
  final bool gsmState;
  final bool speakerState;
  final bool networkState;
  final int capsulMax;
  final int capsulMin;
  final int totalContactsAmount;
  final int spyAmount;
  final int chargePeriodictReport;
  final int batteryPeriodictReport;
  final int callOrder;

  ///Buttons state
  final String operator;
  final String deviceLang;
  final String deviceSimLang;
  final bool silentOnSiren;
  final bool relayOnDingDong;
  final bool callOnPowerLoss;
  final bool manageWithContacts;

  ///Home visibility items
  final bool gsmStateVisibility;
  final bool remoteAmountVisibility;
  final bool antennaAmountVisibility;
  final bool contactsAmountVisibility;
  final bool networkStateVisibility;
  final bool batteryShapeVisibility;
  final bool zone1Visibility;
  final bool zone2Visibility;
  final bool zone3Visibility;
  final bool zone4Visibility;
  final bool zone5Visibility;
  final bool relay1Visibility;
  final bool relay2Visibility;
  final bool relay1SectionVisibility;
  final bool relay2SectionVisibility;
  final bool semiActiveVisibility;
  final bool silentVisibility;
  final bool spyVisibility;
  final bool relay1ActiveBtnVisibility;
  final bool relay2ActiveBtnVisibility;
  final bool relay1TriggerBtnVisibility;
  final bool relay2TriggerBtnVisibility;

  ///Relays
  /* final String relay1Name;
  final String relay1TriggerTime;
  final bool relay1State;
  final String relay2Name;
  final String relay2TriggerTime;
  final bool relay2State; */

  ///Zones
  final String zone1Name;
  final String zone1Condition;
  final bool zone1State;
  final String zone2Name;
  final String zone2Condition;
  final bool zone2State;
  final String zone3Name;
  final String zone3Condition;
  final bool zone3State;
  final String zone4Name;
  final String zone4Condition;
  final bool zone4State;
  final String zone5Name;
  final String zone5Condition;
  final bool zone5State;

  /// contacts
  final String contact1Name;
  final String contact1Phone;
  final bool contact1SMS;
  final bool contact1Call;
  final bool contact1Power;
  final bool contact1Speaker;
  final bool contact1SecretReport;
  final bool contact1Manager;
  final String contact2Name;
  final String contact2Phone;
  final bool contact2SMS;
  final bool contact2Call;
  final bool contact2Power;
  final bool contact2Speaker;
  final bool contact2SecretReport;
  final bool contact2Manager;
  final String contact3Name;
  final String contact3Phone;
  final bool contact3SMS;
  final bool contact3Call;
  final bool contact3Power;
  final bool contact3Speaker;
  final bool contact3SecretReport;
  final bool contact3Manager;
  final String contact4Name;
  final String contact4Phone;
  final bool contact4SMS;
  final bool contact4Call;
  final bool contact4Power;
  final bool contact4Speaker;
  final bool contact4SecretReport;
  final bool contact4Manager;
  final String contact5Name;
  final String contact5Phone;
  final bool contact5SMS;
  final bool contact5Call;
  final bool contact5Power;
  final bool contact5Speaker;
  final bool contact5SecretReport;
  final bool contact5Manager;
  final String contact6Name;
  final String contact6Phone;
  final bool contact6SMS;
  final bool contact6Call;
  final bool contact6Power;
  final bool contact6Speaker;
  final bool contact6SecretReport;
  final bool contact6Manager;
  final String contact7Name;
  final String contact7Phone;
  final bool contact7SMS;
  final bool contact7Call;
  final bool contact7Power;
  final bool contact7Speaker;
  final bool contact7SecretReport;
  final bool contact7Manager;
  final String contact8Name;
  final String contact8Phone;
  final bool contact8SMS;
  final bool contact8Call;
  final bool contact8Power;
  final bool contact8Speaker;
  final bool contact8SecretReport;
  final bool contact8Manager;
  final String contact9Name;
  final String contact9Phone;
  final bool contact9SMS;
  final bool contact9Call;
  final bool contact9Power;
  final bool contact9Speaker;
  final bool contact9SecretReport;
  final bool contact9Manager;

  const Device({
    this.id,
    this.deviceName = kDefaultDeviceName,
    this.devicePassword = kDefaultDevicePassword,
    this.devicePhone = '',
    this.deviceModel = kDefaultDeviceModel,
    this.deviceState = kDefaultState,
    this.isManager = true,
    this.alarmTime = kDefaultAlertTime,
    this.remoteAmount = 0,
    this.simChargeAmount = 0,
    this.antennaAmount = 0,
    this.batteryAmount = -1,
    this.cityPowerState = false,
    this.gsmState = false,
    this.speakerState = false,
    this.networkState = false,
    this.capsulMax = 20000,
    this.capsulMin = 2000,
    this.totalContactsAmount = 0,
    this.spyAmount = 15,
    this.chargePeriodictReport = 12,
    this.batteryPeriodictReport = 0,
    this.callOrder = 1,
    this.operator = '',
    this.deviceLang = '',
    this.deviceSimLang = '',
    this.silentOnSiren = false,
    this.relayOnDingDong = false,
    this.callOnPowerLoss = false,
    this.manageWithContacts = false,
    this.gsmStateVisibility = false,
    this.remoteAmountVisibility = false,
    this.antennaAmountVisibility = false,
    this.contactsAmountVisibility = false,
    this.batteryShapeVisibility = false,
    this.networkStateVisibility = false,
    this.zone1Visibility = false,
    this.zone2Visibility = false,
    this.zone3Visibility = false,
    this.zone4Visibility = false,
    this.zone5Visibility = false,
    this.relay1Visibility = false,
    this.relay2Visibility = false,
    this.relay1SectionVisibility = false,
    this.relay2SectionVisibility = false,
    this.semiActiveVisibility = false,
    this.silentVisibility = false,
    this.spyVisibility = false,
    this.relay1ActiveBtnVisibility = false,
    this.relay2ActiveBtnVisibility = false,
    this.relay1TriggerBtnVisibility = true,
    this.relay2TriggerBtnVisibility = true,
    /* this.relay1Name = kRelay1Name,
    this.relay1TriggerTime = kDefaultRelayTrigger,
    this.relay1State = false,
    this.relay2Name = kRelay2Name,
    this.relay2TriggerTime = kDefaultRelayTrigger,
    this.relay2State = false, */
    this.zone1Name = kZone1Name,
    this.zone1Condition = kDefaultZoneType,
    this.zone1State = false,
    this.zone2Name = kZone2Name,
    this.zone2Condition = kDefaultZoneType,
    this.zone2State = false,
    this.zone3Name = kZone3Name,
    this.zone3Condition = kDefaultZoneType,
    this.zone3State = false,
    this.zone4Name = kZone4Name,
    this.zone4Condition = kDefaultZoneType,
    this.zone4State = false,
    this.zone5Name = kZone5Name,
    this.zone5Condition = kDefaultZoneType,
    this.zone5State = false,
    this.contact1Name = kContact1Name,
    this.contact1Phone = '',
    this.contact1SMS = false,
    this.contact1Call = false,
    this.contact1Power = false,
    this.contact1Speaker = false,
    this.contact1SecretReport = false,
    this.contact1Manager = false,
    this.contact2Name = kContact2Name,
    this.contact2Phone = '',
    this.contact2SMS = false,
    this.contact2Call = false,
    this.contact2Power = false,
    this.contact2Speaker = false,
    this.contact2SecretReport = false,
    this.contact2Manager = false,
    this.contact3Name = kContact3Name,
    this.contact3Phone = '',
    this.contact3SMS = false,
    this.contact3Call = false,
    this.contact3Power = false,
    this.contact3Speaker = false,
    this.contact3SecretReport = false,
    this.contact3Manager = false,
    this.contact4Name = kContact4Name,
    this.contact4Phone = '',
    this.contact4SMS = false,
    this.contact4Call = false,
    this.contact4Power = false,
    this.contact4Speaker = false,
    this.contact4SecretReport = false,
    this.contact4Manager = false,
    this.contact5Name = kContact5Name,
    this.contact5Phone = '',
    this.contact5SMS = false,
    this.contact5Call = false,
    this.contact5Power = false,
    this.contact5Speaker = false,
    this.contact5SecretReport = false,
    this.contact5Manager = false,
    this.contact6Name = kContact6Name,
    this.contact6Phone = '',
    this.contact6SMS = false,
    this.contact6Call = false,
    this.contact6Power = false,
    this.contact6Speaker = false,
    this.contact6SecretReport = false,
    this.contact6Manager = false,
    this.contact7Name = kContact7Name,
    this.contact7Phone = '',
    this.contact7SMS = false,
    this.contact7Call = false,
    this.contact7Power = false,
    this.contact7Speaker = false,
    this.contact7SecretReport = false,
    this.contact7Manager = false,
    this.contact8Name = kContact8Name,
    this.contact8Phone = '',
    this.contact8SMS = false,
    this.contact8Call = false,
    this.contact8Power = false,
    this.contact8Speaker = false,
    this.contact8SecretReport = false,
    this.contact8Manager = false,
    this.contact9Name = kContact9Name,
    this.contact9Phone = '',
    this.contact9SMS = false,
    this.contact9Call = false,
    this.contact9Power = false,
    this.contact9Speaker = false,
    this.contact9SecretReport = false,
    this.contact9Manager = false,
  });

  @override
  List<Object?> get props => [
        id,
        deviceName,
        devicePassword,
        devicePhone,
        deviceModel,
        deviceState,
        isManager,
        alarmTime,
        remoteAmount,
        simChargeAmount,
        antennaAmount,
        batteryAmount,
        cityPowerState,
        gsmState,
        speakerState,
        networkState,
        capsulMax,
        capsulMin,
        totalContactsAmount,
        spyAmount,
        chargePeriodictReport,
        batteryPeriodictReport,
        callOrder,
        operator,
        deviceLang,
        deviceSimLang,
        silentOnSiren,
        relayOnDingDong,
        callOnPowerLoss,
        manageWithContacts,
        gsmStateVisibility,
        remoteAmountVisibility,
        antennaAmountVisibility,
        contactsAmountVisibility,
        batteryShapeVisibility,
        networkStateVisibility,
        zone1Visibility,
        zone2Visibility,
        zone3Visibility,
        zone4Visibility,
        zone5Visibility,
        relay1Visibility,
        relay2Visibility,
        relay1SectionVisibility,
        relay2SectionVisibility,
        semiActiveVisibility,
        silentVisibility,
        spyVisibility,
        relay1ActiveBtnVisibility,
        relay2ActiveBtnVisibility,
        relay1TriggerBtnVisibility,
        relay2TriggerBtnVisibility,
        /* relay1Name,
        relay1TriggerTime,
        relay1State,
        relay2Name,
        relay2TriggerTime,
        relay2State, */
        zone1Name,
        zone1Condition,
        zone1State,
        zone2Name,
        zone2Condition,
        zone2State,
        zone3Name,
        zone3Condition,
        zone3State,
        zone4Name,
        zone4Condition,
        zone4State,
        zone5Name,
        zone5Condition,
        zone5State,
        contact1Name,
        contact1Phone,
        contact1SMS,
        contact1Call,
        contact1Power,
        contact1Speaker,
        contact1SecretReport,
        contact1Manager,
        contact2Name,
        contact2Phone,
        contact2SMS,
        contact2Call,
        contact2Power,
        contact2Speaker,
        contact2SecretReport,
        contact2Manager,
        contact3Name,
        contact3Phone,
        contact3SMS,
        contact3Call,
        contact3Power,
        contact3Speaker,
        contact3SecretReport,
        contact3Manager,
        contact4Name,
        contact4Phone,
        contact4SMS,
        contact4Call,
        contact4Power,
        contact4Speaker,
        contact4SecretReport,
        contact4Manager,
        contact5Name,
        contact5Phone,
        contact5SMS,
        contact5Call,
        contact5Power,
        contact5Speaker,
        contact5SecretReport,
        contact5Manager,
        contact6Name,
        contact6Phone,
        contact6SMS,
        contact6Call,
        contact6Power,
        contact6Speaker,
        contact6SecretReport,
        contact6Manager,
        contact7Name,
        contact7Phone,
        contact7SMS,
        contact7Call,
        contact7Power,
        contact7Speaker,
        contact7SecretReport,
        contact7Manager,
        contact8Name,
        contact8Phone,
        contact8SMS,
        contact8Call,
        contact8Power,
        contact8Speaker,
        contact8SecretReport,
        contact8Manager,
        contact9Name,
        contact9Phone,
        contact9SMS,
        contact9Call,
        contact9Power,
        contact9Speaker,
        contact9SecretReport,
        contact9Manager,
      ];

  @override
  bool? get stringify => true;

  Device copyWith({
    int? id,
    String? deviceName,
    String? devicePassword,
    String? devicePhone,
    String? deviceModel,
    String? deviceState,
    bool? isManager,
    String? alarmTime,
    int? remoteAmount,
    int? simChargeAmount,
    int? antennaAmount,
    int? batteryAmount,
    bool? cityPowerState,
    bool? gsmState,
    bool? speakerState,
    bool? networkState,
    int? capsulMax,
    int? capsulMin,
    int? totalContactsAmount,
    int? spyAmount,
    int? chargePeriodictReport,
    int? batteryPeriodictReport,
    int? callOrder,
    String? operator,
    String? deviceLang,
    String? deviceSimLang,
    bool? silentOnSiren,
    bool? relayOnDingDong,
    bool? callOnPowerLoss,
    bool? manageWithContacts,
    bool? gsmStateVisibility,
    bool? remoteAmountVisibility,
    bool? antennaAmountVisibility,
    bool? contactsAmountVisibility,
    bool? networkStateVisibility,
    bool? batteryShapeVisibility,
    bool? zone1Visibility,
    bool? zone2Visibility,
    bool? zone3Visibility,
    bool? zone4Visibility,
    bool? zone5Visibility,
    bool? relay1Visibility,
    bool? relay2Visibility,
    bool? relay1SectionVisibility,
    bool? relay2SectionVisibility,
    bool? semiActiveVisibility,
    bool? silentVisibility,
    bool? spyVisibility,
    bool? relay1ActiveBtnVisibility,
    bool? relay2ActiveBtnVisibility,
    bool? relay1TriggerBtnVisibility,
    bool? relay2TriggerBtnVisibility,
    /* String? relay1Name,
    String? relay1TriggerTime,
    bool? relay1State,
    String? relay2Name,
    String? relay2TriggerTime,
    bool? relay2State, */
    String? zone1Name,
    String? zone1Condition,
    bool? zone1State,
    String? zone2Name,
    String? zone2Condition,
    bool? zone2State,
    String? zone3Name,
    String? zone3Condition,
    bool? zone3State,
    String? zone4Name,
    String? zone4Condition,
    bool? zone4State,
    String? zone5Name,
    String? zone5Condition,
    bool? zone5State,
    String? contact1Name,
    String? contact1Phone,
    bool? contact1SMS,
    bool? contact1Call,
    bool? contact1Power,
    bool? contact1Speaker,
    bool? contact1SecretReport,
    bool? contact1Manager,
    String? contact2Name,
    String? contact2Phone,
    bool? contact2SMS,
    bool? contact2Call,
    bool? contact2Power,
    bool? contact2Speaker,
    bool? contact2SecretReport,
    bool? contact2Manager,
    String? contact3Name,
    String? contact3Phone,
    bool? contact3SMS,
    bool? contact3Call,
    bool? contact3Power,
    bool? contact3Speaker,
    bool? contact3SecretReport,
    bool? contact3Manager,
    String? contact4Name,
    String? contact4Phone,
    bool? contact4SMS,
    bool? contact4Call,
    bool? contact4Power,
    bool? contact4Speaker,
    bool? contact4SecretReport,
    bool? contact4Manager,
    String? contact5Name,
    String? contact5Phone,
    bool? contact5SMS,
    bool? contact5Call,
    bool? contact5Power,
    bool? contact5Speaker,
    bool? contact5SecretReport,
    bool? contact5Manager,
    String? contact6Name,
    String? contact6Phone,
    bool? contact6SMS,
    bool? contact6Call,
    bool? contact6Power,
    bool? contact6Speaker,
    bool? contact6SecretReport,
    bool? contact6Manager,
    String? contact7Name,
    String? contact7Phone,
    bool? contact7SMS,
    bool? contact7Call,
    bool? contact7Power,
    bool? contact7Speaker,
    bool? contact7SecretReport,
    bool? contact7Manager,
    String? contact8Name,
    String? contact8Phone,
    bool? contact8SMS,
    bool? contact8Call,
    bool? contact8Power,
    bool? contact8Speaker,
    bool? contact8SecretReport,
    bool? contact8Manager,
    String? contact9Name,
    String? contact9Phone,
    bool? contact9SMS,
    bool? contact9Call,
    bool? contact9Power,
    bool? contact9Speaker,
    bool? contact9SecretReport,
    bool? contact9Manager,
  }) {
    return Device(
      id: id ?? this.id,
      deviceName: deviceName ?? this.deviceName,
      devicePassword: devicePassword ?? this.devicePassword,
      devicePhone: devicePhone ?? this.devicePhone,
      deviceModel: deviceModel ?? this.deviceModel,
      deviceState: deviceState ?? this.deviceState,
      isManager: isManager ?? this.isManager,
      alarmTime: alarmTime ?? this.alarmTime,
      remoteAmount: remoteAmount ?? this.remoteAmount,
      simChargeAmount: simChargeAmount ?? this.simChargeAmount,
      antennaAmount: antennaAmount ?? this.antennaAmount,
      batteryAmount: batteryAmount ?? this.batteryAmount,
      cityPowerState: cityPowerState ?? this.cityPowerState,
      gsmState: gsmState ?? this.gsmState,
      speakerState: speakerState ?? this.speakerState,
      networkState: networkState ?? this.networkState,
      capsulMax: capsulMax ?? this.capsulMax,
      capsulMin: capsulMin ?? this.capsulMin,
      totalContactsAmount: totalContactsAmount ?? this.totalContactsAmount,
      spyAmount: spyAmount ?? this.spyAmount,
      chargePeriodictReport:
          chargePeriodictReport ?? this.chargePeriodictReport,
      batteryPeriodictReport:
          batteryPeriodictReport ?? this.batteryPeriodictReport,
      callOrder: callOrder ?? this.callOrder,
      operator: operator ?? this.operator,
      deviceLang: deviceLang ?? this.deviceLang,
      deviceSimLang: deviceSimLang ?? this.deviceSimLang,
      silentOnSiren: silentOnSiren ?? this.silentOnSiren,
      relayOnDingDong: relayOnDingDong ?? this.relayOnDingDong,
      callOnPowerLoss: callOnPowerLoss ?? this.callOnPowerLoss,
      manageWithContacts: manageWithContacts ?? this.manageWithContacts,
      gsmStateVisibility: gsmStateVisibility ?? this.gsmStateVisibility,
      remoteAmountVisibility:
          remoteAmountVisibility ?? this.remoteAmountVisibility,
      antennaAmountVisibility:
          antennaAmountVisibility ?? this.antennaAmountVisibility,
      contactsAmountVisibility:
          contactsAmountVisibility ?? this.contactsAmountVisibility,
      networkStateVisibility:
          networkStateVisibility ?? this.networkStateVisibility,
      batteryShapeVisibility:
          batteryShapeVisibility ?? this.batteryShapeVisibility,
      zone1Visibility: zone1Visibility ?? this.zone1Visibility,
      zone2Visibility: zone2Visibility ?? this.zone2Visibility,
      zone3Visibility: zone3Visibility ?? this.zone3Visibility,
      zone4Visibility: zone4Visibility ?? this.zone4Visibility,
      zone5Visibility: zone5Visibility ?? this.zone5Visibility,
      relay1Visibility: relay1Visibility ?? this.relay1Visibility,
      relay2Visibility: relay2Visibility ?? this.relay2Visibility,
      relay1SectionVisibility:
          relay1SectionVisibility ?? this.relay1SectionVisibility,
      relay2SectionVisibility:
          relay2SectionVisibility ?? this.relay2SectionVisibility,
      semiActiveVisibility: semiActiveVisibility ?? this.semiActiveVisibility,
      silentVisibility: silentVisibility ?? this.silentVisibility,
      spyVisibility: spyVisibility ?? this.spyVisibility,
      relay1ActiveBtnVisibility:
          relay1ActiveBtnVisibility ?? this.relay1ActiveBtnVisibility,
      relay2ActiveBtnVisibility:
          relay2ActiveBtnVisibility ?? this.relay2ActiveBtnVisibility,
      relay1TriggerBtnVisibility:
          relay1TriggerBtnVisibility ?? this.relay1TriggerBtnVisibility,
      relay2TriggerBtnVisibility:
          relay2TriggerBtnVisibility ?? this.relay2TriggerBtnVisibility,
      /* relay1Name: relay1Name ?? this.relay1Name,
      relay1TriggerTime: relay1TriggerTime ?? this.relay1TriggerTime,
      relay1State: relay1State ?? this.relay1State,
      relay2Name: relay2Name ?? this.relay2Name,
      relay2TriggerTime: relay2TriggerTime ?? this.relay2TriggerTime,
      relay2State: relay2State ?? this.relay2State, */
      zone1Name: zone1Name ?? this.zone1Name,
      zone1Condition: zone1Condition ?? this.zone1Condition,
      zone1State: zone1State ?? this.zone1State,
      zone2Name: zone2Name ?? this.zone2Name,
      zone2Condition: zone2Condition ?? this.zone2Condition,
      zone2State: zone2State ?? this.zone2State,
      zone3Name: zone3Name ?? this.zone3Name,
      zone3Condition: zone3Condition ?? this.zone3Condition,
      zone3State: zone3State ?? this.zone3State,
      zone4Name: zone4Name ?? this.zone4Name,
      zone4Condition: zone4Condition ?? this.zone4Condition,
      zone4State: zone4State ?? this.zone4State,
      zone5Name: zone5Name ?? this.zone5Name,
      zone5Condition: zone5Condition ?? this.zone5Condition,
      zone5State: zone5State ?? this.zone5State,
      contact1Name: contact1Name ?? this.contact1Name,
      contact1Phone: contact1Phone ?? this.contact1Phone,
      contact1SMS: contact1SMS ?? this.contact1SMS,
      contact1Call: contact1Call ?? this.contact1Call,
      contact1Power: contact1Power ?? this.contact1Power,
      contact1Speaker: contact1Speaker ?? this.contact1Speaker,
      contact1SecretReport: contact1SecretReport ?? this.contact1SecretReport,
      contact1Manager: contact1Manager ?? this.contact1Manager,
      contact2Name: contact2Name ?? this.contact2Name,
      contact2Phone: contact2Phone ?? this.contact2Phone,
      contact2SMS: contact2SMS ?? this.contact2SMS,
      contact2Call: contact2Call ?? this.contact2Call,
      contact2Power: contact2Power ?? this.contact2Power,
      contact2Speaker: contact2Speaker ?? this.contact2Speaker,
      contact2SecretReport: contact2SecretReport ?? this.contact2SecretReport,
      contact2Manager: contact2Manager ?? this.contact2Manager,
      contact3Name: contact3Name ?? this.contact3Name,
      contact3Phone: contact3Phone ?? this.contact3Phone,
      contact3SMS: contact3SMS ?? this.contact3SMS,
      contact3Call: contact3Call ?? this.contact3Call,
      contact3Power: contact3Power ?? this.contact3Power,
      contact3Speaker: contact3Speaker ?? this.contact3Speaker,
      contact3SecretReport: contact3SecretReport ?? this.contact3SecretReport,
      contact3Manager: contact3Manager ?? this.contact3Manager,
      contact4Name: contact4Name ?? this.contact4Name,
      contact4Phone: contact4Phone ?? this.contact4Phone,
      contact4SMS: contact4SMS ?? this.contact4SMS,
      contact4Call: contact4Call ?? this.contact4Call,
      contact4Power: contact4Power ?? this.contact4Power,
      contact4Speaker: contact4Speaker ?? this.contact4Speaker,
      contact4SecretReport: contact4SecretReport ?? this.contact4SecretReport,
      contact4Manager: contact4Manager ?? this.contact4Manager,
      contact5Name: contact5Name ?? this.contact5Name,
      contact5Phone: contact5Phone ?? this.contact5Phone,
      contact5SMS: contact5SMS ?? this.contact5SMS,
      contact5Call: contact5Call ?? this.contact5Call,
      contact5Power: contact5Power ?? this.contact5Power,
      contact5Speaker: contact5Speaker ?? this.contact5Speaker,
      contact5SecretReport: contact5SecretReport ?? this.contact5SecretReport,
      contact5Manager: contact5Manager ?? this.contact5Manager,
      contact6Name: contact6Name ?? this.contact6Name,
      contact6Phone: contact6Phone ?? this.contact6Phone,
      contact6SMS: contact6SMS ?? this.contact6SMS,
      contact6Call: contact6Call ?? this.contact6Call,
      contact6Power: contact6Power ?? this.contact6Power,
      contact6Speaker: contact6Speaker ?? this.contact6Speaker,
      contact6SecretReport: contact6SecretReport ?? this.contact6SecretReport,
      contact6Manager: contact6Manager ?? this.contact6Manager,
      contact7Name: contact7Name ?? this.contact7Name,
      contact7Phone: contact7Phone ?? this.contact7Phone,
      contact7SMS: contact7SMS ?? this.contact7SMS,
      contact7Call: contact7Call ?? this.contact7Call,
      contact7Power: contact7Power ?? this.contact7Power,
      contact7Speaker: contact7Speaker ?? this.contact7Speaker,
      contact7SecretReport: contact7SecretReport ?? this.contact7SecretReport,
      contact7Manager: contact7Manager ?? this.contact7Manager,
      contact8Name: contact8Name ?? this.contact8Name,
      contact8Phone: contact8Phone ?? this.contact8Phone,
      contact8SMS: contact8SMS ?? this.contact8SMS,
      contact8Call: contact8Call ?? this.contact8Call,
      contact8Power: contact8Power ?? this.contact8Power,
      contact8Speaker: contact8Speaker ?? this.contact8Speaker,
      contact8SecretReport: contact8SecretReport ?? this.contact8SecretReport,
      contact8Manager: contact8Manager ?? this.contact8Manager,
      contact9Name: contact9Name ?? this.contact9Name,
      contact9Phone: contact9Phone ?? this.contact9Phone,
      contact9SMS: contact9SMS ?? this.contact9SMS,
      contact9Call: contact9Call ?? this.contact9Call,
      contact9Power: contact9Power ?? this.contact9Power,
      contact9Speaker: contact9Speaker ?? this.contact9Speaker,
      contact9SecretReport: contact9SecretReport ?? this.contact9SecretReport,
      contact9Manager: contact9Manager ?? this.contact9Manager,
    );
  }
}

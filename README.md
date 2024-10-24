# ProgCharge
ProgCharge is a command-line tool to configure some charging features on supported devices.

## Installation
1. **Install Module:**
Install `PCH.2.0.x.Beta.zip` using a root manager app like Magisk, KernelSU, or Apatch.
2. **Reboot Device:**
Reboot your device.
3. Configure Charging Settings:
Use the following command to configure charging settings:
```bash
su-c PCH
```

## Usage

Upon running the program, the user will see a menu with options to:

- [1] Set Charging Current
- [2] Set Bypass Charging
- [3] Set Charging Temperature Limit
- [0] Exit

Follow the prompts to configure the charging settings.

## Important Note
Ensure that the default Android fast charging setting is enabled before using ProgCharge. This tool is designed to enhance the existing fast charging functionality.

## Changelog (v1.5 > v2.0)
- Added new paths to detect charging current and voltage for more devices.
- Showed maximum values for charging current, voltage, and temperature.
- Changed display from amperes (A) to watts (W) and milliamperes (mA) with better accuracy.
- Increased charging current options from 15 to 30 levels.
- Fixed issues with setting voltage on some devices.

### More Information
**Author:**
[RiProG](https://github.com/RiProG-id)

**Visit:**
[Support ME](https://t.me/RiOpSo/2848)
[Telegram Channel](https://t.me/RiOpSo)
[Telegram Group](https://t.me/RiOpSoDisc)
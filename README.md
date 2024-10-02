# ProgCharge
ProgCharge is a command-line tool to configure some charging features on supported devices.

## Installation
1. **Install Module:**
Install `PCH.1.5.x.Stable.zip` using a root manager app like Magisk, KernelSU, or Apatch.
2. **Reboot Device:**
Reboot your device.
3. Configure Charging Settings:
Use the following command to configure charging settings:
```bash
su-c PCH
```

## Usage
Upon running the program, the user will see a menu with options to:
1. Set FastCharging Current
2. Set bypass charging
3. Set the charging temperature limit.
4. Exit

Follow the prompts to configure the charging settings.

## Important Note
Ensure that the default Android fast charging setting is enabled before using ProgCharge. This tool is designed to enhance the existing fast charging functionality.

## Changelog (v1.0 > v1.5)
- Added temperature limit configuration.
- Implemented Compatibility Check.
- Implemented auto-cancel of installation.
- Split functionality into two methods: ampere and watt.
- Simplified success and error output messages.
- Streamlined interface display.
- Added initial value check at startup.
- Fixed module updater.
- Various bug fixes and improvements.

### More Information
**Author:**
[RiProG](https://github.com/RiProG-id)

**Visit:**
[Support ME](https://t.me/RiOpSo/2848)
[Telegram Channel](https://t.me/RiOpSo)
[Telegram Group](https://t.me/RiOpSoDisc)
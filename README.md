# ProgCharge

ProgCharge is a tool designed to configure and optimize charging settings on supported Android devices through a user-friendly WebUI.

## Installation

1. **Install Module:**  
   Install `PCH.3.0.Latest.zip` using a root manager app like Magisk, KernelSU, or Apatch.
2. **Reboot Device:**  
   Restart your device after installing the module.
3. **Install WebUI (Optional):**  
   Download and install [KsuWebUIStandalone](https://github.com/5ec1cff/KsuWebUIStandalone/releases). This step is optional and only needed if your device supports WebUI. If WebUI is not supported, simply install the app and proceed with the configuration.

## Usage

After opening the WebUI app, users can select the option to:

- **Choose Charging Wattage**

Alternatively, you can use the WebUI or action button as a shortcut to open the menu and adjust the charging settings quickly. Follow the instructions in the WebUI to adjust charging settings as needed.

## Important Note

Ensure that the default Android fast charging setting is enabled before using ProgCharge. This tool is designed to enhance the existing fast charging functionality.

**Paths Required for Support:**

One of the following paths must exist on your device to support charging optimization:

- `/sys/class/power_supply/*/constant_charge_current_max`
- `/sys/class/power_supply/*/input_current_limit`
- `/sys/class/power_supply/*/input_voltage_limit`

If one of these paths is available, ProgCharge will be able to configure your device's charging settings.

## Changelog (v2.1 > v3.0)

- Simplified by removing some features
- Introduced a new WebUI with a more intuitive design
- Added a new method for support detection

## More Information

**Author:** [RiProG](https://github.com/RiProG-id)

### Visit:

- [Support ME](https://t.me/RiOpSo/2848)
- [Telegram Channel](https://t.me/RiOpSo)
- [Telegram Group](https://t.me/RiOpSoDisc)

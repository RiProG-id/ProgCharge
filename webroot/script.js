const wattages = {
  1: 10,
  2: 13,
  3: 18,
  4: 22,
  5: 28,
  6: 33,
  7: 40,
  8: 46,
  9: 54,
  10: 61,
  11: 70,
  12: 78,
  13: 88,
  14: 97,
  15: 108,
};

const amperes = {
  1: 2000,
  2: 2500,
  3: 3000,
  4: 3500,
  5: 4000,
  6: 4500,
  7: 5000,
  8: 5500,
  9: 6000,
  10: 6500,
  11: 7000,
  12: 7500,
  13: 8000,
  14: 8500,
  15: 9000,
};

const checkVoltagePath = () => {
  try {
    const command =
      'for path in /sys/class/power_supply/*/input_voltage_limit; do echo "Found"; break; done';
    if (typeof ksu !== "undefined" && typeof ksu.exec === "function") {
      const result = ksu.exec(command);
      if (result.stdout.includes("Found")) {
        displayAmperes();
      } else {
        displayWattages();
      }
    }
  } catch (error) {}
};

const handleSelection = (selection) => {
  const pleaseWaitMessage = document.getElementById("please-wait");
  const buttons = document.querySelectorAll(".watt-button");

  buttons.forEach((button) => (button.disabled = true));
  pleaseWaitMessage.style.display = "block";

  setTimeout(() => {
    pleaseWaitMessage.style.display = "none";
    buttons.forEach((button) => (button.disabled = false));
  }, 5000);

  try {
    const command = `sh /data/adb/modules/PCH/PCH ${selection}`;
    if (typeof ksu !== "undefined" && typeof ksu.exec === "function") {
      ksu.exec(command);
    }
  } catch (error) {}
};

const displayWattages = () => {
  const buttonsContainer = document.getElementById("buttons-container");
  buttonsContainer.innerHTML = "";
  Object.keys(wattages).forEach((key) => {
    const button = document.createElement("button");
    button.classList.add("watt-button");
    button.textContent = `${wattages[key]}W`;
    button.setAttribute("data-watt", key);
    button.addEventListener("click", () => handleSelection(key));
    buttonsContainer.appendChild(button);
  });
};

const displayAmperes = () => {
  const buttonsContainer = document.getElementById("buttons-container");
  buttonsContainer.innerHTML = "";
  Object.keys(amperes).forEach((key) => {
    const button = document.createElement("button");
    button.classList.add("watt-button");
    button.textContent = `${amperes[key]}mA`;
    button.setAttribute("data-watt", key);
    button.addEventListener("click", () => handleSelection(key));
    buttonsContainer.appendChild(button);
  });
};

document.addEventListener("DOMContentLoaded", () => {
  checkVoltagePath();
});

const miliAmperes = {
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

const displayMiliAmperes = () => {
  const buttonsContainer = document.getElementById("buttons-container");
  buttonsContainer.innerHTML = "";

  Object.keys(miliAmperes).forEach((key) => {
    const button = document.createElement("button");
    button.classList.add("watt-button");
    button.textContent = `${miliAmperes[key]}mA`;
    button.setAttribute("data-amp", key);
    button.addEventListener("click", () => handleSelection(key));
    buttonsContainer.appendChild(button);
  });
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

document.addEventListener("DOMContentLoaded", () => {
  displayMiliAmperes();
});

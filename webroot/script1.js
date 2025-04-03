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
  displayWattages();
});

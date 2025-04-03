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

const handleWattSelection = (selection) => {
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

document.querySelectorAll(".watt-button").forEach((button) => {
  button.addEventListener("click", () => {
    const wattage = button.getAttribute("data-watt");
    handleWattSelection(wattage);
  });
});
